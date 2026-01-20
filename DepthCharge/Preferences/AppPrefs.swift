//
//  ApplicationPreferences.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import Foundation
import SpriteKit

enum Category: String, CaseIterable {
  case general = "General"
  case panel = "Panel"
  case button = "Button"
}

struct AppPrefs {
  private let plistFileName: String = "AppPrefs"
  public static let SCENE_TRANSITION_DURATION: TimeInterval = 1.0

  
  public static let INVALID_STRING: String = "<invalid property>"
  public static let DEFAULT_DOUBLE: Double = 1.0
  public static let DEFAULT_BOOL: Bool = false
  public static let DEFAULT_UICOLOR: UIColor = .white
  public static let DEFAULT_FONT_HORIZONTAL_MODE: SKLabelHorizontalAlignmentMode = .center
  public static let DEFAULT_FONT_VERTICAL_MODE: SKLabelVerticalAlignmentMode = .center

  public static let MIX_AMOUNT_LIGHT = "Mix Amount Light"
  public static let MIX_AMOUNT_HEAVY = "Mix Amount Heavy"

  /* Size: Double */
  public static let WIDTH = "Width"
  public static let HEIGHT = "Height"
  public static let LINE_WIDTH = "Line Width"
  public static let CORNER_RADIUS = "Corner Radius"
  public static let ENABLED_ALPHA = "Enabled Alpha"
  public static let DISABLED_ALPHA = "Disabled Alpha"
  public static let MARGIN_WIDTH = "Margin Width"
  public static let MARGIN_HEIGHT = "Margin Height"
  public static let MAX_COLUMNS = "Max Columns"
  public static let FONT_OFFSET_X = "Font Offset X"
  public static let FONT_OFFSET_Y = "Font Offset Y"
  public static let NAVIGATION_ICON_SIZE = "Navigation Icon Size"

  /* General: String */
  public static let FONT_NAME = "Font Name"
  public static let FONT_NAME_LIGHT = "Font Name Light"
  public static let FONT_NAME_SEMI_BOLD = "Font Name Semi Bold"
  public static let FONT_NAME_BOLD = "Font Name Bold"
  public static let FONT_NAME_CONDENSED_LIGHT = "Font Name Condensed Light"
  public static let FONT_NAME_CONDENSED = "Font Name Condensed"
  public static let FONT_NAME_CONDENSED_BOLD = "Font Name Condensed Bold"
  public static let SHOW_BACKGROUND = "Show Background"

  /* General: CGFloat */
  public static let FONT_SIZE = "Font Size"

  /* General: SKLabelHorizontalAlignmentMode */
  public static let FONT_HORIZONTAL_ALIGNMENT = "Font Horizontal Align"
  /* General: SKLabelVerticalAlignmentMode */
  public static let FONT_VERTICAL_ALIGNMENT = "Font Vertical Align"

  @MainActor
  static let shared = AppPrefs()
  private var dictionary: NSDictionary?

  private init() {
    if let path: String = Bundle.main.path(forResource: plistFileName, ofType: "plist") {
      if let dict = NSDictionary(contentsOfFile: path) {
        self.dictionary = dict
      } else {
        print("WARNING: Dictionary not found for path \(path). Returning default value.")
      }
    } else {
      print("WARNING: Path not found for '\(plistFileName).plist'")
    }
  }

  public func getBool(_ category: Category, _ key: String) -> Bool {
    if let buttonCategory = dictionary?[category.rawValue].self as? [String: Any] {
      if let value = buttonCategory[key] as? Bool {
        return value
      } else {
        printWarning(category, key, "Property not found. Returning default value.")
      }
    } else {
      printWarning(category, key, "Category not found. Returning default value.")
    }
    return AppPrefs.DEFAULT_BOOL
  }
  
  public func getDouble(_ category: Category, _ key: String) -> Double {
    if let buttonCategory = dictionary?[category.rawValue].self as? [String: Any] {
      if let value = buttonCategory[key] as? Double {
        return value
      } else {
        printWarning(category, key, "Property not found. Returning default value.")
      }
    } else {
      printWarning(category, key, "Category not found. Returning default value.")
    }
    return AppPrefs.DEFAULT_DOUBLE
  }

  public func getString(_ category: Category, _ key: String) -> String {
    if let buttonCategory = dictionary?[category.rawValue].self as? [String: Any] {
      if let value = buttonCategory[key] as? String {
        return value
      } else {
        printWarning(category, key, "Property not found. Returning default value.")
      }
    } else {
      printWarning(category, key, "Category not found. Returning default value.")
    }
    return AppPrefs.INVALID_STRING
  }

  public func getSKLabelHorizontalAlignmentMode(_ category: Category, _ key: String)
    -> SKLabelHorizontalAlignmentMode
  {
    let string = getString(category, key)
    switch string.lowercased() {
    case "left":
      return .left
    case "center":
      return .center
    case "right":
      return .right
    default:
      printWarning(category, key, "Invalid value '\(string)'. Expected ['Left','Center','Right']. Returning default value.")
      return AppPrefs.DEFAULT_FONT_HORIZONTAL_MODE
    }
  }

  public func getSKLabelVerticalAlignmentMode(_ category: Category, _ key: String)
    -> SKLabelVerticalAlignmentMode
  {
    let string = getString(category, key)
    switch string.lowercased() {
    case "baseline":
      return .baseline
    case "top":
      return .top
    case "center":
      return .center
    case "bottom":
      return .bottom
    default:
      printWarning(category, key, "Invalid value '\(string)'. Expected ['Baseline', 'Top','Center','Bottom']. Returning default value.")
      return AppPrefs.DEFAULT_FONT_VERTICAL_MODE
    }
  }

  func printWarning(_ category: Category, _ key: String, _ text: String) {
    print("WARNING: \(plistFileName).plist->'\(category.rawValue)'->'\(key)'): \(text)")
  }
}
