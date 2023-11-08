//
//  StarUIView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 06.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//
//: A UIKit based Playground for presenting user interface

import UIKit

/// StarUIView
/// Render a star.
/// The star may be configured by various attributes:
/// - number of vertices
/// - corner radius
/// - vertex size
/// - border color
/// - fill color
///
public final class StarUIView: UIView {

    // MARK: - Default values
    public enum Defaults {
        public static let numberOfVertices = 5
        public static let fillMode = StarFillMode.half
        public static let rating = CGFloat(0.0)
        public static let lineWidth = CGFloat(2.0)
        public static let vertexSize = CGFloat(0.65)
        public static let cornerRadiusSize = CGFloat(0.15)
        public static let fillColor = UIColor.yellow
        public static let borderColor = UIColor.lightGray
    }

    // MARK: - Public variables
    /// The number of vertices the star has
    public var numberOfVertices: Int {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// The fill mode.
    /// The fill mode determines how to round the rating value to fill the star.
    public var fillMode: StarFillMode {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// The rating.
    /// The ration should be a value between 0...1. Any number greater than 1 will be taken as a full star. Any number smaller than 0 will be treated as 0.
    public var rating: CGFloat {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// The line width.
    /// The width of the border of the non filled star.
    public var lineWidth: CGFloat {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// The vertex size determins how deep the inner angle of the star is.
    /// This value is a percentage of the radius and should be in the range [0...1].
    public var vertexSize: CGFloat {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// The cornerRadiusSize is a proportional value
    /// This value is a percentage of the radius and should be in the range [0...1].
    public var cornerRadiusSize: CGFloat {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// The borderColor defines the color of the unfilled portion of the star.
    public var borderColor: UIColor {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// The fillColor defines the color of the filled portion of the star.
    public var fillColor: UIColor {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// IsCachingEnabled.
    /// Calculated stars will be cached for performance reasons. This may be disabled and the star will be calculated everytime when a redraw is required.
    public var isCachingEnabled = true

    public override var bounds: CGRect {
        didSet {
            self.setNeedsDisplay()
        }
    }

    // MARK: - Private variables
    private var cache: CGLayerCaching

    private var normalizedRating: CGFloat {
        return self.fillMode.rating(of: self.rating)
    }

    // MARK: - Initializer
    /// Initializer
    /// Parameters:
    /// - numberOfVertices: number of vertex elements, the default is 5
    /// - rating: the value of the rating. This should be a number in the range [0...1]
    /// - fillMode: the fill mode of the start. The star will be filled according to the rating and the fillMode.
    /// - lineWidth: the width of the outer border.
    /// - vertexSize: this is the proportional length of the vertex according to the radius and should be in the range [0..1].
    /// - cornerRadiusSize: this is a proportional size of the corner radius according to the radius and should be in the range [0...1].
    /// - borderColor: The color of the border of the unfilled part of the star.
    /// - fillColor: The color of the filled part of the star.
    public convenience init(
        numberOfVertices: Int = Defaults.numberOfVertices,
        rating: CGFloat = Defaults.rating,
        fillMode: StarFillMode = .half,
        lineWidth: CGFloat = Defaults.lineWidth,
        vertexSize: CGFloat = Defaults.vertexSize,
        cornerRadiusSize: CGFloat = Defaults.cornerRadiusSize,
        borderColor: UIColor = Defaults.borderColor,
        fillColor: UIColor = Defaults.fillColor
    ) {
        self.init(
            numberOfVertices: numberOfVertices,
            rating: rating,
            fillMode: fillMode,
            lineWidth: lineWidth,
            vertexSize: vertexSize,
            cornerRadiusSize: cornerRadiusSize,
            borderColor: borderColor,
            fillColor: fillColor,
            cache: CGLayerCache())
    }

    init(
        numberOfVertices: Int,
        rating: CGFloat,
        fillMode: StarFillMode,
        lineWidth: CGFloat,
        vertexSize: CGFloat,
        cornerRadiusSize: CGFloat,
        borderColor: UIColor,
        fillColor: UIColor,
        cache: CGLayerCaching
    ) {
        self.fillMode = fillMode
        self.rating = rating
        self.lineWidth = lineWidth
        self.numberOfVertices = numberOfVertices
        self.vertexSize = vertexSize
        self.cornerRadiusSize = cornerRadiusSize
        self.borderColor = borderColor
        self.fillColor = fillColor
        self.cache = cache

        super.init(frame: .zero)
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            super.draw(rect)
            return
        }
        self.drawLayer(context: ctx, rect: rect)
    }

    // MARK: - Private functions
    private func drawLayer(context: CGContext, rect: CGRect) {

        let star = Star(
            numberOfVertices: self.numberOfVertices,
            vertexSize: self.vertexSize,
            cornerRadiusSize: self.cornerRadiusSize
        )

        context.saveGState()

        let cacheKey = self.cacheKey(rect: rect)

        let starLayer: CGLayer
        if self.isCachingEnabled, let layer = self.cache.object(forKey: cacheKey) {
            starLayer = layer
        } else {
            let shapeLayer = ShapeLayer(
                shape: star,
                fillColor: self.fillColor.cgColor,
                strokeColor: self.borderColor.cgColor,
                fillPercentage: self.normalizedRating,
                strokeWidth: self.lineWidth)

            starLayer = shapeLayer.layer(graphicsContext: context, size: rect.size)
            if self.isCachingEnabled {
                self.cache.setObject(starLayer, forKey: self.cacheKey(rect: rect))
            }
        }

        context.draw(starLayer, in: rect)
        context.restoreGState()
    }

    // MARK: Internal functions
    internal func cacheKey(rect: CGRect) -> NSString {
        let key = [Self.self, 
                   self.numberOfVertices,
                   self.normalizedRating,
                   self.lineWidth,
                   self.vertexSize,
                   self.cornerRadiusSize,
                   self.borderColor.hashValue,
                   self.fillColor.hashValue,
                   min(rect.width, rect.height),
        ].map{ "\($0)" }
            .joined(separator: "_")
        return NSString(string: key)
    }
}

// MARK: Private extension
private extension CGRect {
    var centerX: CGFloat {
        return (self.minX + self.maxX)/2
    }

    var centerY: CGFloat {
        return (self.minY + self.maxY)/2
    }

    var center: CGPoint {
        return CGPoint(x: self.centerX, y: self.centerY)
    }
}
