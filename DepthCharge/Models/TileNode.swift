//
//  Tile.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/5/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import Foundation
import SpriteKit
import os

class TileNode: SKSpriteNode {

  enum TileState {
    case hidden
    case revealed
    case marked
    case bomb
  }

  var row = 0
  var col = 0

  var hasBomb: Bool = false
  var neighborBombs: Int = 0 {
    didSet {
      // whenever neighborBombs changes, update the label
      neighborLabel.text = "\(neighborBombs)"
      neighborLabel.fontColor = .white

      switch neighborBombs {
      case 0:
        neighborLabel.text = ""
      case 1:
        neighborLabel.fontColor = .white
      case 2:
        neighborLabel.fontColor = .yellow
      default:
        neighborLabel.fontColor = .red
      }
    }
  }

  var state: TileState = .hidden

  let neighborLabel = SKLabelNode(fontNamed: AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME_BOLD))
  let bombSpriteNode = SKSpriteNode(imageNamed: "mine")
  let markSpriteNode = SKSpriteNode(imageNamed: "marked")

  init(color: SKColor = .appDark, size: CGSize) {
    super.init(texture: nil, color: color, size: size)

    let border = SKShapeNode(rectOf: size)
    border.strokeColor = .appDarkest
    border.lineWidth = 2
    border.fillColor = .clear
    border.zPosition = 1
    addChild(border)

    neighborLabel.text = "\(neighborBombs)"
    neighborLabel.isHidden = true
    neighborLabel.verticalAlignmentMode = .center
    neighborLabel.fontSize = 16
    neighborLabel.fontColor = .white  //.appDark

    bombSpriteNode.isHidden = true
    bombSpriteNode.size = CGSize(width: self.size.width - 4, height: self.size.height - 4)

    markSpriteNode.isHidden = true
    markSpriteNode.size = CGSize(width: self.size.width - 4, height: self.size.height - 4)

    addChild(bombSpriteNode)
    addChild(markSpriteNode)
    addChild(neighborLabel)
  }

  func reveal() {
    guard state == .hidden else { return }
    state = .revealed
    updateAppearance()
  }

  func toggleMark() {
    guard (state == .hidden || state == .marked) else { return }
    if state == .hidden {
      state = .marked
    } else if state == .marked {
      state = .hidden
    }
    updateAppearance()
  }

  func updateAppearance() {
    markSpriteNode.isHidden = true
    switch state {
    case .hidden:
      color = .appDark
    case .revealed:
      color = .appLight
      if hasBomb {
        // Show bomb image
        bombSpriteNode.isHidden = false
      } else if neighborBombs > 0 {
        // Show number
        neighborLabel.isHidden = false
      }
    case .marked:
      color = .appLighter
      markSpriteNode.isHidden = false
    case .bomb:
      color = .red
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let scaleDown = SKAction.scale(to: 0.8, duration: 0.1)
    let scaleUp = SKAction.scale(to: 1.0, duration: 0.1)
    self.run(SKAction.sequence([scaleDown, scaleUp])) {
      self.scene?.touchesBegan(touches, with: event)
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    scene?.touchesEnded(touches, with: event)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
