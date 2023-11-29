//
//  RatingInputUIView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 28.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI

public final class RatingInputUIView: UIControl {

    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    public var intent: RatingIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    public var publisher: any Publisher<CGFloat, Never> {
        return self.subject
    }

    public var rating: CGFloat {
        get {
            return self.ratingInputs.map(\.rating).reduce(0.0, +)
        }
        set {
            self.viewModel.ratingValue = newValue
        }
    }

    public override var isEnabled: Bool {
        didSet {
            self.ratingInputs.forEach { inputView in
                inputView.isEnabled = self.isEnabled
            }
        }
    }

    public weak var delegate: RatingInputUIViewDelegate?

    private let starConfiguration: StarConfiguration

    private let viewModel: RatingDisplayViewModel
    private var cancellables = Set<AnyCancellable>()
    private var subject = PassthroughSubject<CGFloat, Never>()

    // MARK: - Private variables
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: self.ratingInputs)
        stackView.axis = .horizontal
        stackView.spacing = self.spacing
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var ratingInputs: [RatingInputStarUIView] = {
        return (0..<RatingStarsCount.five.rawValue).map { i in
            let rating = RatingInputStarUIView(
                theme: viewModel.theme,
                intent: viewModel.intent,
                configuration: self.starConfiguration
            )
            rating.accessibilityIdentifier = "\(RatingInputAccessibilityIdentifier.identifier)-\(i+1)"
            return rating
        }
    }()

    @ScaledUIMetric private var spacing: CGFloat

    public init(
        theme: Theme,
        intent: RatingIntent,
        rating: CGFloat = 0.0,
        configuration: StarConfiguration = .default) {

            self.viewModel = RatingDisplayViewModel(
                theme: theme,
                intent: intent,
                size: .input,
                count: .five,
                rating: rating
            )
            self.spacing = self.viewModel.ratingSize.spacing
            self.starConfiguration = configuration
            super.init(frame: .zero)

            self.setupView()
            self.setupSubscriptions()
            self.setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._spacing.update(traitCollection: traitCollection)

        self.stackView.spacing = self.spacing
    }

    private func setupSubscriptions() {
        self.viewModel.$ratingSize.subscribe(in: &self.cancellables) { [weak self] size in
            self?.didUpdate(spacing: size.spacing)
        }

        self.viewModel.$ratingValue.subscribe(in: &self.cancellables) { [weak self] ratingValue in
            self?.didUpdate(rating: ratingValue)
        }
    }

    private func setupView() {
        self.accessibilityIdentifier = RatingInputAccessibilityIdentifier.identifier

        self.didUpdate(rating: self.viewModel.ratingValue)
        self.addSubviewSizedEqually(self.stackView)
    }

    private func didUpdate(spacing: CGFloat) {
        self.spacing = spacing
        self.stackView.spacing = self.spacing
    }

    private func setupActions() {
        for (i, ratingInput) in self.ratingInputs.enumerated() {
            let selectedAction = UIAction { [weak self] _ in
                self?.ratingStarSelected(i)
            }
            let highlightedAction = UIAction { [weak self] _ in
                self?.ratingStarHighlighted(i)
            }
            let highlightCancelAction = UIAction { [weak self] _ in
                self?.ratingStarHighlightCancelled(i)
            }
            ratingInput.addAction(selectedAction, for: .touchUpInside)
            ratingInput.addAction(highlightedAction, for: .touchDown)
            ratingInput.addAction(highlightCancelAction, for: .touchUpOutside)
            ratingInput.addAction(highlightCancelAction, for: .touchCancel)
        }
    }


    private func didUpdate(rating: CGFloat) {
        var currentRating = rating
        for ratingInput in self.ratingInputs {
            ratingInput.rating = min(1.0, currentRating)
            currentRating -= 1
        }
    }

    private func ratingStarSelected(_ index: Int) {
        let rating = CGFloat(index + 1)
        self.didUpdate(rating: rating)

//        for i in index+1..<self.ratingInputs.count {
//            self.ratingInputs[i].isSelected = false
//        }
//        for i in 0...index {
//            self.ratingInputs[i].isSelected = true
//        }

        self.viewModel.rating = rating
        self.subject.send(rating)
        self.sendActions(for: .valueChanged)
        self.delegate?.rating(self, didChangeRating: rating)
    }

    private func ratingStarHighlighted(_ index: Int) {
        self.didUpdate(rating: CGFloat(index + 1))

        for i in index+1..<self.ratingInputs.count {
            self.ratingInputs[i].isPressed = false
        }
        for i in 0...index {
            self.ratingInputs[i].isPressed = true
        }
    }

    private func ratingStarHighlightCancelled(_ index: Int) {
        self.didUpdate(rating: self.viewModel.rating)
        for i in 0..<self.ratingInputs.count {
            self.ratingInputs[i].isPressed = false
        }
    }
}
