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
        static var selectedIconSize: CGSize = CGSize(width: 17, height: 17)
        static var indeterminateIconSize: CGSize = CGSize(width: 14, height: 2)
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


    // MARK: - Private Properties.
    @ScaledUIMetric private var cornerRadius: CGFloat = Constants.cornerRadius
    @ScaledUIMetric private var cornerRadiusPressed: CGFloat = Constants.cornerRadiusPressed
    @ScaledUIMetric private var lineWidth: CGFloat = Constants.lineWidth
    @ScaledUIMetric private var lineWidthPressed: CGFloat = Constants.lineWidthPressed
    @ScaledUIMetric private var controlSize: CGFloat = Constants.size

    private lazy var pressedBorderView: UIView = {
        let view = UIView()
        self.addBorderToView(for: view)
        return view
    }()

    private var iconSize: CGSize {
        let iconSize: CGSize
        switch self.selectionState {
        case .unselected:
            return .zero
        case .selected:
            iconSize = Constants.selectedIconSize
        case .indeterminate:
            iconSize = Constants.indeterminateIconSize
        }
        return iconSize.scaled(for: self.traitCollection)
    }

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

    private func addBorderToView(for view: UIView) {
        view.frame = CGRect(
            x: -self.lineWidthPressed,
            y: -self.lineWidthPressed,
            width: self.controlSize + 2*self.lineWidthPressed,
            height: self.controlSize + 2*self.lineWidthPressed
        )
        view.layer.borderWidth = self.lineWidthPressed
        view.layer.borderColor = colors.pressedBorderColor.uiColor.cgColor
        view.layer.cornerRadius = cornerRadiusPressed
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory else { return }

        let traitCollection = self.traitCollection
        self._cornerRadius.update(traitCollection: traitCollection)
        self._cornerRadiusPressed.update(traitCollection: traitCollection)
        self._lineWidth.update(traitCollection: traitCollection)
        self._lineWidthPressed.update(traitCollection: traitCollection)
        self._controlSize.update(traitCollection: traitCollection)

        self.addBorderToView(for: self.pressedBorderView)
    }

    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        pressedBorderView.isHidden = !isPressed

        guard let ctx = UIGraphicsGetCurrentContext() else { return }

        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        let rect = CGRect(x: 0, y: 0, width: self.controlSize, height: self.controlSize)

        let fillPath = UIBezierPath(roundedRect: rect, cornerRadius: self.cornerRadius)
        let fillColor = colors.tintColor.uiColor
        fillColor.setFill()
        ctx.setFillColor(fillColor.cgColor)

        if isPressed {
            let path = UIBezierPath(roundedRect: rect, cornerRadius: self.cornerRadius)
            let color = colors.pressedBorderColor.uiColor
            path.lineWidth = self.lineWidth/2
            color.setStroke()
            ctx.setStrokeColor(color.cgColor)
            path.stroke()
        }

        switch self.selectionState {
        case .unselected:
            let strokeRectangle = rect.insetBy(dx: self.lineWidth/2, dy: self.lineWidth/2)
            let strokePath = UIBezierPath(roundedRect: strokeRectangle, cornerRadius: self.cornerRadius)
            let strokeColor = colors.borderColor.uiColor
            strokePath.lineWidth = self.lineWidth
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
