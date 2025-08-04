//
//  BaseState.swift
//  Forty Fives
//
//  Created by Andrew Yahner on 7/24/17.
//  Copyright © 2025 Thoroughcity. All rights reserved.
//

import Foundation
import GameplayKit

class BaseState: GKState {
  override init() {
    super.init()
  }
  
  

  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return super.isValidNextState(stateClass)
  }

  override func didEnter(from previousState: GKState?) {
    super.didEnter(from: previousState)
  }

  override func willExit(to nextState: GKState) {
    super.willExit(to: nextState)
  }
}
