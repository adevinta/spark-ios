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

/// A progress tracker, similar to the UIPageControl
public final class ProgressTrackerUIControl: UIControl {

    typealias Content = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>
    typealias AccessibilityIdentifier = ProgressTrackerAccessibilityIdentifier

    /// The general theme
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
            self.didUpdate(theme: newValue)
        }
    }

    /// The intent defining the colors
    public var intent: ProgressTrackerIntent {
        didSet {
            guard self.intent != oldValue else { return }
            self.didUpdate(intent: self.intent)
        }
    }

    /// The orientation. There are two orientations, horizontal, which is the default, and vertical.
    public var orientation: ProgressTrackerOrientation {
        get {
            return self.viewModel.orientation
        }
        set {
            self.viewModel.orientation = newValue
        }
    }

    /// The coloring variant, tinted or outlined.
    public var variant: ProgressTrackerVariant {
        didSet {
            self.didUpdate(variant: self.variant)
        }
    }

    /// The size of the indicator. Small indicator show now content.
    public var size: ProgressTrackerSize {
        didSet {
            self.didUpdate(size: self.size)
        }
    }

    /// Boolean to enable/disable the control.
    public override var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
            self.viewModel.isEnabled = newValue
            if newValue {
                self.accessibilityTraits.remove(.notEnabled)
            } else {
                self.accessibilityTraits.insert(.notEnabled)
            }
        }
    }

    /// A boolean determining if the  page number should be shown on the indicator by default.
    public var showDefaultPageNumber: Bool {
        get {
            return self.viewModel.showDefaultPageNumber
        }
        set {
            self.viewModel.showDefaultPageNumber = newValue
        }
    }

    private var subject = PassthroughSubject<Int, Never>()
    public var publisher: some Publisher<Int, Never> {
        return self.subject
    }

    /// The type of interaction enabled for the Progress Tracker
    public var interactionState: ProgressTrackerInteractionState = .none {
        didSet {
            self.didUpdate(interactionState: self.interactionState)
        }
    }

    /// The number of pages shown in the Progress Tracker
    public var numberOfPages: Int {
        set {
            self.viewModel.numberOfPages = newValue
        }
        get {
            return self.viewModel.numberOfPages
        }
    }

    /// The current page. This value represents the index of the current page.
    public var currentPageIndex: Int {
        set {
            self.viewModel.currentPageIndex = newValue
        }
        get {
            return self.viewModel.currentPageIndex
        }
    }

    /// Enable continuous interaction on the progress tracker.
    public var allowsContinuousInteraction: Bool {
        set {
            self.interactionState = newValue ? .continuous : .discrete
        }
        get {
            return self.interactionState == .continuous && self.isUserInteractionEnabled
        }
    }

    // MARK: - Private variables
    private let viewModel: ProgressTrackerViewModel<ProgressTrackerUIIndicatorContent>

    lazy var indicatorViews = [ProgressTrackerIndicatorUIControl]()
    private lazy var labels = [UILabel]()
    private lazy var hiddenLabels = [UILabel]()
    private lazy var trackViews = [ProgressTrackerTrackUIView]()
    private lazy var indicatorContainerViews = [UIControl]()

    var viewCount = 0

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

    private var touchHandler: ProgressTrackerUITouchHandling?

    // MARK: Initialization
    /// Initializer
    /// - Parameters:
    ///  - theme: the general theme
    ///  - intent: The intent defining the colors
    ///  - variant: Tinted or outlined
    ///  - size: The default is `medium`
    ///  - labels: The labels under each indicator
    ///  - orienation: The default is `horizontal`
    public convenience init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize = .medium,
        labels: [String],
        orientation: ProgressTrackerOrientation = .horizontal
    ) {
        var content = Content(numberOfPages: labels.count, currentPageIndex: 0)
        for (index, label) in labels.enumerated() {
            content.setAttributedLabel(NSAttributedString(string: label), atIndex: index)
        }

        self.init(
            theme: theme,
            intent: intent,
            variant: variant,
            size: size,
            content: content,
            orientation: orientation
        )
    }

    // MARK: Initialization
    /// Initializer
    /// - Parameters:
    ///  - theme: the general theme
    ///  - intent: The intent defining the colors
    ///  - variant: Tinted or outlined
    ///  - size: The default is `medium`
    ///  - numberOfPages: The number of track indicators (pages)
    ///  - orienation: The default is `horizontal`
    public convenience init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize = .medium,
        numberOfPages: Int,
        orientation: ProgressTrackerOrientation = .horizontal
    ) {
        let content = Content(numberOfPages: numberOfPages, currentPageIndex: 0)

        self.init(
            theme: theme,
            intent: intent,
            variant: variant,
            size: size,
            content: content,
            orientation: orientation
        )
    }

    // MARK: - Internal init
    init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize = .medium,
        content: Content,
        orientation: ProgressTrackerOrientation = .horizontal
    ) {

        let viewModel = ProgressTrackerViewModel<ProgressTrackerUIIndicatorContent>(
            theme: theme,
            orientation: orientation,
            content: content)

        self.viewModel = viewModel
        self.variant = variant
        self.size = size
        self.intent = intent

        super.init(frame: .zero)

        self.setupView(content: content, orientation: orientation)
        self.setupSubscriptions()
        self.enableTouch()
        self.addPanGestureToPreventCancelTracking()
        self.isUserInteractionEnabled = false
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if self.traitCollection.hasDifferentSizeCategory(comparedTo: previousTraitCollection) {        self._scaleFactor.update(traitCollection: self.traitCollection)
            self.didUpdate(spacings: self.viewModel.spacings)
        }
    }

    //MARK: - Handle touch events
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchHandler = self.interactionState.touchHandler(
            currentPageIndex: self.currentPageIndex,
            indicatorViews: self.indicatorContainerViews)

        self.touchHandler = touchHandler
        touchHandler.currentPagePublisher.subscribe(in: &self.cancellables) { [weak self] index in
            self?.updateCurrentPageTrackingIndex(index)
        }

        touchHandler.beginTracking(location: touch.location(in: self))

        return true
    }

    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {

        if !self.isHighlighted {
            self.cancelHighlighted()
        } else {
            self.touchHandler?.continueTracking(location: touch.location(in: self))
        }

        return true
    }

    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.cancelHighlighted()

        guard let location = touch?.location(in: self), self.isHighlighted else {
            return
        }

        self.touchHandler?.endTracking(location: location)

        self.touchHandler = nil
    }

    //MARK: Touch handling actions
    private func updateCurrentPageTrackingIndex(_ index: Int) {
        self.cancelHighlighted()

        self.currentPageIndex = index

        self.subject.send(index)
        self.sendActions(for: .valueChanged)
    }

    //MARK: - Private functions
    private func cancelHighlighted() {
        guard let index = self.touchHandler?.trackingPageIndex else { return }
        self.indicatorViews[safe: index]?.isHighlighted = false
    }

    // MARK: Private functions
    private func createContainerViews(numberOfPages: Int) -> [UIControl] {
        guard numberOfPages > 0 else { return [] }

        return (0..<numberOfPages).map { _ in
            let view = ProgressTrackerAccessibilityUIControl()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            view.isUserInteractionEnabled = false
            return view
        }
    }

    private func createIndicatorViews(content: Content) -> [ProgressTrackerIndicatorUIControl] {
        guard content.numberOfPages > 0 else { return [] }

        return (0..<content.numberOfPages).map { index in
            let indicator = ProgressTrackerIndicatorUIControl(
                theme: self.theme,
                intent: self.intent,
                variant: self.variant,
                size: self.size,
                content: content.pageContent(atIndex: index))
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.isEnabled = !self.viewModel.disabledIndices.contains(index)
            indicator.isUserInteractionEnabled = false
            indicator.accessibilityIdentifier = AccessibilityIdentifier.indicator(forIndex: index)
            indicator.accessibilityValue = "\(index)"
            indicator.isAccessibilityElement = true
            indicator.accessibilityLabel = content.getIndicatorAccessibilityLabel(atIndex: index)
            return indicator
        }
    }

    //MARK: - View creation
    private func createLabels(content: Content) ->
    [UILabel] {
        guard content.hasLabel else { return [] }
        return (0..<content.numberOfPages).map{ index in
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.adjustsFontForContentSizeCategory = true
            label.attributedText = content.getAttributedLabel(atIndex: index)
            label.font = self.viewModel.font.uiFont
            label.textColor = self.viewModel.labelColor.uiColor
            label.alpha = self.viewModel.labelOpacity(forIndex: index)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.allowsDefaultTighteningForTruncation = true
            label.isUserInteractionEnabled = false
            label.isAccessibilityElement = true

            return label
        }
    }

    private func setItemsAccessibilityTraits(disabledIndices: Set<Int>, currentPageIndex: Int) {

        if self.viewModel.content.hasLabel {
            let buttons = zip(self.indicatorViews, self.labels)
            for (indicatorContainerView, button) in zip(indicatorContainerViews, buttons) {
                indicatorContainerView.accessibilityElements = [button.0, button.1]
                indicatorContainerView.shouldGroupAccessibilityChildren = true
                indicatorContainerView.isAccessibilityElement = true

                indicatorContainerView.accessibilityLabel = button.1.accessibilityLabel ?? button.0.accessibilityLabel
            }
        } else {
            for (indicatorContainerView, indicatorView) in zip(self.indicatorContainerViews, self.indicatorViews) {
                indicatorContainerView.accessibilityElements = [indicatorView]
                indicatorContainerView.shouldGroupAccessibilityChildren = true
                indicatorContainerView.isAccessibilityElement = true

                indicatorContainerView.accessibilityLabel = indicatorView.accessibilityLabel
            }
        }

        for (index, indicator) in self.indicatorContainerViews.enumerated() {
            self.setItemAccessibilityTraits(view: indicator, index: index, disabledIndices: disabledIndices, currentPageIndex: currentPageIndex)
        }
    }

    private func setItemAccessibilityTraits(view: UIView, index: Int, disabledIndices: Set<Int>, currentPageIndex: Int) {

        view.accessibilityIdentifier = AccessibilityIdentifier.indicator(forIndex: index)
        view.accessibilityValue = "\(index)"
        view.isAccessibilityElement = true

        if self.interactionState == .none {
            view.accessibilityTraits.remove(.button)
            view.accessibilityRespondsToUserInteraction = false
        } else {
            view.accessibilityTraits.insert(.button)
            view.accessibilityRespondsToUserInteraction = true
        }

        if disabledIndices.contains(index) {
            view.accessibilityTraits.insert(.notEnabled)
        } else {
            view.accessibilityTraits.remove(.notEnabled)
        }
        if index == currentPageIndex {
            view.accessibilityTraits.insert(.selected)
        } else {
            view.accessibilityTraits.remove(.selected)
        }
    }

    private func createHiddenLabels(content: Content) -> [UILabel] {
        guard content.hasLabel else { return [] }
        return (0..<content.numberOfPages).map{ index in
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.isUserInteractionEnabled = false
            label.adjustsFontForContentSizeCategory = true
            label.font = self.viewModel.font.uiFont
            return label
        }
    }

    private func createTrackView(numberOfPages: Int, orientation: ProgressTrackerOrientation) -> [ProgressTrackerTrackUIView] {
        guard numberOfPages > 1 else { return [] }

        return (0..<numberOfPages - 1).map { index in
            let view = ProgressTrackerTrackUIView(
                theme: self.theme,
                intent: self.intent,
                orientation: orientation)
            view.isEnabled = !self.viewModel.disabledIndices.contains(index+1)
            view.isUserInteractionEnabled = false
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
    }

    //MARK: - View setup
    private func setupIndicatorsAndLabels(content: Content, orientation: ProgressTrackerOrientation) {
        NSLayoutConstraint.deactivate(self.labelSpacingConstraints)
        NSLayoutConstraint.deactivate(self.trackSpacingConstraints)

        self.subviews.forEach { $0.removeFromSuperview() }

        self.trackSpacingConstraints = []
        self.labelSpacingConstraints = []

        self.indicatorContainerViews = self.createContainerViews(numberOfPages: content.numberOfPages)
        self.indicatorContainerViews.addToSuperView(self)

        self.indicatorViews = self.createIndicatorViews(content: content)

        for (view, subview) in zip(self.indicatorContainerViews, self.indicatorViews) {
            view.addSubview(subview)
        }

        self.indicatorViews[content.currentPageIndex].isSelected = true

        self.trackViews = self.createTrackView(numberOfPages: content.numberOfPages, orientation: orientation)
        self.trackViews.addToSuperView(self)

        self.labels = self.createLabels(content: content)

        for (view, subview) in zip(self.indicatorContainerViews, self.labels) {
            view.addSubview(subview)
        }

        if orientation == .vertical {
            self.hiddenLabels = self.createHiddenLabels(content: content)
            for hiddenLabel in hiddenLabels {
                hiddenLabel.text = " "
            }
            for (view, subview) in zip(self.indicatorContainerViews, self.hiddenLabels) {
                view.addSubview(subview)
            }
        }
    }

    private func setupView(content: Content, orientation: ProgressTrackerOrientation) {
        guard content.numberOfPages > 0 else { return }

        self.setupIndicatorsAndLabels(content: content, orientation: orientation)

        if orientation == .horizontal {
            self.setupHorizontalViewConstraints(content: content)
        } else {
            self.setupVerticalViewConstraints(content: content)
        }

        self.accessibilityIdentifier = AccessibilityIdentifier.identifier
        self.accessibilityValue = "\(self.currentPageIndex)"
        if !self.viewModel.isEnabled {
            self.accessibilityTraits.insert(.notEnabled)
        } else {
            self.accessibilityTraits.remove(.notEnabled)
        }
        if self.interactionState == .none {
            self.accessibilityTraits.remove(.allowsDirectInteraction)
        } else {
            self.accessibilityTraits.insert(.allowsDirectInteraction)
        }

        self.setItemsAccessibilityTraits(disabledIndices: self.viewModel.disabledIndices, currentPageIndex: self.viewModel.currentPageIndex)

        self.viewCount += 1
    }

    // MARK: Setup supscriptions
    private func setupSubscriptions() {
        self.viewModel.$content.dropFirst().removeDuplicates().subscribe(in: &self.cancellables) { [weak self] content in
            self?.didUpdate(content: content)
        }

        self.viewModel.$orientation.dropFirst().removeDuplicates().subscribe(in: &self.cancellables) { [weak self] orientation in
            guard let self = self else { return }
            self.setupView(content: self.viewModel.content, orientation: orientation)
        }

        self.viewModel.$font.dropFirst().removeDuplicates(by: {$0.uiFont == $1.uiFont}).subscribe(in: &self.cancellables) { [weak self] font in
            guard let self = self else { return }
            for label in self.labels {
                label.font = font.uiFont
            }
        }

        self.viewModel.$labelColor.dropFirst().removeDuplicates(by: {$0.uiColor == $1.uiColor}).subscribe(in: &self.cancellables) { [weak self] labelColor in
            guard let self = self else { return }
            for label in self.labels {
                label.textColor = labelColor.uiColor
            }
        }

        self.viewModel.$spacings.dropFirst().removeDuplicates().subscribe(in: &self.cancellables) { [weak self] spacings in
            self?.didUpdate(spacings: spacings)
        }

        self.viewModel.$disabledIndices.dropFirst().removeDuplicates().subscribe(in: &self.cancellables) { disabledIndices in
            self.didUpdateDisabledStatus(for: disabledIndices)
        }
    }

    private func setupHorizontalViewConstraints(content: Content) {
        var precedingView = self.indicatorViews[0]
        var constraints = [NSLayoutConstraint]()

        constraints.append(precedingView.topAnchor.constraint(equalTo: self.topAnchor))

        let numberOfPages = self.indicatorViews.count

        if content.hasLabel {
            for (indicator, indicatorContainerView) in zip(self.indicatorViews, self.indicatorContainerViews) {
                constraints.append(contentsOf: [
                    indicator.centerXAnchor.constraint(equalTo: indicatorContainerView.centerXAnchor),
                    indicator.topAnchor.constraint(equalTo: indicatorContainerView.topAnchor),
                    indicatorContainerView.widthAnchor.constraint(greaterThanOrEqualTo: indicator.widthAnchor)
                ])
            }
            for (label, indicatorContainerView) in zip(self.labels, self.indicatorContainerViews) {
                constraints.append(contentsOf: [
                    label.centerXAnchor.constraint(equalTo: indicatorContainerView.centerXAnchor),
                    label.bottomAnchor.constraint(equalTo: indicatorContainerView.bottomAnchor),
                    indicatorContainerView.widthAnchor.constraint(greaterThanOrEqualTo: label.widthAnchor)
                ])
            }
        } else {
            for (indicator, indicatorContainer) in zip(self.indicatorViews, self.indicatorContainerViews) {
                constraints.append(contentsOf: NSLayoutConstraint.edgeConstraints(from: indicator, to: indicatorContainer))
            }
        }

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

        for i in 1..<self.trackViews.count {
            let trackWidthConstraint = self.trackViews[i].widthAnchor.constraint(equalTo: self.trackViews[i-1].widthAnchor)
            trackWidthConstraint.priority = .init(rawValue: 200)
            constraints.append(trackWidthConstraint)
        }

        let lastIndex = numberOfPages - 1
        if content.hasLabel {
            for i in 0..<numberOfPages {
                self.labels[i].textAlignment = .center
                let centerXConstraint = self.indicatorViews[i].centerXAnchor.constraint(equalTo: self.labels[i].centerXAnchor)
                centerXConstraint.priority = .required
                constraints.append(centerXConstraint)

                let labelTopConstraint = self.labels[i].topAnchor.constraint(equalTo: self.indicatorViews[i].bottomAnchor, constant: self.labelSpacing)
                constraints.append(labelTopConstraint)
                self.labelSpacingConstraints.append(labelTopConstraint)
                constraints.append(self.labels[i].bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor))
            }
            for i in 1..<numberOfPages {
                let labelTrailingConstraint = self.labels[i].leadingAnchor.constraint(greaterThanOrEqualTo: self.labels[i-1].trailingAnchor, constant: self.labelSpacing)
                self.labelSpacingConstraints.append(labelTrailingConstraint)
                constraints.append(labelTrailingConstraint)

                let labelWidthAnchor = self.labels[i].widthAnchor.constraint(equalTo: self.labels[i-1].widthAnchor)
                labelWidthAnchor.priority = .defaultLow
                constraints.append(labelWidthAnchor)
            }
            constraints.append(self.labels[0].leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor))
            constraints.append(self.indicatorViews[0].leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor))
            constraints.append(self.labels[lastIndex].trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor))
            constraints.append(self.indicatorViews [lastIndex].trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor))
        } else {
            constraints.append(self.indicatorViews[0].leadingAnchor.constraint(equalTo: self.leadingAnchor))
            constraints.append(self.indicatorViews [lastIndex].trailingAnchor.constraint(equalTo: self.trailingAnchor))
            constraints.append(self.indicatorViews[0].bottomAnchor.constraint(equalTo: self.bottomAnchor))
        }

        NSLayoutConstraint.activate(constraints)
    }

    private func setupVerticalViewConstraints(content: Content) {
        var precedingView = self.indicatorViews[0]
        var constraints = [NSLayoutConstraint]()

        let numberOfPages = self.indicatorViews.count

        if content.hasLabel {
            for (indicator, indicatorContainerView) in zip(self.indicatorViews, self.indicatorContainerViews) {
                constraints.append(contentsOf: [
                    indicator.leadingAnchor.constraint(equalTo: indicatorContainerView.leadingAnchor),
                    indicator.topAnchor.constraint(equalTo: indicatorContainerView.topAnchor),
                    indicatorContainerView.heightAnchor.constraint(greaterThanOrEqualTo: indicator.heightAnchor)
                ])
            }
            for (label, indicatorContainerView) in zip(self.labels, self.indicatorContainerViews) {
                constraints.append(contentsOf: [
                    label.trailingAnchor.constraint(equalTo: indicatorContainerView.trailingAnchor),
                    indicatorContainerView.heightAnchor.constraint(greaterThanOrEqualTo: label.heightAnchor)
                ])
            }
        } else {
            for (indicator, indicatorContainer) in zip(self.indicatorViews, self.indicatorContainerViews) {
                constraints.append(contentsOf: NSLayoutConstraint.edgeConstraints(from: indicator, to: indicatorContainer))
            }
        }

        constraints.append(precedingView.leadingAnchor.constraint(equalTo: self.leadingAnchor))

        for i in 1..<numberOfPages {
            let trackView = self.trackViews[i-1]
            let trackTopSpacing = trackView.topAnchor.constraint(equalTo: precedingView.bottomAnchor, constant: self.trackSpacing)
            constraints.append(trackTopSpacing)
            self.trackSpacingConstraints.append(trackTopSpacing)
            constraints.append(trackView.centerXAnchor.constraint(equalTo: precedingView.centerXAnchor))
            let trackBottomSpacing = self.indicatorViews[i].topAnchor.constraint(equalTo: trackView.bottomAnchor, constant: self.trackSpacing)
            constraints.append(trackBottomSpacing)
            self.trackSpacingConstraints.append(trackBottomSpacing)
            constraints.append(self.indicatorViews[i].leadingAnchor.constraint(equalTo: self.leadingAnchor))
            precedingView = self.indicatorViews[i]
        }

        for i in 1..<self.trackViews.count {
            let trackHeightConstraint = self.trackViews[i].heightAnchor.constraint(equalTo: self.trackViews[i-1].heightAnchor)
            trackHeightConstraint.priority = .init(rawValue: 200)
            constraints.append(trackHeightConstraint)
        }

        let lastIndex = numberOfPages - 1
        if content.hasLabel {
            for i in 0..<numberOfPages {
                self.labels[i].textAlignment = .left
                constraints.append(self.indicatorViews[i].centerYAnchor.constraint(equalTo: self.hiddenLabels[i].centerYAnchor))
                constraints.append(self.indicatorViews[i].trailingAnchor.constraint(equalTo: self.hiddenLabels[i].leadingAnchor))
                constraints.append(self.labels[i].topAnchor.constraint(equalTo:  self.hiddenLabels[i].topAnchor))

                let labelLeadingConstraint = self.labels[i].leadingAnchor.constraint(equalTo: self.indicatorViews[i].trailingAnchor, constant: self.labelSpacing)
                constraints.append(labelLeadingConstraint)
                self.labelSpacingConstraints.append(labelLeadingConstraint)
                constraints.append(self.labels[i].trailingAnchor.constraint(equalTo: self.trailingAnchor))
            }
            for i in 1..<numberOfPages {
                let labelBottomConstraint = self.labels[i].topAnchor.constraint(greaterThanOrEqualTo: self.labels[i-1].bottomAnchor, constant: self.labelSpacing)
                self.labelSpacingConstraints.append(labelBottomConstraint)
                constraints.append(labelBottomConstraint)
            }
            constraints.append(self.indicatorViews[0].topAnchor.constraint(equalTo: self.topAnchor))
            constraints.append(self.labels[lastIndex].bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor))
            constraints.append(self.indicatorViews[lastIndex].bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor))
        } else {
            constraints.append(self.indicatorViews[0].topAnchor.constraint(equalTo: self.topAnchor))
            constraints.append(self.indicatorViews[0].trailingAnchor.constraint(equalTo: self.trailingAnchor))
            constraints.append(self.indicatorViews [lastIndex].bottomAnchor.constraint(equalTo: self.bottomAnchor))
        }

        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private view modifiers
    private func updateView(content: ProgressTrackerUIControl.Content) {
        self.accessibilityValue = "\(content.currentPageIndex)"
        for i in 0..<content.numberOfPages {
            self.indicatorViews[i].content = content.pageContent(atIndex: i)
            self.indicatorViews[i].isSelected = (i == content.currentPageIndex)
            self.indicatorViews[i].accessibilityLabel = content.getIndicatorAccessibilityLabel(atIndex: i)
        }
        if content.hasLabel {
            for i in 0..<content.numberOfPages {
                self.labels[i].attributedText = content.getAttributedLabel(atIndex: i)
                self.indicatorContainerViews[i].accessibilityLabel = self.labels[i].text
            }
        }

        self.setItemsAccessibilityTraits(disabledIndices: self.viewModel.disabledIndices, currentPageIndex: content.currentPageIndex)
    }
    
    private func didUpdate(content: Content) {
        if self.viewModel.content.needsUpdateOfLayout(otherComponent: content) {
            self.setupView(content: content, orientation: self.viewModel.orientation)
        } else if content.numberOfPages > 0 {
            self.updateView(content: content)
        }
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

    private func didUpdate(spacings: ProgressTrackerSpacing) {
        self.trackSpacingConstraints.forEach { constraint in
            constraint.constant = spacings.trackIndicatorSpacing * self.scaleFactor
        }

        self.labelSpacingConstraints.forEach { constraint in
            constraint.constant = spacings.minLabelSpacing * self.scaleFactor
        }

    }

    private func didUpdate(interactionState: ProgressTrackerInteractionState) {
        self.isUserInteractionEnabled = interactionState != .none
        if self.interactionState == .none {
            self.accessibilityTraits.remove(.allowsDirectInteraction)
        } else {
            self.accessibilityTraits.insert(.allowsDirectInteraction)
        }

        self.setItemsAccessibilityTraits(disabledIndices: self.viewModel.disabledIndices, currentPageIndex: self.viewModel.currentPageIndex)
    }

    private func didUpdateDisabledStatus(for disabledIndices: Set<Int>) {
        for (index, view) in self.labels.enumerated() {
            let isDisabled = disabledIndices.contains(index)
            view.alpha = self.viewModel.labelOpacity(isDisabled: isDisabled)
        }
        for (index, view) in self.indicatorViews.enumerated() {
            view.isEnabled = !disabledIndices.contains(index)
        }
        for (index, view) in self.trackViews.enumerated() {
            view.isEnabled = !disabledIndices.contains(index+1)
        }

        self.setItemsAccessibilityTraits(disabledIndices: disabledIndices, currentPageIndex: self.viewModel.currentPageIndex)
    }

    // MARK: - Public modifiers
    /// Set the indicator image at the specified index
    /// - Parameters:
    ///   - image: An optional image. Setting the image to nil will remove it.
    ///   - forIndex: The index to use the image
    public func setIndicatorImage(_ image: UIImage?, forIndex index: Int) {
        self.viewModel.content.setIndicatorImage(image, atIndex: index)
    }

    /// Set the current indicator image at the given index. This indicator image will be shown when the page is selected
    /// - Parameters:
    ///   - image: An optional image. Setting the image to nil will remove it
    ///   - forIndex: The page index for the image
    public func setCurrentPageIndicatorImage(_ image: UIImage?, forIndex index: Int) {
        self.viewModel.content.setCurrentPageIndicatorImage(image, atIndex: index)
    }

    /// Set an attributed label aligned to the corresponding indicator. This will be below the indicator in a horizontal alignment and to the right of it in a vertical alignment. Setting an attributed label and label are mutually exclusive. Setting a label at the position of an attributed label will overwrite the attributed label.
    /// - Parameters:
    ///   - attributedLabel: An optional attributed label to set at the given index. Setting this value to nil will remove an existing attributedLabel or label at the index.
    ///   - forIndex: The index of the label
    public func setAttributedLabel(_ attributedLabel: NSAttributedString?, forIndex index: Int) {
        self.viewModel.content.setAttributedLabel(attributedLabel, atIndex: index)
    }

    /// Returns the attributed label at the given index.
    public func getAttributedLabel(ofIndex index: Int) -> NSAttributedString? {
        return self.viewModel.content.getAttributedLabel(atIndex: index)
    }

    /// Set a label at the corresponding index. This will overwrite an existing attributed label at the same position.
    /// - Parameters:
    ///   - label: An optional label. Setting it to nil, will remove an existing label or attributed label.
    ///   - index: The page index
    public func setLabel(_ label: String?, forIndex index: Int) {
        let attributedLabel = label.map(NSAttributedString.init)
        self.viewModel.content.setAttributedLabel(attributedLabel, atIndex: index)
    }

    /// Returns the label aligned to the indicator at the given index.
    public func getLabel(forIndex index: Int) -> String? {
        return self.viewModel.content.getAttributedLabel(atIndex: index)?.string
    }

    /// Set a character on the indicator for the given index.
    /// - Parameters:
    ///   - label: An optional character for the indicator label
    ///   - forIndex: The index of the indicator
    public func setIndicatorLabel(_ label: String?, forIndex index: Int) {
        self.viewModel.content.setIndicatorLabel(label, atIndex: index)
    }

    /// Return the current indicator label at the given index.
    public func getIndicatorLabel(forIndex index: Int) -> String? {
        self.viewModel.content.getIndicatorLabel(atIndex: index)
    }

    /// Set the indicator image of the already visited pages
    public func setCompletedIndicatorImage(_ image: UIImage?) {
        self.viewModel.content.completedPageIndicatorImage = image
    }

    /// Return the indicator image of the pages already visited
    public func getCompletedIndicatorImage() -> UIImage? {
        return self.viewModel.content.completedPageIndicatorImage
    }

    /// Set the indicator at
    public func setIsEnabled(_ isEnabled: Bool, forIndex index: Int) {
        guard index < self.indicatorViews.count else { return }

        self.viewModel.setIsEnabled(isEnabled: isEnabled, forIndex: index)
    }

    /// Set the default preferred indicator image
    public func setPreferredIndicatorImage(_ image: UIImage?) {
        self.viewModel.content.preferredIndicatorImage = image
    }

    /// Return the default preferred indicator image
    public func getPreferredIndicatorImage() -> UIImage? {
        return self.viewModel.content.preferredIndicatorImage
    }

    /// Set the default image for the current page indicator
    public func setPreferredCurrentPageIndicatorImage(_ image: UIImage?) {
        self.viewModel.content.preferredCurrentPageIndicatorImage = image
    }

    /// Return the default image for the current page indicator
    public func getPreferredCurrentPageIndicatorImage() -> UIImage? {
        return self.viewModel.content.preferredCurrentPageIndicatorImage
    }
}

// MARK: Private helper extensions
private extension Collection where Element: UIView {
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
