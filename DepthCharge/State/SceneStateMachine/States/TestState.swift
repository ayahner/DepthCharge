//
//  TestState.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.

//

import Foundation
import GameplayKit
import os

class TestState: SceneState {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "TestState")

  override init() {
    super.init();
  }
  
  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass is MainState.Type
  }

  override func didEnter(from previousState: GKState?) {
    super.didEnter(from: previousState)
    
    let size = getStateMachine().skView!.bounds.size
    let scene = TestScene(size: size, stateMachine: getStateMachine());

    if previousState == nil {
      getStateMachine().skView!.presentScene(scene)
    } else {
      var transition: SKTransition
      switch previousState! {
      case is MainState:
        transition = SKTransition.crossFade(withDuration: AppPrefs.SCENE_TRANSITION_DURATION)
      default:
        logger.log("Unexpected previous state \(String(describing: previousState))")
        transition = SKTransition.fade(withDuration: AppPrefs.SCENE_TRANSITION_DURATION)
      }
      getStateMachine().skView!.presentScene(
        scene, transition: transition)
    }
  }
}
