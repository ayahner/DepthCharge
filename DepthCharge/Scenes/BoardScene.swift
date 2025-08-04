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
  
  override init(size: CGSize, stateMachine: SceneStateMachine) {
    super.init(size: size, stateMachine: stateMachine)
  }
  
  override func didMove(to view: SKView) {
    super.didMove(to: view)
    
    backgroundColor = UIColor.appMedium

    let buttonMargin = 20.0

    let label = SKLabelNode(text: "Board Scene")
    label.fontName = AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME_BOLD)
    label.fontColor = .white
    label.fontSize = 40
    label.position = CGPoint(x: size.width / 2, y: size.height - size.height / 3)
    addChild(label)

    let settingsButton = ShapeButton("SettingsButton", buttonText: "Settings")
    settingsButton.position = CGPoint(x: size.width / 2, y: label.position.y - settingsButton.size.height - buttonMargin)
    addChild(settingsButton)

    let helpButton = ShapeButton("HelpButton", buttonText: "How to Play")
    helpButton.position = CGPoint(x: size.width / 2, y: settingsButton.position.y - helpButton.size.height - buttonMargin)
    addChild(helpButton)

    let mainMenuButton = ShapeButton("MainButton", buttonText: "Main Menu")
    mainMenuButton.position = CGPoint(x: size.width / 2, y: helpButton.position.y - mainMenuButton.size.height - 20)
    addChild(mainMenuButton)

    drawTestPattern()

    //TODO:  Add navigation buttons
    //    let mainButton = SpriteButton("MainButton", systemName: "house.circle")
    //    mainButton.position = CGPoint(x: -frame.width / 2 + 100, y: frame.height / 2 - 180)
    //    addChild(mainButton)
    //
    //    let helpButton = SpriteButton("HelpButton", systemName: "questionmark.circle")
    //    helpButton.position = CGPoint(x: mainButton.position.x, y: mainButton.position.y - 40)
    //    addChild(helpButton)
    //
    //    let settingsButton = SpriteButton("SettingsButton", systemName: "gearshape.circle")
    //    settingsButton.position = CGPoint(x: helpButton.position.x, y: helpButton.position.y - 40)
    //    addChild(settingsButton)
    
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
