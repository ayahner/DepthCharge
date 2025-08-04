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

enum CardLevel: CGFloat {
  case board = 10
  case moving = 100
  case enlarged = 200
}

class BoardScene: GameScene, Alertable {
  
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "BoardScene")

  override func didMove(to view: SKView) {
    super.didMove(to: view)
  }

  override func sceneDidLoad() {
    initBackground(scene: self, imageNamed: "game-four-players-bg")

    //TODO:  Add navigation buttons
//    let mainButton = SpriteButton("MainButton", systemName: "house.circle")
//    mainButton.position = CGPoint(x: -frame.width / 2 + 100, y: frame.height / 2 - 180)
//    addChild(mainButton)
//
//    let helpButton = SpriteButton("HelpButton", systemName: "questionmark.circle")
//    helpButton.position = CGPoint(x: mainButton.position.x, y: mainButton.position.y - 40)
//    addChild(helpButton)
//
//    let optionsButton = SpriteButton("OptionsButton", systemName: "gearshape.circle")
//    optionsButton.position = CGPoint(x: helpButton.position.x, y: helpButton.position.y - 40)
//    addChild(optionsButton)

  }

//  func createButton(_ name: String, buttonText: String, position: CGPoint) -> ShapeButton {
//    let button = ShapeButton(name, buttonText: buttonText)
//    button.position = position
//    return button
//  }

  override func buttonAction(name: String) {
    switch name {
    case "HelpButton":
      sceneStateMachine?.enter(HelpState.self)
    case "OptionsButton":
      sceneStateMachine?.enter(OptionsState.self)
    case "MainButton":
      logger.debug("Menu")
      sceneStateMachine?.enter(MainState.self)
    default:
      return
    }
  }
}
