//
//  RatingInputUIView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import UIKit

/// A rating input for setting a rating value.
/// There are three possibilities to receive the changed value:
/// 1. Subscribing to the publisher
/// 2. Adding a value changed target action
/// 3. Setting the delegate
public final class RatingInputUIView: UIControl {

    // MARK: - Properties
    /// The current theme
    public var theme: Theme {
        get {
            return self.ratingDisplay.theme
        }
        set {
            self.ratingDisplay.theme = newValue
        }
    }

    /// The current intent
    public var intent: RatingIntent {
        get {
            return self.ratingDisplay.intent
        }
        set {
            self.ratingDisplay.intent = newValue
        }
    }

    /// A Boolean value indicating whether the control is in the enabled state.
    public override var isEnabled: Bool {
        didSet {
            self.ratingDisplay.isEnabled = self.isEnabled
        }
    }

    public override var isHighlighted: Bool {
        set {
            self.ratingDisplay.isPressed = newValue
        }
        get {
            return self.ratingDisplay.isPressed
        }
    }

    /// The current rating value.
    /// It is expected, that this value is in a range between 0 and 5
    public var rating: CGFloat {
        didSet {
            guard ratingDisplay.rating != self.rating else { return }
            ratingDisplay.rating = self.rating
        }
    }

    /// Changes to the rating by user interactions will be published. Only changed values will be published
    public var publisher: any Publisher<CGFloat, Never> {
        return self.subject
    }

    /// A delegate which is called on rating changes by user interaction
    public weak var delegate: RatingInputUIViewDelegate?

    // MARK: - Private properties
    private let ratingDisplay: RatingDisplayUIView
    private var subject = PassthroughSubject<CGFloat, Never>()
    private var lastSelectedIndex: Int?

    // MARK: - Initializer
    /// Init
    /// - Parameters
    ///   - theme: the current theme
    ///   - intent: the current intent defining the color
    ///   - rating: the current rating. This should be a value in the range between 0...5. The default value is 0
    ///   - configuration: The star configuration, the default is `default`
    public init(
        theme: Theme,
        intent: RatingIntent,
        rating: CGFloat = 0.0,
        configuration: StarConfiguration = .default
    ) {
        self.ratingDisplay = RatingDisplayUIView(
            theme: theme,
            intent: intent,
            count: .five,
            size: .input,
            rating: rating,
            fillMode: .full,
            configuration: configuration
        )

        self.rating = rating
        super.init(frame: .zero)
        self.setupView()
        self.enableTouch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Handle touch events
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return self.handleTouch(touch, with: event)
    }

    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return self.handleTouch(touch, with: event)
    }

    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {

        guard let location = touch?.location(in: self) else {
            self.ratingStarHighlightCancelled()
            return
        }

        if !self.bounds.contains(location) {
            self.ratingStarHighlightCancelled()
        } else if let index = self.ratingDisplay.ratingStarViews.index(closestTo: location) {
            self.ratingStarSelected(index)
        } else if let index = self.lastSelectedIndex {
            self.ratingStarSelected(index)
        } else {
            self.ratingStarHighlightCancelled()
        }

        self.lastSelectedIndex = nil
    }

    // MARK: - Private functions

    // MARK: - View setup
    private func setupView() {
        self.ratingDisplay.isUserInteractionEnabled = false
        self.addSubviewSizedEqually(self.ratingDisplay)
        self.accessibilityIdentifier = RatingInputAccessibilityIdentifier.identifier
    }

    // MARK: - Handling touch actions
    private func handleTouch(_ touch: UITouch, with event: UIEvent?) -> Bool {

        let location = touch.location(in: self)

        if !self.frame.contains(location) {
            if !self.isHighlighted {
                self.ratingStarHighlightCancelled()
            }
            return true
        }

        guard let index = self.ratingDisplay.ratingStarViews.index(closestTo: location) else {
            if !self.isHighlighted {
                self.ratingStarHighlightCancelled()
            }
            return true
        }

        self.lastSelectedIndex = index
        self.ratingStarHighlighted(index)

        return true
    }

    private func ratingStarSelected(_ index: Int) {
        let rating = CGFloat(index + 1)

        guard rating != self.rating else { return }

        self.rating = rating

        self.subject.send(rating)
        self.sendActions(for: .valueChanged)
        self.delegate?.rating(self, didChangeRating: rating)
    }

    private func ratingStarHighlighted(_ index: Int) {
        let rating = CGFloat(index + 1)
        self.ratingDisplay.rating = rating
    }

    private func ratingStarHighlightCancelled() {
        self.ratingDisplay.rating = self.rating
    }
}
