//
//  MainScene.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import GameKit
import SpriteKit
import os

class MainScene: GameScene, Alertable {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "MainScene")

  var gameCenterEnabled = false
  var entities = [GKEntity]()
  var graphs = [String: GKGraph]()

//  var howToPlayButton: ShapeButton!
//  var leaderboardButton: ShapeButton!
//  var resetGameButton: ShapeButton!
//  var optionsButton: ShapeButton!
//  var achievementsButton: ShapeButton!
//  var playButton: ShapeButton!

  override init(size: CGSize) {
    super.init(size: size)
  }

  override func sceneDidLoad() {
    initBackground(scene: self, imageNamed: "main-bg")
  }

//  func createPanel(name: String, size: CGSize) -> Panel {
//    let panel = BasicPanel(size: size)
//
//    //Add Title Label
//    
//    let titleLabel = SKLabelNode(text: "Depth Charge")
//    makeTitle(titleLabel)
//    panel.addChild(titleLabel)
//
//    //Add Copyright Label
//    let nsObject: [String: Any] = Bundle.main.infoDictionary!
//    let version = nsObject["CFBundleShortVersionString"] as! String
//    let subtitleLabelText =
//      "Copyright © \(Calendar.current.component(.year, from: Date())) Thoroughcity, LLC      All Rights Reserved    v \(version)"
//    let subtitleLabel = SKLabelNode(text: subtitleLabelText)
//    initLabel(subtitleLabel)
//    subtitleLabel.position = CGPoint(x: 0, y: -175)
//    panel.addChild(subtitleLabel)
//
//    return panel
//  }

  override func didMove(to _: SKView) {
  }

  override func buttonAction(name: String) {
    switch name {
    case "PlayButton":
      sceneStateMachine?.enter(BoardState.self)
    case "OptionsButton":
      sceneStateMachine?.enter(OptionsState.self)
      return
    case "HowToPlayButton":
      sceneStateMachine?.enter(HelpState.self)
      return
    case "TestButton":
      sceneStateMachine?.enter(TestState.self)
      return
    default:
      return
    }
  }

  @MainActor required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
