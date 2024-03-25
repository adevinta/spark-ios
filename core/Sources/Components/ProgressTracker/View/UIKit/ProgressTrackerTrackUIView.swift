//
//  ProgressTrackerTrackUIView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 30.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import Foundation
import UIKit

// The small track between indicators in the Progress Tracker
final class ProgressTrackerTrackUIView: UIView {

    @ScaledUIMetric private var scaleFactor: CGFloat = 1.0

    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()

    private var orientation: ProgressTrackerOrientation {
        didSet {
            guard self.orientation != oldValue else { return }
            self.reorganizeView()
        }
    }

    var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    var intent: ProgressTrackerIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
            guard newValue != self.viewModel.isEnabled else { return }
            self.viewModel.isEnabled = newValue
        }
    }

    private let viewModel: ProgressTrackerTrackViewModel
    private var cancellables = Set<AnyCancellable>()

    private var sizeConstraints = [NSLayoutConstraint]()

    private var trackSize: CGFloat {
        return self.scaleFactor * ProgressTrackerConstants.trackSize
    }

    // MARK: Initialization
    init(theme: Theme,
         intent: ProgressTrackerIntent,
         orientation: ProgressTrackerOrientation) {
        self.orientation = orientation
        self.viewModel = ProgressTrackerTrackViewModel(theme: theme, intent: intent)
        super.init(frame: .zero)

        self.setupView()
        self.setupSubscriptions()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.hasDifferentSizeCategory(comparedTo: previousTraitCollection) {

            self._scaleFactor.update(traitCollection: self.traitCollection)

            self.updateSizeConstraints()
        }
    }

    private func setupSubscriptions() {
        self.viewModel.$lineColor.subscribe(in: &self.cancellables) { [weak self] newColor in
            self?.lineView.backgroundColor = newColor.uiColor
        }

        self.viewModel.$opacity.subscribe(in: &self.cancellables) { [weak self] opacity in
            self?.lineView.alpha = opacity
        }
    }

    private func reorganizeView() {
        self.lineView.removeFromSuperview()
        self.sizeConstraints = []

        self.setupView()
    }

    private func setupView() {
        self.addSubviewSizedEqually(self.lineView)

        if self.orientation == .horizontal {
            self.sizeConstraints = [
                self.lineView.heightAnchor.constraint(equalToConstant: self.trackSize),
                self.lineView.widthAnchor.constraint(greaterThanOrEqualToConstant: self.trackSize)
            ]
        } else {
            self.sizeConstraints = [
                self.lineView.heightAnchor.constraint(greaterThanOrEqualToConstant: self.trackSize),
                self.lineView.widthAnchor.constraint(equalToConstant: self.trackSize)
            ]
        }

        NSLayoutConstraint.activate(self.sizeConstraints)
        self.lineView.backgroundColor = self.viewModel.lineColor.uiColor
        self.alpha = self.viewModel.opacity
    }

    private func updateSizeConstraints() {
        for sizeConstraint in self.sizeConstraints {
            sizeConstraint.constant = self.trackSize
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
