//
//  PopoverBackgroundView.swift
//  SparkCore
//
//  Created by louis.borlee on 26/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

final class PopoverBackgroundView: UIPopoverBackgroundView {

    override class func contentViewInsets() -> UIEdgeInsets {
        return .zero
    }

    override class func arrowHeight() -> CGFloat {
        return PopoverBackgroundConfiguration.arrowSize
    }

    private var direction: UIPopoverArrowDirection = .any
    override var arrowDirection: UIPopoverArrowDirection {
        get { return self.direction }
        set {
            guard newValue != self.direction else { return }
            self.direction = newValue
            self.setNeedsLayout()
        }
    }

    private var offset: CGFloat = .zero
    override var arrowOffset: CGFloat {
        get { return self.offset }
        set {
            guard newValue != self.offset else { return }
            self.offset = newValue
            self.setNeedsLayout()
        }
    }

    private var leadingConstraint: NSLayoutConstraint = .init()
    private var trailingConstraint: NSLayoutConstraint = .init()
    private var topConstraint: NSLayoutConstraint = .init()
    private var bottomConstraint: NSLayoutConstraint = .init()

    private var previouslyModifiedConstraint: NSLayoutConstraint?

    private var arrowShape: CAShapeLayer?

    private let cornerRadius = 8.0
    private let spacing = 0.0

    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.backgroundColor = .clear

        let backgroundView = self.createBackgroundView()
        self.addSubview(backgroundView)

        self.leadingConstraint = backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        self.trailingConstraint = backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        self.topConstraint = backgroundView.topAnchor.constraint(equalTo: self.topAnchor)
        self.bottomConstraint = backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        NSLayoutConstraint.activate([
            self.leadingConstraint,
            self.trailingConstraint,
            self.topConstraint,
            self.bottomConstraint
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        let arrowHeight = Self.arrowHeight()
        self.previouslyModifiedConstraint?.constant = 0
        var path: CGPath?
        let shouldDrawArrow = PopoverBackgroundConfiguration.showArrow
        switch self.arrowDirection {
        case .left:
            self.leadingConstraint.constant = arrowHeight + self.spacing
            self.previouslyModifiedConstraint = self.leadingConstraint
            if PopoverBackgroundConfiguration.arrowSize > 0 {
                path = self.getLeftArrowPath()
            }
        case .right:
            self.trailingConstraint.constant = -(arrowHeight + self.spacing)
            self.previouslyModifiedConstraint = self.trailingConstraint
            if shouldDrawArrow {
                path = self.getRightArrowPath()
            }
        case .up:
            self.topConstraint.constant = arrowHeight + self.spacing
            self.previouslyModifiedConstraint = self.topConstraint
            if shouldDrawArrow {
                path = self.getUpArrowPath()
            }
        case.down:
            self.bottomConstraint.constant = -(arrowHeight + self.spacing)
            self.previouslyModifiedConstraint = self.bottomConstraint
            if shouldDrawArrow {
                path = self.getDownArrowPath()
            }
        default:
            self.previouslyModifiedConstraint = nil
        }

        self.arrowShape?.removeFromSuperlayer()
        if let path {
            let shape = CAShapeLayer()
            shape.path = path
            shape.fillColor = PopoverBackgroundConfiguration.backgroundColor.cgColor
            self.layer.insertSublayer(shape, at: 0)
            self.arrowShape = shape
        }
    }

    // MARK: - Background Image
    private func createBackgroundView() -> UIView {
        let view = UIView(frame: .init(origin: .zero, size: .zero))
        view.layer.cornerRadius = self.cornerRadius
        view.backgroundColor = PopoverBackgroundConfiguration.backgroundColor
        view.isOpaque = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    // MARK: - Arrow
    /// Used for getting left and right arrow tip y position taking cornerRadius into account
    private func getTipY(arrowHeight: CGFloat) -> CGFloat {
        let estimatedTipY = (self.frame.height / 2) + self.arrowOffset
        let maxTipY = self.frame.height - self.cornerRadius - arrowHeight
        let minTipY = self.cornerRadius + arrowHeight

        // Bounded value between min and max tip y
        return max(minTipY, min(estimatedTipY, maxTipY))
    }

    private func getLeftArrowPath() -> CGPath {
        let arrowHeight = Self.arrowHeight()

        let tipY = self.getTipY(arrowHeight: arrowHeight)

        let tip = CGPoint(x: 0, y: tipY)
        let topRightCorner = tip.applying(.init(translationX: arrowHeight, y: -arrowHeight))
        let bottomRightCorner = tip.applying(.init(translationX: arrowHeight, y: arrowHeight))

        return self.getTrianglePath(point1: tip, point2: topRightCorner, point3: bottomRightCorner)
    }

    private func getRightArrowPath() -> CGPath {
        let arrowHeight = Self.arrowHeight()

        let tipY = self.getTipY(arrowHeight: arrowHeight)

        let tip = CGPoint(x: self.frame.width, y: tipY)
        let topLeftCorner = tip.applying(.init(translationX: -arrowHeight, y: -arrowHeight))
        let bottomLeftCorner = tip.applying(.init(translationX: -arrowHeight, y: arrowHeight))

        return self.getTrianglePath(point1: tip, point2: topLeftCorner, point3: bottomLeftCorner)
    }

    /// Used for getting up and down arrow tip x position taking cornerRadius into account
    private func getTipX(arrowHeight: CGFloat) -> CGFloat {
        let estimatedTipX = (self.frame.width / 2) + self.arrowOffset
        let maxTipX = self.frame.width - self.cornerRadius - arrowHeight
        let minTipX = self.cornerRadius + arrowHeight

        // Bounded value between min and max tip x
        return max(minTipX, min(estimatedTipX, maxTipX))
    }

    private func getUpArrowPath() -> CGPath {
        let arrowHeight = Self.arrowHeight()

        let tipX = self.getTipX(arrowHeight: arrowHeight)

        let tip = CGPoint(x: tipX, y: 0)
        let bottomLeftCorner = tip.applying(.init(translationX: -arrowHeight, y: arrowHeight))
        let bottomRightCorner = tip.applying(.init(translationX: arrowHeight, y: arrowHeight))

        return self.getTrianglePath(point1: tip, point2: bottomLeftCorner, point3: bottomRightCorner)
    }

    private func getDownArrowPath() -> CGPath {
        let arrowHeight = Self.arrowHeight()

        let tipX = self.getTipX(arrowHeight: arrowHeight)

        let tip = CGPoint(x: tipX, y: self.frame.height)
        let topLeftCorner = tip.applying(.init(translationX: -arrowHeight, y: -arrowHeight))
        let topRightCorner = tip.applying(.init(translationX: arrowHeight, y: -arrowHeight))

        return self.getTrianglePath(point1: tip, point2: topLeftCorner, point3: topRightCorner)
    }

    private func getTrianglePath(point1: CGPoint, point2: CGPoint, point3: CGPoint) -> CGPath {
        let path = CGMutablePath()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point1)
        return path
    }
}
