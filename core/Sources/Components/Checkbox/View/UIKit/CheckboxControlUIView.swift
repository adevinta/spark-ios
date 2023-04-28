//
//  CheckboxControlUIView.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 18.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

class CheckboxControlUIView: UIView {
    var selectionIcon: UIImage

    var isPressed: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

    var selectionState: CheckboxSelectionState = .unselected {
        didSet {
            setNeedsDisplay()
        }
    }

    var colors: CheckboxColorables? {
        didSet {
            setNeedsDisplay()
        }
    }

    var theming: Theme

    public init(selectionIcon: UIImage, theming: Theme) {
        self.selectionIcon = selectionIcon
        self.theming = theming
        self.theming = theming
        super.init(frame: .zero)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    private func commonInit() {
        backgroundColor = .clear
        clipsToBounds = false
        setNeedsDisplay()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setNeedsDisplay()
    }

    var iconSize: CGSize {
        let iconSize: CGSize
        switch selectionState {
        case .unselected:
            return .zero
        case .selected:
            iconSize = CGSize(width: 14, height: 10)
        case .indeterminate:
            iconSize = CGSize(width: 12, height: 2)
        }
        return iconSize.scaled(for: traitCollection)
    }

    private var spacing: LayoutSpacing {
        theming.layout.spacing
    }

    private enum Constants {
        static let cornerRadius: CGFloat = 4
        static let lineWidth: CGFloat = 2
        static let lineWidthPressed: CGFloat = 4
    }

    private let offset: CGFloat = 2
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard
            let colors = self.colors,
            let ctx = UIGraphicsGetCurrentContext()
        else { return }

        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        let scaledSpacing = bodyFontMetrics.scaledValue(for: spacing.xLarge - spacing.small, compatibleWith: traitCollection) + spacing.medium

        let controlRect = CGRect(x: 0, y: 0, width: scaledSpacing, height: scaledSpacing)
        let controlInnerRect = controlRect.insetBy(dx: spacing.small, dy: spacing.small)

        if isPressed {
            let lineWidth: CGFloat = Constants.lineWidthPressed
            let pressedBorderRectangle = controlRect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let borderPath = UIBezierPath(roundedRect: pressedBorderRectangle, cornerRadius: bodyFontMetrics.scaledValue(for: Constants.cornerRadius, compatibleWith: traitCollection)+2)
            borderPath.lineWidth = lineWidth
            colors.pressedBorderColor.uiColor.setStroke()
            ctx.setStrokeColor(colors.pressedBorderColor.uiColor.cgColor)
            borderPath.stroke()
        }

        let color = colors.checkboxTintColor.uiColor
        ctx.setStrokeColor(color.cgColor)
        ctx.setFillColor(color.cgColor)
        let scaledOffset = bodyFontMetrics.scaledValue(for: offset, compatibleWith: traitCollection)
        let rectangle = controlInnerRect.insetBy(dx: scaledOffset/2, dy: scaledOffset/2)

        let path = UIBezierPath(roundedRect: rectangle, cornerRadius: bodyFontMetrics.scaledValue(for: Constants.cornerRadius, compatibleWith: traitCollection))
        path.lineWidth = bodyFontMetrics.scaledValue(for: Constants.lineWidth, compatibleWith: traitCollection)
        color.setStroke()
        color.setFill()

        let iconSize = self.iconSize
        switch selectionState {
        case .unselected:
            path.stroke()

        case .indeterminate:
            path.stroke()
            path.fill()

            let origin = CGPoint(
                x: controlInnerRect.origin.x + controlInnerRect.width / 2 - iconSize.width / 2,
                y: controlInnerRect.origin.y + controlInnerRect.height / 2 - iconSize.height / 2
            )
            let iconRect = CGRect(origin: origin, size: iconSize)
            let iconPath = UIBezierPath(roundedRect: iconRect, cornerRadius: bodyFontMetrics.scaledValue(for: iconSize.height / 2, compatibleWith: traitCollection))
            colors.checkboxIconColor.uiColor.setFill()
            iconPath.fill()

        case .selected:
            path.stroke()
            path.fill()

            let origin = CGPoint(
                x: controlInnerRect.origin.x + controlInnerRect.width / 2 - iconSize.width / 2,
                y: controlInnerRect.origin.y + controlInnerRect.height / 2 - iconSize.height / 2
            )
            let iconRect = CGRect(origin: origin, size: iconSize)
            colors.checkboxIconColor.uiColor.set()
            selectionIcon.draw(in: iconRect)
        }
    }
}
