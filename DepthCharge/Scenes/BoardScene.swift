//
//  MainScene.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import GameplayKit
import SpriteKit
import os

class BoardScene: GameScene, Alertable {

  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "BoardScene")

  private static let TOTAL_BOMBS = 20
  private static let TOTAL_ROWS = 15
  private static let TOTAL_COLUMNS = 10

  let rows = TOTAL_ROWS
  let cols = TOTAL_COLUMNS
  let tileSize: CGFloat = 32.0
  var tiles: [[TileNode]] = []
  var totalBombs = 40
  {
    didSet {
      mineCountLabel.text = "Mines: \(totalBombs)"
    }
  }

  var totalMarked = 0 {
    didSet {
      markedCountLabel.text = "Marked: \(totalMarked)"
    }
  }

  var bombsPlaced = 0

  var markMode = false {
    didSet {
      if markMode {
        markButton.actionType = .happy
        markButton.skLabel.text = "Mark: On"
      } else {
        markButton.actionType = .normal
        markButton.skLabel.text = "Mark: Off"
      }
    }
  }

  var cheatMode = false {
    didSet {
      if cheatMode {
        cheatButton.actionType = .happy
        cheatButton.skLabel.text = "Cheat: On"
        for row in 0..<rows {
          for col in 0..<cols {
            if tiles[row][col].hasBomb && (tiles[row][col].state == .hidden || tiles[row][col].state == .marked) {
              tiles[row][col].bombSpriteNode.isHidden = false
              tiles[row][col].bombSpriteNode.alpha = 0.5
            }
          }
        }
      } else {
        cheatButton.actionType = .normal
        cheatButton.skLabel.text = "Cheat: Off"
        for row in 0..<rows {
          for col in 0..<cols {
            if tiles[row][col].hasBomb && (tiles[row][col].state == .hidden || tiles[row][col].state == .marked) {
              tiles[row][col].bombSpriteNode.isHidden = true
              tiles[row][col].bombSpriteNode.alpha = 1
            }
          }
        }
      }
    }
  }

  let gridNode = SKSpriteNode()

  let gameOverLabel = SKLabelNode(text: "Game Over")
  let mineCountLabel = SKLabelNode(text: "Mines: 0")
  let markedCountLabel = SKLabelNode(text: "Marked: 0")

  let replayButton = ShapeButton("ReplayButton", buttonText: "Replay")
  let markButton = ShapeButton("MarkButton", buttonText: "Mark: Off")
  let cheatButton = ShapeButton("CheatButton", buttonText: "Cheat: Off")

  override init(size: CGSize, stateMachine: SceneStateMachine) {
    super.init(size: size, stateMachine: stateMachine)
  }

  override func didMove(to view: SKView) {
    super.didMove(to: view)

    backgroundColor = UIColor.appMedium

    let titleLabel = SKLabelNode(text: "Board Scene")
    titleLabel.fontName = AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME_BOLD)
    titleLabel.fontColor = .white
    titleLabel.fontSize = 40
    titleLabel.position = CGPoint(
      x: (size.width - view.safeAreaInsets.left + 30) / 2,
      y: size.height - view.safeAreaInsets.top - titleLabel.frame.size.height)
    addChild(titleLabel)

    let mainButton = SpriteButton("MainButton", systemName: "house.circle", color: .appLightest)
    mainButton.position = CGPoint(x: view.safeAreaInsets.left + 30, y: size.height - view.safeAreaInsets.top - 20)
    mainButton.color = .appAngry
    addChild(mainButton)

    let helpButton = SpriteButton("HelpButton", systemName: "questionmark.circle", color: .appLightest)
    helpButton.position = CGPoint(x: mainButton.position.x, y: mainButton.position.y - 40)
    addChild(helpButton)

    let settingsButton = SpriteButton("SettingsButton", systemName: "gearshape.circle", color: .appLightest)
    settingsButton.position = CGPoint(x: helpButton.position.x, y: helpButton.position.y - 40)
    addChild(settingsButton)

    addChild(gridNode)

    gameOverLabel.isHidden = true
    gameOverLabel.fontName = AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME_BOLD)
    gameOverLabel.fontColor = .white
    gameOverLabel.fontSize = 40
    gameOverLabel.position = CGPoint(
      x: size.width / 2,
      y: titleLabel.position.y - titleLabel.frame.size.height - 10)
    addChild(gameOverLabel)

    mineCountLabel.isHidden = false
    mineCountLabel.fontName = AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME_BOLD)
    mineCountLabel.fontColor = .white
    mineCountLabel.fontSize = AppPrefs.shared.getDouble(Category.general, AppPrefs.FONT_SIZE)
    mineCountLabel.position = CGPoint(
      x: size.width * 0.333,
      y: titleLabel.position.y - titleLabel.frame.size.height - 50)
    addChild(mineCountLabel)

    markedCountLabel.isHidden = false
    markedCountLabel.fontName = AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME_BOLD)
    markedCountLabel.fontColor = .white
    markedCountLabel.fontSize = AppPrefs.shared.getDouble(Category.general, AppPrefs.FONT_SIZE)
    markedCountLabel.position = CGPoint(
      x: size.width * 0.666,
      y: titleLabel.position.y - titleLabel.frame.size.height - 50)
    addChild(markedCountLabel)

    replayButton.position = CGPoint(x: size.width / 2, y: replayButton.size.height + 100)
    replayButton.isHidden = true
    addChild(replayButton)

    markButton.position = CGPoint(x: size.width / 2, y: markButton.size.height + 100)
    markButton.isHidden = false
    addChild(markButton)

    cheatButton.position = CGPoint(x: size.width / 2, y: markButton.size.height + 50)
    cheatButton.isHidden = false
    addChild(cheatButton)

    resetGame()
  }

  func resetGame() {
    createGrid()
    totalBombs = [BoardScene.TOTAL_BOMBS, BoardScene.TOTAL_ROWS * BoardScene.TOTAL_COLUMNS].min()!
    totalMarked = 0
    placeBombs(totalBombs)
    gameOverLabel.isHidden = true
    replayButton.isHidden = true
    markButton.isHidden = false
    markMode = false
    cheatMode = false
    calculateNeighbors()
  }

  func gameOverLogic(lost: Bool) {
    if lost {
      gameOverLabel.fontColor = .appAngry
      gameOverLabel.text = "You Lost!"
    } else {
      gameOverLabel.fontColor = .white
      gameOverLabel.text = "You Win!"
    }
    for row in 0..<rows {
      for col in 0..<cols {
        tiles[row][col].reveal()
      }
    }
    gameOverLabel.isHidden = false
    replayButton.isHidden = false
    markButton.isHidden = true
  }

  func createGrid() {
    tiles = []
    let gridSize = CGSize(width: tileSize * CGFloat(cols), height: tileSize * CGFloat(rows))
    let gridPosition = CGPoint(x: (size.width - gridSize.width) / 2, y: (size.height - gridSize.height) / 2)

    gridNode.position = gridPosition
    gridNode.zPosition = -1

    for row in 0..<rows {
      var rowArray: [TileNode] = []
      for col in 0..<cols {
        let tile = TileNode(size: CGSize(width: tileSize, height: tileSize))
        tile.position = CGPoint(
          x: CGFloat(col) * tileSize + tileSize / 2,
          y: CGFloat(row) * tileSize + tileSize / 2
        )
        tile.row = row
        tile.col = col

        gridNode.addChild(tile)

        rowArray.append(tile)
      }
      tiles.append(rowArray)
    }
  }

  func placeBombs(_ totalBombs: Int) {
    bombsPlaced = 0
    while bombsPlaced < totalBombs {
      let row = Int.random(in: 0..<rows)
      let col = Int.random(in: 0..<cols)
      if !tiles[row][col].hasBomb {
        tiles[row][col].hasBomb = true
        bombsPlaced += 1
      }
    }
  }

  func calculateNeighbors() {
    for row in 0..<rows {
      for col in 0..<cols {
        guard !tiles[row][col].hasBomb else { continue }
        var count = 0
        for deltaRow in -1...1 {
          for deltaCol in -1...1 {
            let neighborRow = row + deltaRow
            let neighborCol = col + deltaCol
            // if row and column are valid (ie not outside the array)
            if (0..<rows).contains(neighborRow), (0..<cols).contains(neighborCol),
              tiles[neighborRow][neighborCol].hasBomb
            {
              count += 1
            }
          }
        }
        tiles[row][col].neighborBombs = count
      }
    }
  }

  func revealNeighbors(from tile: TileNode) {
    let row = tile.row
    let col = tile.col
    for deltaRow in -1...1 {
      for deltaCol in -1...1 {
        let neighborRow = row + deltaRow
        let neighborCol = col + deltaCol
        if (0..<rows).contains(neighborRow), (0..<cols).contains(neighborCol) {
          let neighbor = tiles[neighborRow][neighborCol]
          if neighbor.state == .hidden && !neighbor.hasBomb {
            neighbor.reveal()
            if neighbor.neighborBombs == 0 {
              revealNeighbors(from: neighbor)
            }
          }
        }
      }
    }
  }

  func checkForWin() {
    let totalSafe = rows * cols - totalBombs
    let revealedSafe = tiles.joined().filter { !$0.hasBomb && $0.state == .revealed }.count
    if revealedSafe == totalSafe {
      gameOverLogic(lost: false)
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
  }

  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    guard let touch = touches.first else { return }

    let location = touch.location(in: self)
    guard let tile = nodes(at: location).compactMap({ $0 as? TileNode }).first else { return }

    // If we're in Mark mode, toggle the flag and bail
    if markMode {
      tile.toggleMark()
      totalMarked = tiles.joined().filter { $0.state == .marked }.count
      return
    }

    // Ignore taps on already revealed tiles (unless you want chord behavior later)
    if tile.state != .hidden { return }

    // Reveal and resolve
    tile.reveal()

    if tile.hasBomb {
      tile.color = .appAngry
      gameOverLogic(lost: true)
      return
    }

    if tile.neighborBombs == 0 {
      revealNeighbors(from: tile)
    }

    checkForWin()
  }

  override func buttonAction(name: String) {
    switch name {
    case "ReplayButton":
      resetGame()
    case "MarkButton":
      markMode = !markMode
    case "CheatButton":
      cheatMode = !cheatMode
    case "HelpButton":
      sceneStateMachine?.enter(HelpState.self)
    case "SettingsButton":
      sceneStateMachine?.enter(SettingsState.self)
    case "MainButton":
      logger.debug("Menu")
      sceneStateMachine?.enter(MainState.self)
    default:
      return
    }
  }

  @MainActor required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
