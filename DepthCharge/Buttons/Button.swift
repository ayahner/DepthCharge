//
//  Button.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import Foundation
import SpriteKit

enum ActionType {
  case normal
  case happy
  case angry
}

protocol Clickable {
    var name: String? { get }
}

protocol Button: SKNode, Clickable {
  var enabled: Bool { get set }
  var actionType: ActionType { get set }
  var size: CGSize { get }
}

