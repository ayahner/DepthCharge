//
//  HelpScene.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import Foundation
import SpriteKit
import os

class HelpScene: GameScene {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "HelpScene")

  override func sceneDidLoad() {
    initBackground(scene: self, imageNamed: "help-bg")
    
    //TODO: Add Back Button
    //TODO: Add Basic Play Info
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
}
