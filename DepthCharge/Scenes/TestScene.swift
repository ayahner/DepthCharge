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

class TestScene: GameScene, Alertable {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "TestScene")
  
  override init(size: CGSize, stateMachine: SceneStateMachine) {
    super.init(size: size, stateMachine: stateMachine)
  }

  override func didMove(to view: SKView) {
    super.didMove(to: view)
    initUI()
  }

  func initUI() {
    backgroundColor = UIColor.appMedium

    let label = SKLabelNode(text: "Test Scene")
    label.fontName = AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME_BOLD)
    label.fontColor = .white
    label.fontSize = 40
    label.position = CGPoint(x: size.width / 2, y: size.height - size.height / 3)
    addChild(label)

    let testButton = ShapeButton("BackButton", buttonText: "Back")
    testButton.position = CGPoint(x: size.width / 2, y: label.position.y - testButton.size.height - 20)
    addChild(testButton)

    drawTestPattern()

//    let testButton = SpriteButton("BackButton", systemName: "stethoscope.circle")
//    testButton.position = CGPoint(x: size.width/2 - 90, y: 185)
//    addChild(testButton)

  }

  override func buttonAction(name: String) {
    switch name {
    case "BackButton":
      logger.debug("BackButton")
      if let previousState = (sceneStateMachine?.currentState as! SceneState).previousState {
        sceneStateMachine?.enter(previousState)
      } else {
        sceneStateMachine?.enter(MainState.self)
      }
    default:
      logger.debug("Button pressed with name: \(name)")
//      testPanel.buttonAction(name: name)
    }
  }

  @MainActor required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
