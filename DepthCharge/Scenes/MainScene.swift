//
//  MainScene.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import GameKit
import SpriteKit
import os

class MainScene: GameScene, Alertable {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "MainScene")

  //  var startGameButton: ShapeButton!
  //  var settingsButton: ShapeButton!
  //  var leaderboardButton: ShapeButton!
  //  var helpButton: ShapeButton!
  var testButton: ShapeButton!

  //  var gameCenterEnabled = false
  //  var entities = [GKEntity]()
  //  var graphs = [String: GKGraph]()

  override init(size: CGSize, stateMachine: SceneStateMachine) {
    super.init(size: size, stateMachine: stateMachine)
  }

  override func didMove(to view: SKView) {
    super.didMove(to: view)
    initUI();
  }
  
  func initUI() {
    backgroundColor = UIColor.appMedium

    let buttonMargin = 20.0
    
    let label = SKLabelNode(text: "Main Scene")
    label.fontName = AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME_BOLD)
    label.fontColor = .white
    label.fontSize = 40
    label.position = CGPoint(x: size.width / 2, y: size.height - size.height / 3)
    addChild(label)

    let playButton = ShapeButton("PlayButton", buttonText: "Play")
    playButton.position = CGPoint(x: size.width / 2, y: label.position.y - playButton.size.height - buttonMargin)
    addChild(playButton)

    let settingsButton = ShapeButton("SettingsButton", buttonText: "Settings")
    settingsButton.position = CGPoint(x: size.width / 2, y: playButton.position.y - settingsButton.size.height - buttonMargin)
    addChild(settingsButton)

    let helpButton = ShapeButton("HelpButton", buttonText: "How to Play")
    helpButton.position = CGPoint(x: size.width / 2, y: settingsButton.position.y - helpButton.size.height - buttonMargin)
    addChild(helpButton)

    let testButton = ShapeButton("TestButton", buttonText: "Test Scene")
    testButton.position = CGPoint(x: size.width / 2, y: helpButton.position.y - testButton.size.height - buttonMargin)
    addChild(testButton)


    drawTestPattern()
  }

  //  func createPanel(name: String, size: CGSize) -> Panel {
  //    let panel = BasicPanel(size: size)
  //
  //    //Add Title Label
  //
  //    let titleLabel = SKLabelNode(text: "Depth Charge")
  //    makeTitle(titleLabel)
  //    panel.addChild(titleLabel)
  //
  //    //Add Copyright Label
  //    let nsObject: [String: Any] = Bundle.main.infoDictionary!
  //    let version = nsObject["CFBundleShortVersionString"] as! String
  //    let subtitleLabelText =
  //      "Copyright © \(Calendar.current.component(.year, from: Date())) Thoroughcity, LLC      All Rights Reserved    v \(version)"
  //    let subtitleLabel = SKLabelNode(text: subtitleLabelText)
  //    initLabel(subtitleLabel)
  //    subtitleLabel.position = CGPoint(x: 0, y: -175)
  //    panel.addChild(subtitleLabel)
  //
  //    return panel
  //  }

  override func buttonAction(name: String) {
    logger.debug("Button pressed: \(name)")
    switch name {
    case "PlayButton":
      sceneStateMachine?.enter(BoardState.self)
    case "SettingsButton":
      sceneStateMachine?.enter(SettingsState.self)
      return
    case "HelpButton":
      sceneStateMachine?.enter(HelpState.self)
      return
    case "TestButton":
      sceneStateMachine?.enter(TestState.self)
      return
    default:
      return
    }
  }

  @MainActor required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
