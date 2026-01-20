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
  let margin = CGFloat.zero

  var updatables = [Updatable]()

  let reticleBottomLeft = SKShapeNode.targetReticle(radius: 10)
  let reticleBottomRight = SKShapeNode.targetReticle(radius: 10)
  let reticleTopLeft = SKShapeNode.targetReticle(radius: 10)
  let reticleTopRight = SKShapeNode.targetReticle(radius: 10)

  let pageMargin = CGSize(
    width: AppPrefs.shared.getDouble(Category.panel, AppPrefs.MARGIN_WIDTH),
    height: AppPrefs.shared.getDouble(Category.panel, AppPrefs.MARGIN_HEIGHT))

  var sceneStateMachine: SceneStateMachine?
  
  init(size: CGSize, stateMachine: SceneStateMachine) {
    super.init(size: size)
    sceneStateMachine = stateMachine
    scaleMode = .resizeFill
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
        for touch in touches {
          let location = touch.location(in: self)
          let nodes = self.nodes(at: location)
          for node in nodes {
            if let button = node as? Button {
              if !button.enabled {
                continue
              }
            }
            if let clickable = node as? Clickable {
              if clickable.name != nil {
                buttonAction(name: clickable.name!)
              }
            }
          }
        }
  }

  func initLabel(_ label: SKLabelNode) {
    label.fontName = AppPrefs.shared.getString(Category.general, AppPrefs.FONT_NAME)
    label.fontSize = AppPrefs.shared.getDouble(Category.general, AppPrefs.FONT_SIZE)
    label.fontColor = UIColor.black  //appDarkest
    label.horizontalAlignmentMode = .center
    label.verticalAlignmentMode = .center
  }

  func buttonAction(name _: String) {
    logger.debug("buttonAction called in GameScene")
  }

  func drawTestPattern() {
    
    let insets = view!.safeAreaInsets

    let left = insets.left + margin
    let right = size.width - insets.right - margin
    let bottom = insets.bottom + margin
    let top = size.height - insets.top - margin

    let corners = [
      CGPoint(x: left, y: bottom),  // bottom-left
      CGPoint(x: right, y: bottom),  // bottom-right
      CGPoint(x: left, y: top),  // top-left
      CGPoint(x: right, y: top),  // top-right
    ]
    logger.debug("corners: \(String(describing: corners))")

    reticleBottomLeft.position = corners[0]
    reticleBottomRight.position = corners[1]
    reticleTopLeft.position = corners[2]
    reticleTopRight.position = corners[3]
    
    addChild(reticleBottomLeft)
    addChild(reticleBottomRight)
    addChild(reticleTopLeft)
    addChild(reticleTopRight)

  }
}
