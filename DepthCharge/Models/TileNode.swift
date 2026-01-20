//
//  Tile.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/5/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import Foundation
import SpriteKit
import os

class TileNode: SKSpriteNode {

  enum TileState {
    case hidden
    case revealed
    case marked
    case bomb
  }

  var row = 0
  var col = 0
  
  var hasBomb: Bool = false
  var neighborBombs: Int = 0
  var state: TileState = .hidden

  func reveal() {
          guard state == .hidden else { return }
          state = .revealed
          updateAppearance()
      }

      func updateAppearance() {
          switch state {
          case .hidden:
              color = .gray
          case .revealed:
              color = .lightGray
              if hasBomb {
                  // Show bomb image
              } else if neighborBombs > 0 {
                  // Show number
              }
          case .marked:
              color = .yellow
          case .bomb:
              color = .red
          }
      }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let scaleDown = SKAction.scale(to: 0.8, duration: 0.1)
    let scaleUp = SKAction.scale(to: 1.0, duration: 0.1)
    self.run(SKAction.sequence([scaleDown, scaleUp])) {
      self.scene?.touchesBegan(touches, with: event)
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    scene?.touchesEnded(touches, with: event)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
