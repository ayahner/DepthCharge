//
//  SKTextureExtension.swift
//  DepthCharge
//
//  Created by Andrew Yahner on 8/4/25.
//  Copyright © 2025 SquatchCode. All rights reserved.
//

import SpriteKit

extension SKTexture {
  convenience init?(systemName: String, pointSize: CGFloat, color: UIColor = .white) {
    let config = UIImage.SymbolConfiguration(pointSize: pointSize)
    guard let symbol = UIImage(systemName: systemName)?.applyingSymbolConfiguration(config) else { return nil }

    let rect = CGRect(origin: .zero, size: symbol.size)
    let renderer = UIGraphicsImageRenderer(size: rect.size)
    let result = renderer.image { ctx in
      ctx.cgContext.setFillColor(color.cgColor)
      ctx.fill(rect)
      ctx.cgContext.translateBy(x: 0, y: rect.height)
      ctx.cgContext.scaleBy(x: 1, y: -1)
      ctx.cgContext.setBlendMode(.destinationIn)
      ctx.cgContext.draw(symbol.cgImage!, in: rect)
    }
    self.init(image: result)
  }
}
