//
//  MainScene.swift
//  Forty-Fives
//
//  Created by Andrew Yahner on 3/5/25.
//

import GameKit
import SpriteKit
import os

class TestScene: GameScene, Alertable {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "TestScene")

  var background = SKSpriteNode()
  let testPanel = TestPanel(position: .zero, size: CGSize(width: 1024, height: 472))

  override init(size: CGSize) {
    super.init(size: size)
  }

  override func sceneDidLoad() {
    initTestUi()
    addChild(testPanel)
  }

  func initTestUi() {
    background.color = UIColor.appMedium
    background.blendMode = .replace
    background.size = size
    background.position = position
    addChild(background)

    let testButton = SpriteButton("BackButton", systemName: "stethoscope.circle")
    testButton.position = CGPoint(x: size.width/2 - 90, y: 185)
    addChild(testButton)
  }

  override func didMove(to _: SKView) {
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
      testPanel.buttonAction(name: name)
    }
  }

  @MainActor required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
