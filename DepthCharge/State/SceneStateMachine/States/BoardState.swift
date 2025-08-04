//
//  BoardState.swift
//  Forty Fives
//
//  Created by Andrew Yahner on 7/24/17.
//  Copyright © 2025 Thoroughcity. All rights reserved.
//

import Foundation
import GameplayKit
import os

class BoardState: SceneState {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "BoardState")

  init(scene: BoardScene) {
    super.init()
    self.scene = scene
  }

  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass is MainState.Type || stateClass is OptionsState.Type
      || stateClass is HelpState.Type
  }

  override func didEnter(from previousState: GKState?) {
    super.didEnter(from: previousState)
    if previousState == nil {
      getStateMachine().viewController.skView!.presentScene(scene)
    } else {
      var transition: SKTransition
      switch previousState! {
      case is HelpState:
        transition = SKTransition.reveal(with: SKTransitionDirection.up, duration: AppPrefs.SCENE_TRANSITION_DURATION)
      case is OptionsState:
        transition = SKTransition.reveal(with: SKTransitionDirection.up, duration: AppPrefs.SCENE_TRANSITION_DURATION)
      case is MainState:
        transition = SKTransition.push(with: SKTransitionDirection.left, duration: AppPrefs.SCENE_TRANSITION_DURATION)
      default:
        logger.log("Unexpected previous state \(String(describing: previousState))")
        transition = SKTransition.fade(withDuration: AppPrefs.SCENE_TRANSITION_DURATION)
      }
      getStateMachine().viewController.skView!.presentScene(
        scene, transition: transition)

    }
  }
}
