//
//  TestState.swift
//  Forty Fives
//
//  Created by Andrew Yahner on 4/3/25.
//  Copyright © 2025 Thoroughcity. All rights reserved.
//

import Foundation
import GameplayKit
import os

class TestState: SceneState {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "TestState")

  init(scene: TestScene) {
    super.init()
    self.scene = scene
  }

  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass is MainState.Type
  }

  override func didEnter(from previousState: GKState?) {
    super.didEnter(from: previousState)
    if previousState == nil {
      getStateMachine().viewController.skView!.presentScene(scene)
    } else {
      var transition: SKTransition
      switch previousState! {
      case is MainState:
        transition = SKTransition.crossFade(withDuration: AppPrefs.SCENE_TRANSITION_DURATION)
      default:
        logger.log("Unexpected previous state \(String(describing: previousState))")
        transition = SKTransition.fade(withDuration: AppPrefs.SCENE_TRANSITION_DURATION)
      }
      getStateMachine().viewController.skView!.presentScene(
        scene, transition: transition)
    }
  }
}
