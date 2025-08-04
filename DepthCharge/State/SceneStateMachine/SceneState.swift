//
//  SceneState.swift
//  Forty Fives
//
//  Created by Andrew Yahner on 7/24/17.
//  Copyright © 2025 Thoroughcity. All rights reserved.
//

import Foundation
import GameplayKit
import os

class SceneState: BaseState {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "SceneState")

  var scene: GameScene!

  var previousState: GKState.Type?

  func getStateMachine() -> SceneStateMachine {
    return stateMachine as! SceneStateMachine
  }

  override func isValidNextState(_: AnyClass) -> Bool {
    fatalError("cannot instantiate BoardSceneState")
  }

  override func didEnter(from previousState: GKState?) {
    logger.debug("didEnter from: \(previousState) to: \(self)")
    if previousState != nil {
      self.previousState = type(of: previousState!)
    }
  }
}
