//
//  HelpState.swift
//  Forty Fives
//
//  Created by Andrew Yahner on 8/7/17.
//  Copyright © 2025 Thoroughcity. All rights reserved.
//

import Foundation
import GameplayKit
import os

class HelpState: SceneState {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "HelpState")

  init(scene: HelpScene) {
    super.init()
    self.scene = scene
  }

  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass is BoardState.Type || stateClass is MainState.Type
  }

  override func didEnter(from previousState: GKState?) {
    super.didEnter(from: previousState)
    if previousState == nil {
      getStateMachine().viewController.skView!.presentScene(scene)
    } else {
      var transition: SKTransition
      switch previousState! {
      case is OptionsState:
        transition = SKTransition.moveIn(with: SKTransitionDirection.up, duration: AppPrefs.SCENE_TRANSITION_DURATION)
      case is MainState:
        transition = SKTransition.moveIn(with: SKTransitionDirection.up, duration: AppPrefs.SCENE_TRANSITION_DURATION)
      case is BoardState:
        transition = SKTransition.moveIn(with: SKTransitionDirection.up, duration: AppPrefs.SCENE_TRANSITION_DURATION)
      default:
        logger.log("Unexpected previous state \(String(describing: previousState))")
        transition = SKTransition.fade(withDuration: AppPrefs.SCENE_TRANSITION_DURATION)
      }
      getStateMachine().viewController.skView!.presentScene(
        scene, transition: transition)
    }
  }
}
