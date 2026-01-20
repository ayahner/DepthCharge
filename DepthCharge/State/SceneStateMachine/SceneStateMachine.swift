//
//  SceneStateMachine.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import GameplayKit
import os

public class SceneStateMachine: GKStateMachine {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "State")

//  let viewController: AppController!
  let skView: SKView!

  init(
    view: SKView
  ) {
    self.skView = view
    
    super.init(states: [
      MainState(),
      SettingsState(),
      BoardState(),
      HelpState(),
      TestState(),
    ])
  }
}
