//
//  ProgressTrackerUIControl.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 29.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import Foundation
import UIKit

public final class ProgressTrackerUIControl: UIControl {

    typealias Content = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>

    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
            self.didUpdate(theme: newValue)
        }
    }

    public var intent: ProgressTrackerIntent {
        didSet {
            guard self.intent != oldValue else { return }
            self.didUpdate(intent: self.intent)
        }
    }

    public var variant: ProgressTrackerVariant {
        didSet {
            self.didUpdate(variant: self.variant)
        }
    }

    public var size: ProgressTrackerSize {
        didSet {
            self.didUpdate(size: self.size)
        }
    }

    public override var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
            self.viewModel.isEnabled = newValue
            self.didUpdate(isEnabled: newValue)
        }
    }

    public var showDefaultPageNumber: Bool {
        get {
            return self.viewModel.showDefaultPageNumber
        }
        set {
            self.viewModel.showDefaultPageNumber = newValue
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
    private var cancellables = Set<AnyCancellable>()

    private var trackSpacingConstraints = [NSLayoutConstraint]()
    private var labelSpacingConstraints = [NSLayoutConstraint]()

    private var trackSpacing: CGFloat {
        return self.viewModel.spacings.trackIndicatorSpacing * self.scaleFactor
    }

    private var labelSpacing: CGFloat {
        return self.viewModel.spacings.minLabelSpacing * self.scaleFactor
    }

    public init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize = .medium,
        numberOfPages: Int,
        orientation: ProgressTrackerOrientation = .horizontal
    ) {
        let content = Content(numberOfPages: numberOfPages, currentPage: 0)

        let viewModel = ProgressTrackerViewModel<ProgressTrackerUIIndicatorContent>(
            theme: theme,
            orientation: orientation,
            content: content)

        self.viewModel = viewModel
        self.variant = variant
        self.size = size
        self.interactionState = .discrete
        self.intent = intent

        super.init(frame: .zero)

        self.setupView(content: content)
        self.setupSubscriptions()
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self.trackSpacingConstraints.forEach { constraint in
            constraint.constant = self.trackSpacing
        }

        self.labelSpacingConstraints.forEach { constraint in
            constraint.constant = self.labelSpacing
        }
    }

    private func createIndicatorViews(content: Content) -> [ProgressTrackerIndicatorUIControl] {
        guard self.numberOfPages > 0 else { return [] }

        return (0..<self.numberOfPages).map { index in
            let indicator = ProgressTrackerIndicatorUIControl(
                theme: self.theme,
                intent: self.intent,
                variant: self.variant,
                size: self.size,
                content: content.content(ofIndex: index))
            indicator.translatesAutoresizingMaskIntoConstraints = false
            return indicator
        }
    }

    private func createLabels(content: Content) ->
    [UILabel] {
        guard content.hasLabel else { return [] }
        return (0..<self.numberOfPages).map{ index in
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.adjustsFontForContentSizeCategory = true
            label.attributedText = content.getAttributedLabel(ofIndex: index)
            label.font = self.viewModel.font.uiFont
            label.textColor = self.viewModel.labelColor.uiColor
            return label
        }
    }

    private func createTrackView(numberOfPages: Int) -> [ProgressTrackerTrackUIView] {
        guard self.numberOfPages > 1 else { return [] }

        return (0..<numberOfPages - 1).map { _ in
            let view = ProgressTrackerTrackUIView(
                theme: self.theme,
                intent: self.intent,
                orientation: self.viewModel.orientation)
            view.isEnabled = self.isEnabled
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
    }

    private func setupIndicatorsAndLabels(content: Content) {
        self.indicatorViews.removeAllFromSuperView()
        self.trackViews.removeAllFromSuperView()
        self.labels.removeAllFromSuperView()
        self.trackSpacingConstraints = []
        self.labelSpacingConstraints = []

        self.indicatorViews = self.createIndicatorViews(content: content)
        self.indicatorViews.addToSuperView(self)

        self.trackViews = self.createTrackView(numberOfPages: content.numberOfPages)
        self.trackViews.addToSuperView(self)

        self.labels = self.createLabels(content: content)
        self.labels.addToSuperView(self)
    }

    private func setupView(content: Content) {
        guard content.numberOfPages > 0 else { return }

        self.setupIndicatorsAndLabels(content: content)
        if self.viewModel.orientation == .horizontal {
            self.setupHorizontalViewConstraints(content: content)
        } else {
            self.setupVerticalViewConstraints()
        }
    }

    private func setupSubscriptions() {
        self.viewModel.$content.subscribe(in: &self.cancellables) { content in
            if self.viewModel.content.needsUpdateOfLayout(otherComponent: content) {
                self.setupView(content: content)
            } else if content.numberOfPages > 0 {
                for i in 0..<content.numberOfPages {
                    self.indicatorViews[i].content = content.content(ofIndex: i)
                }
            }
        }

        self.viewModel.$font.subscribe(in: &self.cancellables) { font in
            for label in self.labels {
                label.font = font.uiFont
            }
        }

        self.viewModel.$labelColor.subscribe(in: &self.cancellables) { color in
            for label in self.labels {
                label.textColor = color.uiColor
            }
        }
    }

    private func setupHorizontalViewConstraints(content: Content) {
        var precedingView = self.indicatorViews[0]
        var constraints = [NSLayoutConstraint]()

        constraints.append(precedingView.topAnchor.constraint(equalTo: self.topAnchor))

        let numberOfPages = self.indicatorViews.count

        for i in 1..<numberOfPages {
            let trackView = self.trackViews[i-1]
            let trackLeadingSpacing = trackView.leadingAnchor.constraint(equalTo: precedingView.trailingAnchor, constant: self.trackSpacing)
            constraints.append(trackLeadingSpacing)
            self.trackSpacingConstraints.append(trackLeadingSpacing)
            constraints.append(trackView.centerYAnchor.constraint(equalTo: precedingView.centerYAnchor))
            let trackTrailingSpacing = self.indicatorViews[i].leadingAnchor.constraint(equalTo: trackView.trailingAnchor, constant: self.trackSpacing)
            constraints.append(trackTrailingSpacing)
            self.trackSpacingConstraints.append(trackTrailingSpacing)
            constraints.append(self.indicatorViews[i].topAnchor.constraint(equalTo: self.topAnchor))
            precedingView = self.indicatorViews[i]
        }

        let lastIndex = numberOfPages - 1
        if content.hasLabel {
            for i in 0..<numberOfPages {
                constraints.append(self.indicatorViews[i].centerXAnchor.constraint(equalTo: self.labels[i].centerXAnchor))

                let labelLeadingConstraint = self.labels[i].topAnchor.constraint(equalTo: self.indicatorViews[i].bottomAnchor, constant: self.labelSpacing)
                constraints.append(labelLeadingConstraint)
                self.labelSpacingConstraints.append(labelLeadingConstraint)
                constraints.append(self.labels[i].bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor))
            }
            for i in 1..<numberOfPages {
                let labelTrailingConstraint = self.labels[i].leadingAnchor.constraint(equalTo: self.labels[i-1].trailingAnchor, constant: self.labelSpacing)
                self.labelSpacingConstraints.append(labelTrailingConstraint)
                constraints.append(labelTrailingConstraint)
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

    private func didUpdate(intent: ProgressTrackerIntent) {
        for indicatorView in self.indicatorViews {
            indicatorView.intent = intent
        }
        for trackView in self.trackViews {
            trackView.intent = intent
        }
    }

    private func didUpdate(theme: Theme) {
        for indicatorView in self.indicatorViews {
            indicatorView.theme = theme
        }
        for trackView in self.trackViews {
            trackView.theme = theme
        }
    }

    private func didUpdate(variant: ProgressTrackerVariant) {
        for indicatorView in self.indicatorViews {
            indicatorView.variant = variant
        }
    }

    private func didUpdate(size: ProgressTrackerSize) {
        for indicatorView in self.indicatorViews {
            indicatorView.size = size
        }
    }

    private func didUpdate(isEnabled: Bool) {
        for indicatorView in self.indicatorViews {
            indicatorView.isEnabled = isEnabled
        }
        for trackView in self.trackViews {
            trackView.isEnabled = isEnabled
        }
    }

    public func setIndicatorImage(_ image: UIImage?, forIndex index: Int) {
        self.viewModel.content.setIndicatorImage(image, forIndex: index)
    }

    public func setCurrentPageIndicatorImage(_ image: UIImage?, forIndex index: Int) {
        self.viewModel.content.setCurrentPageIndicatorImage(image, forIndex: index)
    }

    public func setAttributedLabel(_ attributedLabel: NSAttributedString?, forIndex index: Int) {
        self.viewModel.content.setAttributedLabel(attributedLabel, forIndex: index)
    }

    public func getAttributedLabel(ofIndex index: Int) -> NSAttributedString? {
        return self.viewModel.content.getAttributedLabel(ofIndex: index)
    }

    public func setLabel(_ label: String?, forIndex index: Int) {
        let attributedLabel = label.map(NSAttributedString.init)
        self.viewModel.content.setAttributedLabel(attributedLabel, forIndex: index)
    }

    public func getLabel(forIndex index: Int) -> String? {
        return self.viewModel.content.getAttributedLabel(ofIndex: index)?.string
    }

    public func setIndicatorLabel(_ label: Character?, forIndex index: Int) {
        self.viewModel.content.setContentLabel(label, ofIndex: index)
    }

    public func getIndicatorLabel(forIndex index: Int) -> Character? {
        self.viewModel.content.getContentLabel(ofIndex: index)
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
