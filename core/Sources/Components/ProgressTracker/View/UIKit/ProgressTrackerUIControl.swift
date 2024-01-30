//
//  ProgressTrackerUIControl.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 29.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import UIKit

public final class ProgressTrackerUIControl: UIControl {

    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    public var intent: ProgressTrackerIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    public var variant: ProgressTrackerVariant {
        didSet {

        }
    }

    public var size: ProgressTrackerSize {
        didSet {

        }
    }

    public var interactionState: ProgressInteractionState {
        didSet {

        }
    }

    public var numberOfPages: Int {
        set {
            self.viewModel.numberOfPages = newValue
        }
        get {
            return self.viewModel.numberOfPages
        }
    }

    public var currentPage: Int {
        set {
            self.viewModel.currentPage = newValue
        }
        get {
            return self.viewModel.currentPage
        }
    }

    public var allowsContinuousInteraction: Bool {
        set {
            self.interactionState = newValue ? .continuous : .discrete
        }
        get {
            return self.interactionState == .continuous && self.isUserInteractionEnabled
        }
    }

    private let viewModel: ProgressTrackerViewModel<ProgressTrackerUIIndicatorContent>

    private lazy var indicatorViews = [ProgressTrackerIndicatorUIControl]()
    private lazy var labels = [UILabel]()
    private lazy var trackViews = [ProgressTrackerTrackUIView]()

    @ScaledUIMetric private var scaleFactor: CGFloat = 1.0

    private var trackHeightConstraint: NSLayoutConstraint?

    private var trackSpacing: CGFloat {
        return self.viewModel.spacings.trackIndicatorSpacing * self.scaleFactor
    }

    public init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize = .medium,
        orientation: ProgressTrackerOrientation = .horizontal
    ) {
        let content = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(numberOfPages: 5, currentPage: 0)

        let viewModel = ProgressTrackerViewModel<ProgressTrackerUIIndicatorContent>(
            theme: theme,
            intent: intent,
            orientation: orientation, 
            content: content)

        self.viewModel = viewModel
        self.variant = variant
        self.size = size
        self.interactionState = .discrete

        super.init(frame: .zero)

        self.setupView()
    }

    private func createIndicatorViews() -> [ProgressTrackerIndicatorUIControl] {
        guard self.numberOfPages > 0 else { return [] }

        return (0..<self.numberOfPages).map { index in
            let indicator = ProgressTrackerIndicatorUIControl(
                theme: self.theme,
                intent: self.intent,
                variant: self.variant,
                size: self.size,
                content: self.viewModel.content.content(ofPage: index))
            indicator.translatesAutoresizingMaskIntoConstraints = false
            return indicator
        }
    }

    private func createLabels() ->
    [UILabel] {
        guard self.viewModel.content.hasLabel else { return [] }
        return (0..<self.numberOfPages).map{ index in
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.attributedText = self.viewModel.content.getAttributedLabel(forPage: index)
            return label
        }
    }

    private func createTrackView() -> [ProgressTrackerTrackUIView] {
        guard self.numberOfPages > 1 else { return [] }

        return (0..<self.numberOfPages - 1).map { _ in
            let view = ProgressTrackerTrackUIView(
                theme: self.theme,
                intent: self.intent,
                orientation: self.viewModel.orientation)
            view.isEnabled = self.isEnabled
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
    }

    private func setupIndicatorsAndLabels() {
        self.indicatorViews.removeAllFromSuperView()
        self.indicatorViews = self.createIndicatorViews()
        self.indicatorViews.addToSuperView(self)

        self.trackViews.removeAllFromSuperView()
        self.trackViews = self.createTrackView()
        self.trackViews.addToSuperView(self)

        self.labels.removeAllFromSuperView()
        self.labels = self.createLabels()
        self.labels.addToSuperView(self)
    }

    private func setupView() {
        self.setupIndicatorsAndLabels()
        if self.viewModel.orientation == .horizontal {
            self.setupHorizontalViewConstraints()
        } else {
            self.setupVerticalViewConstraints()
        }
    }

    private func setupHorizontalViewConstraints() {

        var precedingView = self.indicatorViews[0]
        var constraints = [NSLayoutConstraint]()

        constraints.append(precedingView.topAnchor.constraint(equalTo: self.topAnchor))

        for i in 1..<self.numberOfPages {
            let trackView = self.trackViews[i-1]
            constraints.append(trackView.leadingAnchor.constraint(equalTo: precedingView.trailingAnchor, constant: self.trackSpacing))
            constraints.append(trackView.centerYAnchor.constraint(equalTo: precedingView.centerYAnchor))
            constraints.append(self.indicatorViews[i].leadingAnchor.constraint(equalTo: trackView.trailingAnchor, constant: self.trackSpacing))
            constraints.append(self.indicatorViews[i].topAnchor.constraint(equalTo: self.topAnchor))
            precedingView = self.indicatorViews[i]
        }

        let lastIndex = self.numberOfPages - 1
        if self.viewModel.content.hasLabel {
            for i in 0..<self.numberOfPages {
                constraints.append(self.indicatorViews[i].centerXAnchor.constraint(equalTo: self.labels[i].centerXAnchor))
                constraints.append(self.labels[i].topAnchor.constraint(equalTo: self.indicatorViews[i].bottomAnchor))
                constraints.append(self.labels[i].bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor))
            }
            constraints.append(self.labels[0].leadingAnchor.constraint(equalTo: self.leadingAnchor))
            constraints.append(self.labels[lastIndex].trailingAnchor.constraint(equalTo: self.trailingAnchor))
        } else {
            constraints.append(self.indicatorViews[0].leadingAnchor.constraint(equalTo: self.leadingAnchor))
            constraints.append(self.indicatorViews [lastIndex].trailingAnchor.constraint(equalTo: self.trailingAnchor))
            constraints.append(self.indicatorViews[0].bottomAnchor.constraint(equalTo: self.bottomAnchor))
        }

        NSLayoutConstraint.activate(constraints)
    }

    private func setupVerticalViewConstraints() {

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension Collection where Element: UIView {
    func removeAllFromSuperView() {
        for view in self {
            view.removeFromSuperview()
        }
    }

    func addToSuperView(_ superView: UIView) {
        for view in self {
            superView.addSubview(view)
        }
    }
}

private extension UIView {
    func addSubviews(_ views: any Collection<UIView>) {
        for view in views {
            self.addSubview(view)
        }
    }
}
