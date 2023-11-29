//
//  RatingInputStarUIView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 27.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import UIKit

final class RatingInputStarUIView: UIView {

    private var sizeConstraints = [NSLayoutConstraint]()
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: RatingDisplayViewModel

    private lazy var star: StarUIView  = {
        let view = StarUIView(
            rating: self.viewModel.rating,
            fillMode: .full,
            lineWidth: self.borderWidth,
            borderColor: self.viewModel.colors.strokeColor.uiColor,
            fillColor: self.viewModel.colors.fillColor.uiColor
        )
        view.isUserInteractionEnabled = false
        return view
    }()

    // MARK: - Scaled metrics
    @ScaledUIMetric private var borderWidth: CGFloat
    @ScaledUIMetric private var ratingSize: CGFloat

    var isSelected: Bool {
        get {
            return self.viewModel.rating == 1.0
        }
        set {
            self.viewModel.updateState(isPressed: false)
            self.viewModel.rating = newValue ? 1.0 : 0.0
        }
    }

//    override var isHighlighted: Bool {
//        get {
//            return self.isPressed
//        }
//        set {
//            self.isPressed = newValue
//            if !newValue {
//                self.sendActions(for: .touchCancel)
//            } else {
//                self.sendActions(for: .touchDown)
//            }
//        }
//    }

    var isPressed: Bool {
        get {
            return self.viewModel.ratingState.isPressed
        }
        set {
            self.viewModel.updateState(isPressed: newValue)
        }
    }

    var isEnabled: Bool {
        get {
            return self.viewModel.ratingState.isEnabled
        }
        set {
            self.viewModel.updateState(isEnabled: newValue)
        }
    }

    var rating: CGFloat {
        get {
            return self.viewModel.rating
        }
        set {
            self.viewModel.rating = StarFillMode.full.rating(of: newValue)
        }
    }

    init(
        theme: Theme,
        intent: RatingIntent,
        rating: CGFloat = 0.0,
        configuration: StarConfiguration = .default
    ) {
        self.viewModel = .init(
            theme: theme,
            intent: intent,
            size: .input,
            count: .one,
            rating: rating)

        self.borderWidth = self.viewModel.ratingSize.borderWidth
        self.ratingSize = self.viewModel.ratingSize.height
    
        super.init(frame: .zero)

        self.setupView()
        self.setupSubscriptions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._borderWidth.update(traitCollection: traitCollection)
        self._ratingSize.update(traitCollection: traitCollection)

        self.didUpdate(borderWidth: self.borderWidth)
        self.didUpdate(ratingSize: self.ratingSize)
    }

    private func setupSubscriptions() {
        self.viewModel.$ratingSize.subscribe(in: &self.cancellables) { [weak self] size in
            self?.didUpdate(borderWidth: size.borderWidth)
            self?.didUpdate(ratingSize: size.height)
        }

        self.viewModel.$ratingValue.subscribe(in: &self.cancellables) { [weak self] _ in
            guard let self = self else { return }
            self.didUpdate(ratingValue: self.viewModel.rating)
        }

        self.viewModel.$colors.subscribe(in: &self.cancellables) { [weak self] colors in
            self?.didUpdate(colors: colors)
        }
    }

    private func didUpdate(ratingSize: CGFloat) {
        self.ratingSize = ratingSize
        self.sizeConstraints.forEach { constraint in
            constraint.constant = self.ratingSize
        }
    }

    private func didUpdate(ratingValue: CGFloat) {
        guard self.star.rating != ratingValue else { return }
        self.star.rating = ratingValue
    }

    private func didUpdate(borderWidth: CGFloat) {
        self.borderWidth = borderWidth
        self.star.lineWidth = self.borderWidth
    }

    private func didUpdate(colors: RatingColors) {
        if self.viewModel.ratingState.isPressed {
            self.star.rating = 1.0
        } else {
            self.star.rating = self.viewModel.rating
        }
        self.star.fillColor = colors.fillColor.uiColor
        self.star.borderColor = colors.strokeColor.uiColor
        self.layer.opacity = Float(colors.opacity)
    }

    private func setupView() {
        self.addSubviewSizedEqually(self.star)

        self.sizeConstraints.append(star.widthAnchor.constraint(equalToConstant: self.ratingSize))
        self.sizeConstraints.append(star.heightAnchor.constraint(equalToConstant: self.ratingSize))

        NSLayoutConstraint.activate(self.sizeConstraints)
    }
}
