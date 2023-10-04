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

    enum Constants {
        static var cornerRadius: CGFloat = 4
        static var cornerRadiusPressed: CGFloat = 7
        static var lineWidth: CGFloat = 2
        static var lineWidthPressed: CGFloat = 4
        static var size: CGFloat = 24
    }

    // MARK: - Properties.

    var selectionIcon: UIImage {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var isPressed: Bool {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var selectionState: CheckboxSelectionState {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var colors: CheckboxColors {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var isEnabled: Bool {
        didSet {
            self.setNeedsDisplay()
        }
    }

    private lazy var pressedBorderView: UIView = {
        let view = UIView(
            frame: CGRect(
                x: -Constants.lineWidthPressed,
                y: -Constants.lineWidthPressed,
                width: Constants.size + 2*Constants.lineWidthPressed,
                height: Constants.size + 2*Constants.lineWidthPressed
            )
        )
        view.layer.borderWidth = Constants.lineWidthPressed
        view.layer.borderColor = colors.pressedBorderColor.uiColor.cgColor
        view.layer.cornerRadius = Constants.cornerRadiusPressed
        return view
    }()

    // MARK: - Initialization

    init(
        selectionIcon: UIImage,
        colors: CheckboxColors,
        isEnabled: Bool,
        selectionState: CheckboxSelectionState,
        isPressed: Bool
    ) {
        self.selectionIcon = selectionIcon
        self.isEnabled = isEnabled
        self.selectionState = selectionState
        self.isPressed = isPressed
        self.colors = colors
        super.init(frame: .zero)

        self.backgroundColor = .clear
        self.addSubview(pressedBorderView)
    }

    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    private var iconSize: CGSize {
        let iconSize: CGSize
        switch self.selectionState {
        case .unselected:
            return .zero
        case .selected:
            iconSize = CGSize(width: 17, height: 17)
        case .indeterminate:
            iconSize = CGSize(width: 14, height: 2)
        }
        return iconSize.scaled(for: self.traitCollection)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        pressedBorderView.isHidden = !isPressed

        guard let ctx = UIGraphicsGetCurrentContext() else { return }

        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        let rect = CGRect(x: 0, y: 0, width: Constants.size, height: Constants.size)

        let fillPath = UIBezierPath(roundedRect: rect, cornerRadius: Constants.cornerRadius)
        let fillColor = colors.tintColor.uiColor
        fillColor.setFill()
        ctx.setFillColor(fillColor.cgColor)

        if isPressed {
            let path = UIBezierPath(roundedRect: rect, cornerRadius: Constants.cornerRadius)
            let color = colors.pressedBorderColor.uiColor
            path.lineWidth = 1
            color.setStroke()
            ctx.setStrokeColor(color.cgColor)
            path.stroke()
        }

        switch self.selectionState {
        case .unselected:
            let strokeRectangle = rect.insetBy(dx: Constants.lineWidth/2, dy: Constants.lineWidth/2)
            let strokePath = UIBezierPath(roundedRect: strokeRectangle, cornerRadius: Constants.cornerRadius)
            let strokeColor = colors.borderColor.uiColor
            strokePath.lineWidth = Constants.lineWidth
            strokeColor.setStroke()
            ctx.setStrokeColor(strokeColor.cgColor)
            strokePath.stroke()

        case .indeterminate:
            fillPath.fill()

            let iconPath = UIBezierPath(
                roundedRect: self.iconRect(for: rect),
                cornerRadius: bodyFontMetrics.scaledValue(
                    for: self.iconSize.height / 2,
                    compatibleWith: self.traitCollection
                )
            )
            let iconColor = colors.iconColor.uiColor
            iconColor.setFill()
            iconPath.fill()

        case .selected:
            fillPath.fill()

            let iconColor = colors.iconColor.uiColor
            iconColor.set()
            self.selectionIcon.draw(in: self.iconRect(for: rect))
        }
    }

    private func iconRect(for rectangle: CGRect) -> CGRect {
        let origin = CGPoint(
            x: rectangle.origin.x + rectangle.width / 2 - self.iconSize.width / 2,
            y: rectangle.origin.y + rectangle.height / 2 - self.iconSize.height / 2
        )
        return CGRect(origin: origin, size: self.iconSize)
    }
}
