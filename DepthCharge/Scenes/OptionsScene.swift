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

class OptionsScene: GameScene, Alertable {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "OptionsScene")

  //  var gameCenterEnabled = true
  //  var entities = [GKEntity]()
  //  var graphs = [String: GKGraph]()

  override func sceneDidLoad() {
    initBackground(scene: self, imageNamed: "options-bg")

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
