//
//  Updatable.swift
//  FortyFives
//
//  Created by Andrew Yahner on 4/2/25.
//  Copyright © 2025 Thoroughcity. All rights reserved.
//

import Foundation

protocol Updatable: AnyObject {
  func update(_ currentTime: TimeInterval)
}
