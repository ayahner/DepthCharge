//
//  SceneState.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import Foundation
import GameplayKit
import os

class SceneState: BaseState {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "SceneState")

  var previousState: GKState.Type?

  func getStateMachine() -> SceneStateMachine {
    return stateMachine as! SceneStateMachine
  }

  override func isValidNextState(_: AnyClass) -> Bool {
    fatalError("cannot instantiate SceneState")
  }

  override func didEnter(from previousState: GKState?) {
    logger.debug("didEnter from: \(previousState) to: \(self)")
    if previousState != nil {
      self.previousState = type(of: previousState!)
    }
  }
}
