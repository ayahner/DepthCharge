//
//  SceneStateMachine.swift
//  Forty Fives
//
//  Created by Andrew Yahner on 7/24/17.
//  Copyright © 2025 Thoroughcity. All rights reserved.
//

import GameplayKit
import os

public class SceneStateMachine: GKStateMachine {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "State")

  let mainScene: MainScene!
  let boardScene: BoardScene!
  let optionsScene: OptionsScene!
  let helpScene: HelpScene!
  let testScene: TestScene!

  let viewController: AppController!

  init(
    viewController: AppController, mainScene: MainScene, boardScene: BoardScene,
    optionsScene: OptionsScene,
    helpScene: HelpScene,
    testScene: TestScene
  ) {
    self.viewController = viewController
    self.mainScene = mainScene
    self.boardScene = boardScene
    self.optionsScene = optionsScene
    self.helpScene = helpScene
    self.testScene = testScene
    super.init(states: [
      MainState(scene: mainScene),
      OptionsState(scene: optionsScene),
      BoardState(scene: boardScene),
      HelpState(scene: helpScene),
      TestState(scene: testScene),
    ])
    self.mainScene.sceneStateMachine = self
    self.boardScene.sceneStateMachine = self
    self.optionsScene.sceneStateMachine = self
    self.helpScene.sceneStateMachine = self
    self.testScene.sceneStateMachine = self
  }
}
