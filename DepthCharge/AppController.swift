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

  let mainScene = MainScene(size: CGSize(width: 1024, height: 768))
  let boardScene = BoardScene(size: CGSize(width: 1024, height: 768))
  let optionsScene = OptionsScene(size: CGSize(width: 1024, height: 768))
  let helpScene = HelpScene(size: CGSize(width: 1024, height: 768))
  let testScene = TestScene(size: CGSize(width: 1024, height: 768))

  /* Variables */
  var gcEnabled = Bool()  // Check if the user has Game Center enabled
  var gcDefaultLeaderBoard = String()  // Check the default leaderboardID

  override func loadView() {
    super.loadView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    //    skView!.showsPhysics = true

    
    var appDefaults = [String: AnyObject]()
    appDefaults["gamePoint"] = 120 as AnyObject
    appDefaults["testMode"] = false as AnyObject
    appDefaults["testFixDeck"] = false as AnyObject
    appDefaults["testDealer"] = 0 as AnyObject
    UserDefaults.standard.register(defaults: appDefaults)

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
    authenticateLocalPlayer()
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

  func showHelpScreen() {

  }

  func showLeaderboard() {
    //  if (!GKLocalPlayer.localPlayer().isAuthenticated) {
    //    authenticateLocalPlayer()
    //    return
    //  }
    //    let gcViewController: GKGameCenterViewController = GKGameCenterViewController()
    //    gcViewController.gameCenterDelegate = self
    //    gcViewController.viewState = GKGameCenterViewControllerState.leaderboards
    //    gcViewController.leaderboardIdentifier = LEADERBOARD_ID_GAMES_WON
    //
    //    self.show(gcViewController, sender: self)
    //    self.navigationController?.pushViewController(gcViewController, animated: true)
    //    self.present(gcViewController, animated: true, completion: nil)
  }

  func showAchievements() {
    logger.debug("MainGameController.showLeaderboard()")

    //    if (!GKLocalPlayer.localPlayer().isAuthenticated) {
    //      authenticateLocalPlayer()
    //      return
    //    }
    //    let gcViewController: GKGameCenterViewController = GKGameCenterViewController()
    //    gcViewController.gameCenterDelegate = self
    //    gcViewController.viewState = GKGameCenterViewControllerState.achievements
    //
    //    self.show(gcViewController, sender: self)
    //    self.navigationController?.pushViewController(gcViewController, animated: true)
    //    self.present(gcViewController, animated: true, completion: nil)
  }

  func authenticationComplete() {
    logger.debug("MainGameController.authenticationComplete()")
  }

  func authenticateLocalPlayer() {
    //    let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
    //
    //    localPlayer.authenticateHandler = {(ViewController, error) -> Void in
    //      if((ViewController) != nil) {
    //        // 1. Show login if player is not logged in
    //        self.present(ViewController!, animated: true, completion: self.authenticationComplete)
    //      } else if (localPlayer.isAuthenticated) {
    //        // 2. Player is already authenticated & logged in, load game center
    //        self.gcEnabled = true
    //
    //        // Get the default leaderboard ID
    //        localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
    //          if error != nil {
    //            logger.debug(error!)
    //            self.mainScene.showAlert(withTitle: "GameCenter Error", message: "Unable to load Game Center: \n\(error!)")
    //          } else {
    //            self.gcDefaultLeaderBoard = leaderboardIdentifer!
    //            self.mainScene.updateButtons()
    //          }
    //        })
    //
    //      } else {
    //        // 3. Game center is not enabled on the users device
    //        self.gcEnabled = false
    //        logger.debug("Local player could not be authenticated!")
    //        if (error != nil) {
    //          logger.debug(error!)
    //        }
    //        self.mainScene.showAlert(withTitle: "Game Center Disabled", message: "You haven't authenticated with Game Center.\nPlease log into GameCenter using the GameCenter App if you want to re-enable the Gamecenter Features.\n")
    //      }
    //      self.mainScene.updateButtons()
    //    }
  }

  deinit {
    logger.debug("MainGameController.deinit()")
    // make sure to remove the observer when this view controller is dismissed/deallocated
    if let notification = notification {
      NotificationCenter.default.removeObserver(notification)
    }
  }

  func AlertMessage(notification _: NSNotification) {
    logger.debug("MainGameController.alertMessage()")

  }
