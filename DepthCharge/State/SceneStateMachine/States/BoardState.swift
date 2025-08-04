//
//  BoardState.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import Foundation
import GameplayKit
import os

class BoardState: SceneState {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "BoardState")

  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass is MainState.Type || stateClass is SettingsState.Type
      || stateClass is HelpState.Type
  }

  override func didEnter(from previousState: GKState?) {
    super.didEnter(from: previousState)

    let size = getStateMachine().skView!.bounds.size
    let scene = BoardScene(size: size, stateMachine: getStateMachine());

    if previousState == nil {
      getStateMachine().skView!.presentScene(scene)
    } else {
      var transition: SKTransition
      switch previousState! {
      case is HelpState:
        transition = SKTransition.reveal(with: SKTransitionDirection.up, duration: AppPrefs.SCENE_TRANSITION_DURATION)
      case is SettingsState:
        transition = SKTransition.reveal(with: SKTransitionDirection.up, duration: AppPrefs.SCENE_TRANSITION_DURATION)
      case is MainState:
        transition = SKTransition.push(with: SKTransitionDirection.left, duration: AppPrefs.SCENE_TRANSITION_DURATION)
      default:
        logger.log("Unexpected previous state \(String(describing: previousState))")
        transition = SKTransition.fade(withDuration: AppPrefs.SCENE_TRANSITION_DURATION)
      }
      getStateMachine().skView!.presentScene(
        scene, transition: transition)

    }
  }
}
