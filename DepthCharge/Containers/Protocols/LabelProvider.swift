//
//  LabelProvider.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import SpriteKit

protocol LabelProvider {
  
  /// Makes the SKLabelNode a label based on this containers default settings
  /// - Parameter label: label to convert to this container's default settings
  func initLabel(_ label: SKLabelNode)
  
  /// Makes the SKLabelNode a label based on this containers default settings
  /// Usually, a call to initLabel should be done first to reduce code
  /// - Parameter label: label to convert to this container's default Title settings
  func makeTitle(_ label: SKLabelNode)
}
