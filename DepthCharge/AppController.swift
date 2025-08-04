//
//  GameViewController.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/3/25.
//


import AVFoundation
import GameKit
import SpriteKit
import UIKit
import os

class AppController: UIViewController  // , GKGameCenterControllerDelegate
{
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Controller")
  
  private var notification: NSObjectProtocol?
  
  var sceneStateMachine: SceneStateMachine!
  
  var skView: SKView?
  
  let mainScene = MainScene(size: CGSize(width: 768, height: 1024))
  let boardScene = BoardScene(size: CGSize(width: 768, height: 1024))
  let optionsScene = OptionsScene(size: CGSize(width: 768, height: 1024))
  let helpScene = HelpScene(size: CGSize(width: 768, height: 1024))
  let testScene = TestScene(size: CGSize(width: 768, height: 1024))
  
  override func loadView() {
    super.loadView()
    logger.debug("AppController.loadView()")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    logger.debug("AppController.viewDidLoad()")

    //    notification = NotificationCenter.default.addObserver(forName: .UIApplication.willEnterForegroundNotification, object: nil, queue: .main) {
    //      [unowned self] notification in
    //      logger.debug("entered foreground")
    //      self.gameStateMachine?.enter(MainState.self)
    //    }
    // send these in from the configuration screen when we have one
    NotificationCenter.default.addObserver(
      self, selector: Selector(("AlertMessage:")),
      name: NSNotification.Name(rawValue: "AlertMessage"), object: nil)
    
    skView = view as? SKView
    skView!.isMultipleTouchEnabled = false
    skView!.ignoresSiblingOrder = false
    
    //    skView!.showsFPS = true
    //    skView!.showsNodeCount = true
    //    skView!.showsDrawCount = true
    //    skView!.showsQuadCount = true
    
    //    skView!.showsFields = true
        skView!.showsPhysics = true
    
        
    if sceneStateMachine == nil {
      sceneStateMachine = SceneStateMachine(
        viewController: self,
        mainScene: mainScene,
        boardScene: boardScene,
        optionsScene: optionsScene,
        helpScene: helpScene,
        testScene: testScene
      )
    }
    sceneStateMachine?.enter(TestState.self)// MainState BoardState
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  func gameCenterViewControllerDidFinish(_ gcViewController: GKGameCenterViewController) {
    self.dismiss(animated: true, completion: nil)
  }
  
  deinit {
    logger.debug("AppController.deinit()")
    // make sure to remove the observer when this view controller is dismissed/deallocated
    if let notification = notification {
      NotificationCenter.default.removeObserver(notification)
    }
  }
  
  func AlertMessage(notification _: NSNotification) {
    logger.debug("AppController.alertMessage()")
    
  }
  
}
