//
//  SpriteButton.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import Foundation
import SpriteKit
import os

class SpriteButton: SKSpriteNode, Button {
  
  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "SpriteButton")
  
  var skLabel = SKLabelNode()
  
  var actionType: ActionType = .normal
  
  var enabled = true {
    didSet {
      if enabled {
        alpha = AppPrefs.shared.getDouble(Category.button, AppPrefs.ENABLED_ALPHA)
      } else {
        alpha = AppPrefs.shared.getDouble(Category.button, AppPrefs.DISABLED_ALPHA)
      }
    }
  }

  init(_ name: String, imageNamedString: String, buttonText: String = "") {
    let texture = SKTexture(imageNamed: imageNamedString)
    super.init(texture: texture, color: .clear, size: texture.size())
    self.name = name
    self.skLabel.text = buttonText
    self.skLabel.fontName = AppPrefs.shared.getString(Category.button, AppPrefs.FONT_NAME)
    self.skLabel.fontSize = AppPrefs.shared.getDouble(Category.button, AppPrefs.FONT_SIZE)
    self.skLabel.horizontalAlignmentMode = AppPrefs.shared.getSKLabelHorizontalAlignmentMode(Category.button, AppPrefs.FONT_HORIZONTAL_ALIGNMENT)
    self.skLabel.verticalAlignmentMode = AppPrefs.shared.getSKLabelVerticalAlignmentMode(Category.button, AppPrefs.FONT_VERTICAL_ALIGNMENT)
    self.skLabel.fontColor = UIColor.appDarkest
    addChild(skLabel)

    self.actionType = .normal
    self.isUserInteractionEnabled = true
  }

  convenience init(_ name: String, systemName: String) {
    let optionsTexture = SKTexture(
      systemName: systemName,
      pointSize: AppPrefs.shared.getDouble(Category.general, AppPrefs.NAVIGATION_ICON_SIZE),
      color: UIColor.appLight)
    self.init(texture: optionsTexture, color: .clear, size: optionsTexture!.size())
    self.name = name
  }

  convenience init(_ name: String, systemName: String, pointSize: CGFloat, color: UIColor) {
    let optionsTexture = SKTexture(
      systemName: systemName,
      pointSize: pointSize,
      color: color)
    self.init(texture: optionsTexture, color: .clear, size: optionsTexture!.size())
    self.name = name
  }
  
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
    self.isUserInteractionEnabled = true
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
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
