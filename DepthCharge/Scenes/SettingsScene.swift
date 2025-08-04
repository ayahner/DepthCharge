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

class SettingsScene: GameScene, Alertable {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "SettingsScene")

  //  var gameCenterEnabled = true
  //  var entities = [GKEntity]()
  //  var graphs = [String: GKGraph]()

  override init(size: CGSize, stateMachine: SceneStateMachine) {
    super.init(size: size, stateMachine: stateMachine)
  }

  override func didMove(to view: SKView) {
    super.didMove(to: view)

    backgroundColor = UIColor.appMedium

    let label = SKLabelNode(text: "Settings Scene")
    label.fontName = AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME_BOLD)
    label.fontColor = .white
    label.fontSize = 40
    label.position = CGPoint(x: size.width / 2, y: size.height - size.height / 3)
    addChild(label)

    let testButton = ShapeButton("BackButton", buttonText: "Back")
    testButton.position = CGPoint(x: size.width / 2, y: label.position.y - testButton.size.height - 20)
    addChild(testButton)

    drawTestPattern()

  }

  override func buttonAction(name: String) {
    switch name {
    case "BackButton":
      logger.debug("BackButton")
      if let previousState = (sceneStateMachine?.currentState as! SceneState).previousState {
        sceneStateMachine?.enter(previousState)
      }
    default:
      return
    }
  }
  
  @MainActor required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
