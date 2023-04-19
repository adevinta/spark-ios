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

    public init(selectionIcon: UIImage) {
        self.selectionIcon = selectionIcon
        super.init(frame: .zero)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    private func commonInit() {
        backgroundColor = .clear
        clipsToBounds = false
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
        return iconSize.scaled
    }

    private let offset: CGFloat = 2
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard
            let colors = self.colors,
            let ctx = UIGraphicsGetCurrentContext()
        else { return }

        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        let scaledSpacing = bodyFontMetrics.scaledValue(for: 20.0) + 8

        let controlRect = CGRect(x: 0, y: 0, width: scaledSpacing, height: scaledSpacing)
        let controlInnerRect = controlRect.insetBy(dx: 4, dy: 4)

        if isPressed {
            let lineWidth: CGFloat = 4
            let pressedBorderRectangle = controlRect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let borderPath = UIBezierPath(roundedRect: pressedBorderRectangle, cornerRadius: 6)
            borderPath.lineWidth = lineWidth
            colors.pressedBorderColor.uiColor.setStroke()
            ctx.setStrokeColor(colors.pressedBorderColor.uiColor.cgColor)
            borderPath.stroke()
        }

        let color = colors.checkboxTintColor.uiColor
        ctx.setStrokeColor(color.cgColor)
        ctx.setFillColor(color.cgColor)
        let rectangle = controlInnerRect.insetBy(dx: offset/2, dy: offset/2)

        let path = UIBezierPath(roundedRect: rectangle, cornerRadius: 4)
        path.lineWidth = 2
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
            let iconPath = UIBezierPath(roundedRect: iconRect, cornerRadius: 4)
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
            selectionIcon.draw(in: iconRect)
        }
    }
}

private extension CGSize {
    var scaled: CGSize {
        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        let scaledWidth = bodyFontMetrics.scaledValue(for: width)
        let scaledHeight = bodyFontMetrics.scaledValue(for: height)
        return CGSize(width: scaledWidth, height: scaledHeight)
    }
}
