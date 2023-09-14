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

    // MARK: - Constants

    private enum Constants {
        static var cornerRadius: CGFloat = 4
        static var cornerRadiusPressed: CGFloat = 7
        static var lineWidth: CGFloat = 2
        static var lineWidthPressed: CGFloat = 4
        static var controlSize: CGFloat = 20
    }

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

    var colors: CheckboxStateColors? {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var theme: Theme

    var state: CheckboxState

    @ScaledUIMetric private var cornerRadius: CGFloat = Constants.cornerRadius
    @ScaledUIMetric private var cornerRadiusPressed: CGFloat = Constants.cornerRadiusPressed
    @ScaledUIMetric private var lineWidth: CGFloat = Constants.lineWidth
    @ScaledUIMetric private var lineWidthPressed: CGFloat = Constants.lineWidthPressed
    @ScaledUIMetric private var controlSize: CGFloat = Constants.controlSize

    // MARK: - Initialization

    init(selectionIcon: UIImage, theme: Theme, state: CheckboxState) {
        self.selectionIcon = selectionIcon
        self.theme = theme
        self.state = state
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

    // MARK: - Methods

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let traitCollection = self.traitCollection
        _cornerRadius.update(traitCollection: traitCollection)
        _cornerRadiusPressed.update(traitCollection: traitCollection)
        _lineWidth.update(traitCollection: traitCollection)
        _lineWidthPressed.update(traitCollection: traitCollection)
        _controlSize.update(traitCollection: traitCollection)

        self.setNeedsDisplay()
    }

    private var iconSize: CGSize {
        let iconSize: CGSize
        switch self.selectionState {
        case .unselected:
            return .zero
        case .selected:
            iconSize = CGSize(width: 14, height: 14)
        case .indeterminate:
            iconSize = CGSize(width: 12, height: 2)
        }
        return iconSize.scaled(for: self.traitCollection)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard
            let colors = self.colors,
            let ctx = UIGraphicsGetCurrentContext()
        else { return }

        let traitCollection = self.traitCollection

        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)

        let lineWidthPressed = self.lineWidthPressed
        let controlSize = self.controlSize
        let scaledSpacing = controlSize + 2 * lineWidthPressed

        let controlRect = CGRect(x: 0, y: 0, width: scaledSpacing, height: scaledSpacing)

        let controlInnerRect = controlRect.insetBy(dx: lineWidthPressed, dy: lineWidthPressed)

        if self.isPressed {
            let lineWidth = lineWidthPressed
            let pressedBorderRectangle = controlRect.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
            let borderPath = UIBezierPath(roundedRect: pressedBorderRectangle, cornerRadius: cornerRadiusPressed)
            borderPath.lineWidth = lineWidth
            colors.pressed.pressedBorderColor.uiColor.setStroke()
            ctx.setStrokeColor(colors.pressed.pressedBorderColor.uiColor.cgColor)
            borderPath.stroke()
        }

        let fillColor: UIColor
        let strokeColor: UIColor

        switch self.state {
        case .enabled:
            fillColor = colors.enable.tintColor.uiColor
            strokeColor = colors.enable.borderColor.uiColor
        case .disabled:
            fillColor = colors.disable.tintColor.uiColor
            strokeColor = colors.disable.borderColor.uiColor
        }

        ctx.setStrokeColor(strokeColor.cgColor)
        ctx.setFillColor(fillColor.cgColor)

        let scaledOffset = lineWidth
        let rectangle = controlInnerRect.insetBy(dx: scaledOffset/2, dy: scaledOffset/2)

        let path = UIBezierPath(roundedRect: rectangle, cornerRadius: cornerRadius)
        path.lineWidth = scaledOffset
        strokeColor.setStroke()
        fillColor.setFill()

        let iconSize = self.iconSize
        switch self.selectionState {
        case .unselected:
            path.stroke()

        case .indeterminate:
            path.stroke()
            path.fill()

            let iconPath = UIBezierPath(roundedRect: self.iconRect(for: controlInnerRect), cornerRadius: bodyFontMetrics.scaledValue(for: iconSize.height / 2, compatibleWith: traitCollection))
            colors.enable.iconColor.uiColor.setFill()
            iconPath.fill()

        case .selected:
            path.stroke()
            path.fill()

            colors.enable.iconColor.uiColor.set()
            self.selectionIcon.draw(in: self.iconRect(for: controlInnerRect))
        }
    }

    private func iconRect(for rectangle: CGRect) -> CGRect {
        let origin = CGPoint(
            x: rectangle.origin.x + rectangle.width / 2 - iconSize.width / 2,
            y: rectangle.origin.y + rectangle.height / 2 - iconSize.height / 2
        )
        return CGRect(origin: origin, size: iconSize)
    }
}
