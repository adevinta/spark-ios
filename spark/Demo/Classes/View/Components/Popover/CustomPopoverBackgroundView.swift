//
//  CustomPopoverBackgroundView.swift
//  PopupUIKit
//
//  Created by alican.aycil on 01.03.24.
//

// swiftlint:disable all
import UIKit

// I added this protocol to pass some values to UIPopoverBackgroundView
protocol Spacing {
    var space: CGFloat { get set }
}

class Medium: Spacing {
    var space: CGFloat = 10
}

class Small: Spacing {
    var space: CGFloat = 5
}

// We have to use UIPopoverBackgroundView as an subclass and we cant get instance from it.
class CustomPopoverBackgroundView<T: Spacing>: UIPopoverBackgroundView {

    var offset: CGFloat = 0
    var direction: UIPopoverArrowDirection = .any

    override var arrowOffset: CGFloat {
        get {
            return offset
        }
        set {
            self.offset = newValue
        }
    }

    override var arrowDirection: UIPopoverArrowDirection {
        get {
            return self.direction
        }
        set {
            self.direction = newValue
        }
    }

    override class func contentViewInsets() -> UIEdgeInsets {
        return .zero
    }

    override class func arrowHeight() -> CGFloat {
        switch T.self {
        case is Medium.Type:
            return 15 + Medium().space
        case is Small.Type:
            return 15 + Small().space
        default:
            return 15
        }
    }

    override class func arrowBase() -> CGFloat {
        return 15
    }

    let arrowSize: CGFloat = 15

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        self.layer.shadowColor = UIColor.clear.cgColor

    }

    override func layoutSubviews() {
        self.setUpArrow(direction: self.arrowDirection)
    }

    // this method will draw tip(arrow)
    private func setUpArrow(direction: UIPopoverArrowDirection) {

        let layerName = "Arrow"

        guard direction != .any || direction != .unknown else {
            return
        }

        guard ((self.layer.sublayers?.contains(where: { layer in
            layer.name == layerName
        })) == nil) else {
            return
        }

        switch direction {
        case .up:

            let path = CGMutablePath()
            let lineLenght: CGFloat = self.arrowSize
            let startPointX: CGFloat = self.frame.size.width/2 + self.arrowOffset - lineLenght/2
            let startPointY: CGFloat = Self.arrowHeight()

            path.move(to: CGPoint(x: startPointX , y: startPointY))
            path.addLine(to: CGPoint(x: startPointX + lineLenght/2, y: lineLenght))
            path.addLine(to: CGPoint(x:startPointX + lineLenght, y: startPointY))
            path.addLine(to: CGPoint(x: startPointX, y: startPointY))

            let shape = CAShapeLayer()
            shape.name = layerName
            shape.path = path
            shape.fillColor = UIColor.green.cgColor

            self.layer.insertSublayer(shape, at: 0)

        case .down:

            let path = CGMutablePath()
            let lineLenght: CGFloat = self.arrowSize
            let startPointX: CGFloat = self.frame.size.width/2 + self.arrowOffset - lineLenght/2
            let startPointY: CGFloat = self.frame.size.height - Self.arrowHeight()

            path.move(to: CGPoint(x: startPointX , y: startPointY))
            path.addLine(to: CGPoint(x: startPointX + lineLenght/2, y: startPointY + lineLenght))
            path.addLine(to: CGPoint(x:startPointX + lineLenght, y: startPointY))
            path.addLine(to: CGPoint(x: startPointX, y: startPointY))

            let shape = CAShapeLayer()
            shape.name = layerName
            shape.path = path
            shape.fillColor = UIColor.green.cgColor

            self.layer.insertSublayer(shape, at: 0)

        case .left:

            let path = CGMutablePath()
            let lineLenght: CGFloat = self.arrowSize
            let startPointX: CGFloat = 0 + Self.arrowHeight()
            let startPointY: CGFloat = self.frame.size.height/2 + self.arrowOffset - lineLenght/2

            path.move(to: CGPoint(x: startPointX , y: startPointY))
            path.addLine(to: CGPoint(x: startPointX - lineLenght, y: startPointY + lineLenght/2))
            path.addLine(to: CGPoint(x:startPointX, y: startPointY + lineLenght))
            path.addLine(to: CGPoint(x: startPointX, y: startPointY))

            let shape = CAShapeLayer()
            shape.name = layerName
            shape.path = path
            shape.fillColor = UIColor.green.cgColor

            self.layer.insertSublayer(shape, at: 0)

        case .right:
            let path = CGMutablePath()
            let lineLenght: CGFloat = self.arrowSize
            let startPointX: CGFloat = self.frame.size.width - Self.arrowHeight()
            let startPointY: CGFloat = self.frame.size.height/2 + self.arrowOffset - lineLenght/2

            path.move(to: CGPoint(x: startPointX , y: startPointY))
            path.addLine(to: CGPoint(x: startPointX + lineLenght, y: startPointY + lineLenght/2))
            path.addLine(to: CGPoint(x:startPointX, y: startPointY + lineLenght))
            path.addLine(to: CGPoint(x: startPointX, y: startPointY))

            let shape = CAShapeLayer()
            shape.name = layerName
            shape.path = path
            shape.fillColor = UIColor.green.cgColor

            self.layer.insertSublayer(shape, at: 0)

        default:
            break
        }
    }

    // This was for to remove native shadow behind popover but not good approach.

    override func didMoveToWindow() {
        super.didMoveToWindow()

//        if let window = UIApplication.shared.keyWindow {
//
//            let transitionViews = window.subviews.filter { String(describing: type(of: $0)) == "UITransitionView" }
//
//            for transitionView in transitionViews {
//
//                ///This is for ios 15
//                if let cutoutShadowView = transitionView.subviews.filter({ String(describing: type(of: $0)) == "_UICutoutShadowView" }).first {
//                    cutoutShadowView.isHidden = true
//                }
//
//                let popoverView = transitionView.subviews.filter { String(describing: type(of: $0)) == "_UIPopoverView" }.first
//
//                ///This is for ios 17
//                if let cutoutShadowView = popoverView?.subviews.filter({ String(describing: type(of: $0)) == "_UICutoutShadowView" }).first {
//                    cutoutShadowView.isHidden = true
//                }
//            }
//        }
    }
}


// I added this extension to find keyWindow
extension UIApplication {

    var keyWindow: UIWindow? {
        // Get connected scenes
        return self.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}
