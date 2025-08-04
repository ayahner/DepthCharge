//
//  GameScene.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import Foundation
import SpriteKit
import os

class GameScene: SKScene {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "GameScene")
  var updatables = [Updatable]()

  override init(size: CGSize) {
    super.init(size: size)
    anchorPoint = CGPoint(x: 0.5, y: 0.5)
    scaleMode = .aspectFill
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  let pageMargin = CGSize(
    width: AppPrefs.shared.getDouble(Category.panel, AppPrefs.MARGIN_WIDTH),
    height: AppPrefs.shared.getDouble(Category.panel, AppPrefs.MARGIN_HEIGHT))

  var sceneStateMachine: SceneStateMachine?

  /// Initialize a scene's background with a specified texture or blank color
  /// * zPosition: set to -1 to draw the background behind other scene members
  /// - Parameters:
  ///   - scene: SKScene this background will be a direct child of
  ///   - imageNamed: image name to use to fill the scene
  func initBackground(scene: SKScene, imageNamed: String) {
    //If Show Background = false just use a .secondary color for the background
    guard AppPrefs.shared.getBool(Category.general, AppPrefs.SHOW_BACKGROUND) else {
      scene.backgroundColor = UIColor.green //appSecondary
      return
    }

    let background = SKSpriteNode(imageNamed: imageNamed)
    background.blendMode = .replace
    let scaleFactor = scene.frame.size.width / background.size.width
    background.size = CGSize(
      width: scene.frame.size.width, height: background.size.height * scaleFactor)
    background.position = .zero
    background.zPosition = -1
    scene.addChild(background)
  }
  
  override func didMove(to view: SKView) {
    super.didMove(to: view)
  }
  
  override func update(_ currentTime: TimeInterval) {
    updatables.forEach { $0.update(currentTime) }
    for updatable in updatables {
      updatable.update(currentTime)
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
//    for touch in touches {
//      let location = touch.location(in: self)
//      let nodes = self.nodes(at: location)
//      for node in nodes {
//        if let button = node as? Button {
//          if !button.enabled {
//            continue
//          }
//        }
//        if let clickable = node as? Clickable {
//          if clickable.name != nil {
//            buttonAction(name: clickable.name!)
//          }
//        }
//      }
//    }
  }

  func initLabel(_ label: SKLabelNode) {
    label.fontName = AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME)
    label.fontSize = AppPrefs.shared.getDouble(Category.general, AppPrefs.FONT_SIZE)
    label.fontColor = UIColor.black//appDarkest
    label.horizontalAlignmentMode = .center
    label.verticalAlignmentMode = .center
  }
  
  func buttonAction(name _: String) {
    logger.debug("buttonAction called in GameScene")
  }

}
