//
//  ShapeButton.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import Foundation
import SpriteKit
import os

class ShapeButton: SKShapeNode, Button {
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "ShapeButton")

  var skLabel: SKLabelNode = SKLabelNode()
  var cornerRadius: CGFloat = 10
  var size: CGSize = CGSize.zero

  var actionType: ActionType = .normal { didSet { setButtonPalette() } }

  var enabled = true {
    didSet {
      if enabled {
        alpha = AppPrefs.shared.getDouble(Category.button, AppPrefs.ENABLED_ALPHA)
      } else {
        alpha = AppPrefs.shared.getDouble(Category.button, AppPrefs.DISABLED_ALPHA)
      }
    }
  }

  init(_ name: String, buttonText: String = "") {
    super.init()

    self.name = name
    size = CGSize(
      width: AppPrefs.shared.getDouble(Category.button, AppPrefs.WIDTH),
      height: AppPrefs.shared.getDouble(Category.button, AppPrefs.HEIGHT)
    )

    lineWidth = AppPrefs.shared.getDouble(Category.button, AppPrefs.LINE_WIDTH)
    cornerRadius = AppPrefs.shared.getDouble(Category.button, AppPrefs.CORNER_RADIUS)

    skLabel.text = buttonText
    skLabel.fontName = AppPrefs.shared.getString(Category.button, AppPrefs.FONT_NAME)
    skLabel.fontSize = AppPrefs.shared.getDouble(Category.button, AppPrefs.FONT_SIZE)
    skLabel.horizontalAlignmentMode = AppPrefs.shared.getSKLabelHorizontalAlignmentMode(Category.button, AppPrefs.FONT_HORIZONTAL_ALIGNMENT)
    skLabel.verticalAlignmentMode = AppPrefs.shared.getSKLabelVerticalAlignmentMode(Category.button, AppPrefs.FONT_VERTICAL_ALIGNMENT)
    skLabel.position = CGPoint(
      x: AppPrefs.shared.getDouble(Category.button, AppPrefs.FONT_OFFSET_X),
      y: AppPrefs.shared.getDouble(Category.button, AppPrefs.FONT_OFFSET_Y))
    self.actionType = .normal
    setButtonPalette()
    addChild(skLabel)
    self.isUserInteractionEnabled = true
  }

  func setButtonPalette() {
    switch actionType {
    case .happy:
      fillColor = UIColor.appHappy
      strokeColor = UIColor.appDarkest
      skLabel.fontColor = UIColor.appLightest
    case .angry:
      fillColor = UIColor.appAngry
      strokeColor = UIColor.appDarkest
      skLabel.fontColor = UIColor.appLightest
    default:
      fillColor = UIColor.appLightest
      strokeColor = UIColor.appDarkest
      skLabel.fontColor = UIColor.appDarkest
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func addChild(_ node: SKNode) {
    super.addChild(node)
    recalculateLayout()
  }

  func recalculateLayout() {
    let origin = CGPoint(x: -size.width / 2, y: -size.height / 2)
    let roundedRect = CGRect(origin: origin, size: size)
    path = CGPath(
      roundedRect: roundedRect,
      cornerWidth: cornerRadius,
      cornerHeight: cornerRadius,
      transform: nil)
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
}
