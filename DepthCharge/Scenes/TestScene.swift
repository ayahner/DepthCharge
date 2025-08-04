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

  var background = SKSpriteNode()
//  let testPanel = TestPanel(position: .zero, size: CGSize(width: 1024, height: 472))

  override init(size: CGSize) {
    super.init(size: size)
  }

  override func sceneDidLoad() {
    logger.debug("TestScene loading...")
    initTestUi()
//    addChild(testPanel)
  }

  func initTestUi() {
    background.color = UIColor.appMedium
    background.blendMode = .replace
    background.size = size
    background.position = position
    addChild(background)

    let label = SKLabelNode(text: "Test Scene")
    logger.debug("size: width: \(self.size.width), height: \(self.size.height)")
    
    label.fontName = "HelveticaNeue-Bold"//AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME)
    label.fontColor = .white
    label.fontSize = 40
    label.position = CGPoint(x: 0, y: 0)
    addChild(label)
    
    print("🔍 fontName = \(label.fontName!)")
//    let testButton = SpriteButton("BackButton", systemName: "stethoscope.circle")
//    testButton.position = CGPoint(x: size.width/2 - 90, y: 185)
//    addChild(testButton)
    
    for node in children {
      // skip nodes that already have bodies, or shape nodes you don’t care about
      guard node.physicsBody == nil else { continue }

      // create a rectangle body the size of the node’s frame
      let body = SKPhysicsBody(rectangleOf: node.frame.size)
      body.isDynamic = false   // so it doesn’t start falling
      node.physicsBody = body
    }
    
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
      logger.debug("Button pressed with name: \(name)")
//      testPanel.buttonAction(name: name)
    }
  }

  @MainActor required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
