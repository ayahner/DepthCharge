//
//  Alertable.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import SpriteKit

protocol Alertable {}
extension Alertable where Self: SKScene {
  func showAlert(withTitle title: String, message: String) {
    let alertController = UIAlertController(
         title: title, message: message, preferredStyle: .alert)

    let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
    alertController.addAction(okAction)

    view?.window?.rootViewController?.present(alertController, animated: true)
  }

  func showAlertWithActions(
    withTitle title: String, message: String, withActions actions: UIAlertAction...
  ) {
    let alertController = UIAlertController(
      title: title, message: message, preferredStyle: .alert)

    for action in actions {
      alertController.addAction(action)
    }

    view?.window?.rootViewController?.present(alertController, animated: true)
  }

  func showAlertWithSettings(withTitle title: String, message: String) {
    let alertController = UIAlertController(
      title: title, message: message, preferredStyle: .alert)

    let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
    alertController.addAction(okAction)

    let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
      guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
      if #available(iOS 10.0, *) {
        UIApplication.shared.open(url)
      } else {
        UIApplication.shared.openURL(url)
      }
    }
    alertController.addAction(settingsAction)

    view?.window?.rootViewController?.present(alertController, animated: true)
  }
}
