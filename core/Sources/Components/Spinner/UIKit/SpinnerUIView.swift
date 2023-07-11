//
//  ChipUIView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 07.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import QuartzCore
import UIKit
import SwiftUI

/// SpinnerView is a single indeterminate spinner.
/// The spinner can have a size of `small` or `medium` and have different intents which determine the color of the spinner.
/// The spinner spin animation is 1 second linear infinite.
public final class SpinnerUIView: UIView {

    // MARK: - Private attributes
    private let viewModel: SpinnerViewModel
    private var subscriptions = Set<AnyCancellable>()

    @ScaledUIMetric private var size: CGFloat
    @ScaledUIMetric private var strokeWidth: CGFloat

    private let arc: SpinnerArcUIView
    private var spinnerSizeConstraints = [NSLayoutConstraint]()

    // MARK: - Public modifiable attributes
    public var theme: Theme {
        get { return self.viewModel.theme }
        set { self.viewModel.theme = newValue }
    }

    public var spinnerSize: SpinnerSize {
        get { return self.viewModel.spinnerSize }
        set { self.viewModel.spinnerSize = newValue }
    }

    public var intent: SpinnerIntent {
        get { return self.viewModel.intent }
        set { self.viewModel.intent = newValue}
    }

    // MARK: - Init
    /// init
    /// Parameters:
    /// - theme: The current `Theme`
    /// - intent: The `SpinnerIntent` intent used for coloring the spinner
    /// - spinnerSize: The defined size of the spinner`SpinnerSize`
    public convenience init(theme: Theme, intent: SpinnerIntent, spinnerSize: SpinnerSize) {
        self.init(viewModel: SpinnerViewModel(theme: theme, intent: intent, spinnerSize: spinnerSize))
    }

    init(viewModel: SpinnerViewModel) {
        self.viewModel = viewModel
        self._size = ScaledUIMetric(wrappedValue: viewModel.size)
        let strokeWidth = ScaledUIMetric<CGFloat>(wrappedValue: viewModel.strokeWidth)
        self.arc = SpinnerArcUIView(strokeWidth: strokeWidth.wrappedValue, color: viewModel.intentColor.uiColor)
        self._strokeWidth = strokeWidth

        super.init(frame: CGRect.zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupView()
        self.setupConstraints()
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentHuggingPriority(.required, for: .vertical)
        self.backgroundColor = .clear

        self.animate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: self.size, height: self.size)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._size.update(traitCollection: self.traitCollection)
        self._strokeWidth.update(traitCollection: self.traitCollection)
    }

    // MARK: - Private functions
    private func setupView() {
        self.arc.backgroundColor = .clear
        self.arc.translatesAutoresizingMaskIntoConstraints = false
        self.arc.frame = self.bounds
        self.arc.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.arc)
    }
    
    private func setupConstraints() {
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: self.size)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size)
        widthConstraint.priority = .required
        heightConstraint.priority = .required

        let constraints = [widthConstraint, heightConstraint]

        NSLayoutConstraint.activate(constraints)

        self.spinnerSizeConstraints = constraints
    }

    private func setupSubscriptions() {
        self.viewModel.$size.subscribe(in: &self.subscriptions) { [weak self] size in
            guard let self else { return }
            self.size = size
            self.updateSizeConstraints()
            self.setNeedsLayout()
        }

        self.viewModel.$intentColor.subscribe(in: &self.subscriptions) { [weak self] color in
            guard let self else { return }
            self.arc.color = color.uiColor
            self.arc.setNeedsDisplay()
        }
    }

    private func updateSizeConstraints() {
        for constraint in self.spinnerSizeConstraints {
            constraint.constant = self.size
        }
    }

    private func animate() {
        let fullRotation = CABasicAnimation(keyPath:  "transform.rotation.z")
        fullRotation.fromValue = 0
        fullRotation.toValue = 2 * CGFloat.pi
        fullRotation.duration = self.viewModel.duration
        fullRotation.repeatCount = .infinity

        self.arc.layer.add(fullRotation, forKey: "Spinner.360")
    }
}

// MARK: - Private helper classes
/// Private helper view just to draw the arc which will be used in the spinner view
private final class SpinnerArcUIView: UIView {
    var strokeWidth: CGFloat
    var color: UIColor

    init(strokeWidth: CGFloat, color: UIColor) {
        self.strokeWidth = strokeWidth
        self.color = color
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard
            let ctx = UIGraphicsGetCurrentContext()
        else { return }

        let center = rect.width / 2
        let centerPoint = CGPoint(x: center, y: center)

        let spinnerArc = UIBezierPath.arc(arcCenter: centerPoint, radius: (rect.height - self.strokeWidth)/2 )
        spinnerArc.lineWidth = self.strokeWidth
        ctx.setStrokeColor(self.color.cgColor)
        spinnerArc.stroke()
    }
}

// MARK: - Private helper extensions
private extension UIBezierPath {
    static func arc(arcCenter: CGPoint,
                       radius: CGFloat) ->  UIBezierPath {
        return UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
    }
}


