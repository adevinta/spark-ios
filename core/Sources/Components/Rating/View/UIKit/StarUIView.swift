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

    // MARK: - Public variables
    /// The number of vertices the star has
    public var numberOfVertices: Int {
        get {
            return self.configuration.numberOfVertices
        }
        set {
            self.configuration.numberOfVertices = newValue
        }
    }
    
    /// The vertex size determins how deep the inner angle of the star is.
    /// This value is a percentage of the radius and should be in the range [0...1].
    public var vertexSize: CGFloat {
        get {
            return self.configuration.vertexSize
        }
        set {
            self.configuration.vertexSize = newValue
        }
    }

    /// The cornerRadiusSize is a proportional value
    /// This value is a percentage of the radius and should be in the range [0...1].
    public var cornerRadiusSize: CGFloat {
        get {
            return self.configuration.cornerRadiusSize
        }
        set {
            self.configuration.cornerRadiusSize = newValue
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
    
    public var configuration: StarConfiguration {
        didSet {
            guard self.configuration != oldValue else { return }
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
    /// Create a StarUIView with the following parameters
    /// 
    /// - Parameters:
    /// - rating: the value of the rating. This should be a number in the range [0...1]
    /// - fillMode: the fill mode of the start. The star will be filled according to the rating and the fillMode.
    /// - lineWidth: the width of the outer border.
    /// - borderColor: The color of the border of the unfilled part of the star.
    /// - fillColor: The color of the filled part of the star.
    /// - configuration: StarConfiguration, a configuration of the star appearance. The default is `default`.
    public convenience init(
        rating: CGFloat = StarDefaults.rating,
        fillMode: StarFillMode = .half,
        lineWidth: CGFloat = StarDefaults.lineWidth,
        borderColor: UIColor,
        fillColor: UIColor,
        configuration: StarConfiguration = .default
    ) {
        self.init(
            rating: rating,
            fillMode: fillMode,
            lineWidth: lineWidth,
            borderColor: borderColor,
            fillColor: fillColor,
            configuration: configuration,
            cache: CGLayerCache())
    }

    init(
        rating: CGFloat,
        fillMode: StarFillMode,
        lineWidth: CGFloat,
        borderColor: UIColor,
        fillColor: UIColor,
        configuration: StarConfiguration,
        cache: CGLayerCaching
    ) {
        self.fillMode = fillMode
        self.rating = rating
        self.lineWidth = lineWidth
        self.configuration = configuration
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
                   self.borderColor.rgb,
                   self.fillColor.rgb,
                   min(rect.width, rect.height),
        ].map{ "\($0)" }
            .joined(separator: "_")
        return NSString(string: key)
    }
}

// MARK: Private extension
private extension UIColor {
    var rgb: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return "\(red)-\(green)-\(blue)-\(alpha)"
    }
}
