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

    // MARK: - Type Alias
    private typealias AccessibilityIdentifier = SpinnerAccessibilityIdentifier

    // MARK: - Private attributes
    private let viewModel: SpinnerViewModel
    private var subscriptions = Set<AnyCancellable>()

    @ScaledUIMetric private var size: CGFloat
    @ScaledUIMetric private var strokeWidth: CGFloat

    // MARK: - Public modifiable attributes
    /// The current theme
    public var theme: Theme {
        get { return self.viewModel.theme }
        set { self.viewModel.theme = newValue }
    }

    /// The spinner size (`medium` or `small`)
    public var spinnerSize: SpinnerSize {
        get { return self.viewModel.spinnerSize }
        set { self.viewModel.spinnerSize = newValue }
    }

    /// The spinner intent
    public var intent: SpinnerIntent {
        get { return self.viewModel.intent }
        set { self.viewModel.intent = newValue}
    }

    // MARK: - Init
    /// init
    /// Parameters:
    /// - theme: The current `Theme`
    /// - intent: The `SpinnerIntent` intent used for coloring the spinner. The default is `main`
    /// - spinnerSize: The defined size of the spinner`SpinnerSize`. The default is `small`
    public convenience init(theme: Theme,
                            intent: SpinnerIntent = .main,
                            spinnerSize: SpinnerSize = .small) {
        self.init(viewModel: SpinnerViewModel(theme: theme, intent: intent, spinnerSize: spinnerSize))
    }

    init(viewModel: SpinnerViewModel) {
        self.viewModel = viewModel
        let size = ScaledUIMetric(wrappedValue: viewModel.size)
        self._size = size
        let strokeWidth = ScaledUIMetric<CGFloat>(wrappedValue: viewModel.strokeWidth)
        self._strokeWidth = strokeWidth

        super.init(frame: CGRect.zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentHuggingPriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.backgroundColor = .clear

        self.setupSubscriptions()
        self.accessibilityIdentifier = AccessibilityIdentifier.spinner
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: self.size, height: self.size)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let oldSize = self.size
        let oldStrokeWidth = self.strokeWidth

        self._size.update(traitCollection: self.traitCollection)
        self._strokeWidth.update(traitCollection: self.traitCollection)

        if self.size != oldSize || self.strokeWidth != oldStrokeWidth {
            self.setNeedsLayout()
        }
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard
            let ctx = UIGraphicsGetCurrentContext()
        else { return }

        let center = rect.width / 2
        let centerPoint = CGPoint(x: center, y: center)

        let spinnerArc = UIBezierPath.arc(arcCenter: centerPoint, radius: (rect.width - self.strokeWidth)/2 )
        spinnerArc.lineWidth = self.strokeWidth
        ctx.setStrokeColor(self.viewModel.intentColor.uiColor.cgColor)
        spinnerArc.stroke()

        self.animate()
    }

    // MARK: - Private functions
    private func setupSubscriptions() {
        self.viewModel.$size.subscribe(in: &self.subscriptions) { [weak self] size in
            guard let self else { return }
            let oldSize = self.size
            self.size = size

            if oldSize != self.size {
                self.invalidateIntrinsicContentSize()
            }
        }

        self.viewModel.$intentColor.subscribe(in: &self.subscriptions) { [weak self] _ in
            self?.setNeedsDisplay()
        }
    }

    private func animate() {
        self.layer.removeAllAnimations()
        
        let fullRotation = CABasicAnimation(keyPath:  "transform.rotation.z")
        fullRotation.fromValue = 0
        fullRotation.toValue = 2 * CGFloat.pi
        fullRotation.duration = self.viewModel.duration
        fullRotation.repeatCount = .infinity

        self.layer.add(fullRotation, forKey: "Spinner.360")
    }
}

// MARK: - Private helper extensions
private extension UIBezierPath {
    static func arc(arcCenter: CGPoint,
                       radius: CGFloat) ->  UIBezierPath {
        return UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
    }
}


