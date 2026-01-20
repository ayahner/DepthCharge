//
//  Updatable.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import Foundation

protocol Updatable: AnyObject {
  func update(_ currentTime: TimeInterval)
}
