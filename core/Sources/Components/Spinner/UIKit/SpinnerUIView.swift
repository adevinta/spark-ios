//
//  ChipUIView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 07.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import QuartzCore
import Foundation
import UIKit

private struct Constants {
    static let lineWidth: CGFloat = 2
}

public final class SpinnerUIView: UIView {

    public var theme: Theme
    @ScaledUIMetric private var height: CGFloat
    @ScaledUIMetric private var lineWidth = Constants.lineWidth
    private let arc = SpinnerArcUIView()

    public init(theme: Theme) {
        self._height = ScaledUIMetric<CGFloat>(wrappedValue: 20)
        self.theme = theme

        super.init(frame: CGRect.zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupView()
        self.setupConstraints()
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentHuggingPriority(.required, for: .vertical)
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: self.height, height: self.height)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._height.update(traitCollection: self.traitCollection)
        self._lineWidth.update(traitCollection: self.traitCollection)
    }

    private func setupView() {
        self.arc.backgroundColor = .clear
        self.arc.translatesAutoresizingMaskIntoConstraints = false
        self.arc.frame = self.bounds
        self.arc.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.arc)
    }
    
    private func setupConstraints() {
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: self.height)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.height)
        widthConstraint.priority = .required
        heightConstraint.priority = .required
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: self.height),
            self.heightAnchor.constraint(equalToConstant: self.height)
        ])
    }

    public func start() {
        animate()
    }

    public func stop() {
        self.arc.layer.removeAnimation(forKey: "360")
    }

    private func animate() {
        let fullRotation = CABasicAnimation(keyPath:  "transform.rotation.z")
        fullRotation.delegate = self
        fullRotation.fromValue = 0
        fullRotation.toValue = 2 * CGFloat.pi
        fullRotation.duration = 1.0
        fullRotation.repeatCount = .infinity


        self.arc.layer.add(fullRotation, forKey: "360")
    }

//    private func animate() {
//        let circlePath = UIBezierPath(arcCenter: center, radius: 20, startAngle: 0, endAngle: .pi*2, clockwise: true)
//
//        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
//        animation.path = circlePath.cgPath
//        animation.duration = 1
//        animation.repeatCount = .infinity
//
//        self.arc.layer.add(animation, forKey: "360")
//    }
//    private func animate() {
//        UIView.animate(withDuration: 1.6, delay: 0.1, options: [.repeat]) { [weak self] in
//            guard let self else { return }
//            self.arc.transform = CGAffineTransformRotate(self.arc.transform, CGFloat.pi)
//        }
//    }

}

extension SpinnerUIView: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        print("animation did start")
    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print(flag)
    }
}

class SpinnerArcUIView: UIView {
    private var lineWidth: CGFloat = 2

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard
            let ctx = UIGraphicsGetCurrentContext()
        else { return }

        let center = rect.width / 2
        let centerPoint = CGPoint(x: center, y: center)

        let spinnerArc = UIBezierPath.arc(arcCenter: centerPoint, radius: (rect.height - self.lineWidth)/2 )
        spinnerArc.lineWidth = self.lineWidth
        ctx.setStrokeColor(UIColor.red.cgColor)
        spinnerArc.stroke()
    }
}

private extension UIBezierPath {
    static func arc(arcCenter: CGPoint,
                       radius: CGFloat) ->  UIBezierPath {
        return UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
    }
}


