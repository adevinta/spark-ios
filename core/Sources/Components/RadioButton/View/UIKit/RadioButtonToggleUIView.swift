//
//  RadioButtonToggleUIView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 21.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// Toggle view used for the radio button. When the toggle is pressed, a halo is rendered around the toggle.
final class RadioButtonToggleUIView: UIView {

    // MARK: Properties
    private var haloColor: UIColor
    private var buttonColor: UIColor
    private var fillColor: UIColor

    private var pressedSublayer: CALayer?

    var isPressed: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }

    // MARK: Initialization
    init() {
        self.haloColor = .clear
        self.buttonColor = .clear
        self.fillColor = .clear
        super.init(frame: .zero)
    }

    /// Toggle view
    /// This is the toggle used in the radio button to display whether an item is selected or not.
    ///
    /// Paramters:
    /// - haloColor: The outermost color, usually set when the item is pressed
    /// - buttonColor: The color of the inner circle
    /// - fillColor: The filled dot in the middle.
    init(haloColor: UIColor, buttonColor: UIColor, fillColor: UIColor) {
        self.haloColor = haloColor
        self.buttonColor = buttonColor
        self.fillColor = fillColor
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods
    func setColors(_ colors: RadioButtonColors) {
        self.haloColor = colors.halo.uiColor
        self.buttonColor = colors.button.uiColor
        self.fillColor = colors.fill.uiColor
        self.setNeedsDisplay()
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard
            let ctx = UIGraphicsGetCurrentContext()
        else { return }

        backgroundColor = .clear
        let haloWidth = rect.width / 7
        let center = rect.width / 2
        let centerPoint = CGPoint(x: center, y: center)

        if self.isPressed {
            let haloPath = UIBezierPath.circle(arcCenter: centerPoint, radius: (rect.width/2 - haloWidth/2))
            haloPath.lineWidth = haloWidth
            ctx.setStrokeColor(haloColor.cgColor)
            haloPath.stroke()
        }
        
        let innerBorderWidth = (rect.width - haloWidth*2) / 10
        let toggleWidth = rect.width - (haloWidth*2)
        let togglePath = UIBezierPath.circle(arcCenter: centerPoint, radius: (toggleWidth/2 - innerBorderWidth/2))
        togglePath.lineWidth = innerBorderWidth
        ctx.setStrokeColor(buttonColor.cgColor)
        togglePath.stroke()
        
        if fillColor != .clear {
            let fillSize = (rect.width - haloWidth*2) / 2
            let fillPath = UIBezierPath.circle(arcCenter: centerPoint, radius: fillSize/2)

            ctx.setFillColor(fillColor.cgColor)
            fillPath.fill()
        }
    }
}

// MARK: Private helpers

private extension UIBezierPath {
    static func circle(arcCenter: CGPoint,
                       radius: CGFloat) ->  UIBezierPath {
        return UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
    }
}
