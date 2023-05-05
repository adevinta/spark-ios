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
    // MARK: - Properties.

    var selectionIcon: UIImage

    var isPressed: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var selectionState: CheckboxSelectionState = .unselected {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var colors: CheckboxColorables? {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var theme: Theme

    // MARK: - Initialization

    init(selectionIcon: UIImage, theme: Theme) {
        self.selectionIcon = selectionIcon
        self.theme = theme
        super.init(frame: .zero)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    private func commonInit() {
        self.backgroundColor = .clear
        self.clipsToBounds = false
        self.setNeedsDisplay()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.setNeedsDisplay()
    }

    private var iconSize: CGSize {
        let iconSize: CGSize
        switch self.selectionState {
        case .unselected:
            return .zero
        case .selected:
            iconSize = CGSize(width: 14, height: 10)
        case .indeterminate:
            iconSize = CGSize(width: 12, height: 2)
        }
        return iconSize.scaled(for: self.traitCollection)
    }

    private var spacing: LayoutSpacing {
        return self.theme.layout.spacing
    }

    private enum Constants {
        static let cornerRadius: CGFloat = 4
        static let cornerRadiusPressed: CGFloat = 7
        static let lineWidth: CGFloat = 2
        static let lineWidthPressed: CGFloat = 4
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard
            let colors = self.colors,
            let ctx = UIGraphicsGetCurrentContext()
        else { return }

        let spacing = self.spacing
        let traitCollection = self.traitCollection

        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)

        let scaledSpacing = bodyFontMetrics.scaledValue(for: spacing.xLarge + spacing.small, compatibleWith: traitCollection) //+ spacing.medium

        let controlRect = CGRect(x: 0, y: 0, width: scaledSpacing, height: scaledSpacing)
        let controlInnerRect = controlRect.insetBy(dx: bodyFontMetrics.scaledValue(for: spacing.small, compatibleWith: traitCollection), dy: bodyFontMetrics.scaledValue(for: spacing.small, compatibleWith: traitCollection))

        if self.isPressed {
            let lineWidth: CGFloat = bodyFontMetrics.scaledValue(for: Constants.lineWidthPressed, compatibleWith: traitCollection)
            let pressedBorderRectangle = controlRect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let borderPath = UIBezierPath(roundedRect: pressedBorderRectangle, cornerRadius: bodyFontMetrics.scaledValue(for: Constants.cornerRadiusPressed, compatibleWith: traitCollection))
            borderPath.lineWidth = lineWidth
            colors.pressedBorderColor.uiColor.setStroke()
            ctx.setStrokeColor(colors.pressedBorderColor.uiColor.cgColor)
            borderPath.stroke()
        }

        let color = colors.checkboxTintColor.uiColor
        ctx.setStrokeColor(color.cgColor)
        ctx.setFillColor(color.cgColor)

        let scaledOffset = bodyFontMetrics.scaledValue(for: Constants.lineWidth, compatibleWith: traitCollection)
        let rectangle = controlInnerRect.insetBy(dx: scaledOffset/2, dy: scaledOffset/2)

        let path = UIBezierPath(roundedRect: rectangle, cornerRadius: bodyFontMetrics.scaledValue(for: Constants.cornerRadius, compatibleWith: traitCollection))
        path.lineWidth = scaledOffset
        color.setStroke()
        color.setFill()

        let iconSize = self.iconSize
        switch self.selectionState {
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
            self.selectionIcon.draw(in: iconRect)
        }
    }
}
