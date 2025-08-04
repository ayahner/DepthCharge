//
//  TargetReticle.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import SpriteKit

extension SKShapeNode {
  /// Creates a target-reticle shape node with concentric circles and crosshairs.
  static func targetReticle(
    radius: CGFloat,
    ringCount: Int = 3,
    ringWidth: CGFloat = 2,
    spacing: CGFloat = 15,
    lineLength: CGFloat? = nil,
    lineWidth: CGFloat = 2,
    color: SKColor = .white
  ) -> SKShapeNode {
    let totalRadius = radius + spacing * CGFloat(ringCount - 1)
    let crosshairLength = lineLength ?? totalRadius * 1.1
    let path = CGMutablePath()

    // Draw concentric circles
    for i in 0..<ringCount {
      let r = radius + spacing * CGFloat(i)
      path.addEllipse(in: CGRect(x: -r, y: -r, width: 2 * r, height: 2 * r))
    }

    // Draw crosshair lines (vertical + horizontal)
    let half = crosshairLength / 2
    path.move(to: CGPoint(x: -half, y: 0))
    path.addLine(to: CGPoint(x: half, y: 0))
    path.move(to: CGPoint(x: 0, y: -half))
    path.addLine(to: CGPoint(x: 0, y: half))

    let node = SKShapeNode(path: path)
    node.strokeColor = color
    node.lineWidth = ringWidth
    node.glowWidth = lineWidth / 2
    node.zPosition = 100
    return node
  }
}
