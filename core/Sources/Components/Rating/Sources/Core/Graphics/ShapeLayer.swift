//
//  ShapeLayer.swift
//  SparkCore
//
//  Created by michael.zimmermann on 08.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import UIKit

/// The Shape Layer draws a shape onto a layer and returns the CGLayer.
final class ShapeLayer {
    // MARK: - Private variables
    private let shape: CGPathShape
    private let fillColor: CGColor
    private let strokeColor: CGColor
    private let fillPercentage: CGFloat
    private let strokeWidth: CGFloat

    // MARK: - Initializer
    init(shape: CGPathShape,
         fillColor: CGColor,
         strokeColor: CGColor,
         fillPercentage: CGFloat,
         strokeWidth: CGFloat) {
        self.shape = shape
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.fillPercentage = fillPercentage
        self.strokeWidth = strokeWidth
    }

    /// Create a CGLayer and draw the shape on it.
    func layer(graphicsContext: CGContext, size: CGSize) -> CGLayer {
        guard let starLayer = CGLayer(graphicsContext, size: size, auxiliaryInfo: nil) else {
            fatalError("Couldn't create layer")
        }

        guard let context = starLayer.context else {
            fatalError("Couldn't create layer")
        }

        self.drawShape(graphicsContext: context, size: size)
        return starLayer
    }

    // MARK: - Private
    private func drawShape(graphicsContext: CGContext, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        let path = self.shape.cgPath(rect: rect)

        graphicsContext.saveGState()

        graphicsContext.clip(to: rect)
        graphicsContext.addPath(path)
        graphicsContext.setLineWidth(self.strokeWidth)
        graphicsContext.setStrokeColor(self.strokeColor)
        graphicsContext.drawPath(using: .stroke)

        let insets = self.shape.insets.withHorizontalPadding(self.strokeWidth / 2.0)
        let maskWidth = CGFloat((insets.right - insets.left) * fillPercentage)

        let maskHeight = rect.height

        let clipRect = CGRect(
            x: insets.left,
            y: 0,
            width: maskWidth,
            height: maskHeight
        )
        graphicsContext.clip(to: clipRect)
        graphicsContext.addPath(path)
        graphicsContext.setFillColor(self.fillColor)
        graphicsContext.drawPath(using: .fill)

        graphicsContext.addPath(path)
        graphicsContext.setStrokeColor(self.fillColor)
        graphicsContext.setLineWidth(self.strokeWidth)
        graphicsContext.drawPath(using: .stroke)

        graphicsContext.restoreGState()
    }
}

// MARK: Private extensions
private extension UIEdgeInsets {
    func withHorizontalPadding(_ padding: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.top, left: self.left - padding, bottom: self.bottom, right: self.right + padding)
    }
}
