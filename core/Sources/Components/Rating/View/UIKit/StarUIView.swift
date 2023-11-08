//
//  StarUIView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 06.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//
//: A UIKit based Playground for presenting user interface

import UIKit

public class StarUIView: UIView {

    // MARK: - Default values
    public enum Defaults {
        public static let numberOfPoints = 5
        public static let fillMode = StarFillMode.half
        public static let rating = CGFloat(0.0)
        public static let lineWidth = CGFloat(2.0)
        public static let vertexSize = CGFloat(0.75)
        public static let cornerRadiusSize = CGFloat(0.125)
        public static let fillColor = UIColor.yellow
        public static let borderColor = UIColor.lightGray
    }

    // MARK: - Public variables
    public var numberOfPoints: Int {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public var fillMode: StarFillMode {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public var rating: CGFloat {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public var lineWidth: CGFloat {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public var vertexSize: CGFloat {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public var cornerRadiusSize: CGFloat {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public var borderColor: UIColor {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public var fillColor: UIColor {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public var isCachingEnabled = true

    // MARK: - Private variables
    private static var cache = NSCache<NSString, CGLayer>()
    private var normalizedRating: CGFloat {
        return self.fillMode.rating(of: self.rating)
    }

    // MARK: - Initializer
    public init(
        numberOfPoints: Int = Defaults.numberOfPoints,
        rating: CGFloat = Defaults.rating,
        fillMode: StarFillMode = .half,
        lineWidth: CGFloat = Defaults.lineWidth,
        vertexSize: CGFloat = Defaults.vertexSize,
        cornerRadiusSize: CGFloat = Defaults.cornerRadiusSize,
        borderColor: UIColor = Defaults.borderColor,
        fillColor: UIColor = Defaults.fillColor
    ) {
        self.fillMode = fillMode
        self.rating = rating
        self.lineWidth = lineWidth
        self.numberOfPoints = numberOfPoints
        self.vertexSize = vertexSize
        self.cornerRadiusSize = cornerRadiusSize
        self.borderColor = borderColor
        self.fillColor = fillColor

        super.init(frame: .zero)
        self.backgroundColor = .clear
    }

    override init(frame: CGRect) {
        self.fillMode = Defaults.fillMode
        self.rating = Defaults.rating
        self.lineWidth = Defaults.lineWidth
        self.numberOfPoints = Defaults.numberOfPoints
        self.vertexSize = Defaults.vertexSize
        self.cornerRadiusSize = Defaults.cornerRadiusSize
        self.borderColor = Defaults.borderColor
        self.fillColor = Defaults.fillColor

        super.init(frame: frame)
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
            numberOfPoints: self.numberOfPoints,
            vertexSize: self.vertexSize,
            cornerRadiusSize: self.cornerRadiusSize
        )

        context.saveGState()

        let cacheKey = self.cacheKey(rect: rect)

        let starLayer: CGLayer
        if self.isCachingEnabled, let layer = Self.cache.object(forKey: cacheKey) {
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
                Self.cache.setObject(starLayer, forKey: self.cacheKey(rect: rect))
            }
        }

        context.draw(starLayer, in: rect)
        context.restoreGState()
    }

    internal func cacheKey(rect: CGRect) -> NSString {
        let key = [Self.self, self.numberOfPoints, self.rating, self.lineWidth, self.vertexSize, self.cornerRadiusSize, self.borderColor.hashValue, self.fillColor.hashValue, rect.width, rect.height
        ].map{ "\($0)" }
            .joined(separator: "_")
        return NSString(string: key)
    }
}


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
