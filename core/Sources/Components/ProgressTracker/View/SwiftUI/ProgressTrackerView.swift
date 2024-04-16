//
//  ProgressTrackerView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 15.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

/// A progress tracker, similar to the UIPageControl
public struct ProgressTrackerView: View {
    typealias Content = ProgressTrackerContent<ProgressTrackerIndicatorContent>
    typealias AccessibilityIdentifier = ProgressTrackerAccessibilityIdentifier

    //MARK: - Private properties
    @ObservedObject private var viewModel: ProgressTrackerViewModel<ProgressTrackerIndicatorContent>
    private let intent: ProgressTrackerIntent
    private let variant: ProgressTrackerVariant
    private let size: ProgressTrackerSize
    @Binding var currentPageIndex: Int
    @Environment(\.isEnabled) private var isEnabled: Bool

    //MARK: - Initialization
    /// Initializer
    /// - Parameters:
    ///  - theme: the general theme
    ///  - intent: The intent defining the colors
    ///  - variant: Tinted or outlined
    ///  - size: The default is `medium`
    ///  - labels: The labels under each indicator
    ///  - orienation: The default is `horizontal`
    ///  - currentPageIndex: A binding representing the current page
    public init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize,
        labels: [String],
        orientation: ProgressTrackerOrientation = .horizontal,
        currentPageIndex: Binding<Int>
    ) {
        var content = Content(numberOfPages: labels.count)
        content.currentPageIndex = currentPageIndex.wrappedValue
        for (index, label) in labels.enumerated() {
            content.setAttributedLabel(AttributedString(stringLiteral: label), atIndex: index)
        }

        self.init(theme: theme, intent: intent, variant: variant, size: size, orientation: orientation, currentPageIndex: currentPageIndex, content: content)
    }

    /// Initializer
    /// - Parameters:
    ///  - theme: the general theme
    ///  - intent: The intent defining the colors
    ///  - variant: Tinted or outlined
    ///  - size: The default is `medium`
    ///  - numberOfPages: The number of track indicators (pages)
    ///  - orienation: The default is `horizontal`
    ///  - currentPageIndex: A binding representing the current page
    public init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize,
        numberOfPages: Int,
        orientation: ProgressTrackerOrientation = .horizontal,
        currentPageIndex: Binding<Int>
    ) {
        var content = Content(numberOfPages: numberOfPages)
        content.currentPageIndex = currentPageIndex.wrappedValue

        self.init(theme: theme, intent: intent, variant: variant, size: size, orientation: orientation, currentPageIndex: currentPageIndex, content: content)
    }

    init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize,
        orientation: ProgressTrackerOrientation = .horizontal,
        currentPageIndex: Binding<Int>,
        content: Content
    ) {
        let viewModel = ProgressTrackerViewModel<ProgressTrackerIndicatorContent>(
            theme: theme,
            orientation: orientation,
            content: content)

        self.viewModel = viewModel
        self.variant = variant
        self.size = size
        self.intent = intent
        self._currentPageIndex = currentPageIndex
    }

    //MARK: - Body
    public var body: some View {
        self.progressTrackerView
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(AccessibilityIdentifier.identifier)
            .accessibilityValue("\(self.currentPageIndex)")
            .backgroundPreferenceValue(ProgressTrackerSizePreferences.self) { preferences in
                if self.viewModel.interactionState != .none {
                    GeometryReader { geometry in
                        Color.black.opacity(0.000001)
                            .gesture(self.dragGesture(bounds: geometry.frame(in: .local), preferences: preferences))
                    }
                }
            }
    }

    //MARK: - Private functions
    private func dragGesture(bounds: CGRect?, preferences: [Int: CGRect]) -> some Gesture {

        let indicators = preferences.sorted { $0.key < $1.key }.map(\.value)
        let frame = bounds ?? .zero

        let gestureHandler = self.gestureHandler(frame: frame, indicators: indicators)

        return DragGesture(minimumDistance: .zero)
            .onChanged({ value in
                gestureHandler.onChanged(location: value.location)
            })
            .onEnded({ value in
                gestureHandler.onEnded(location: value.location)
            })
    }

    @ViewBuilder
    private var progressTrackerView: some View {
        let viewModel = self.viewModel.isEnabled(self.isEnabled)
        if viewModel.orientation == .horizontal {
            ProgressTrackerHorizontalView(intent: self.intent, variant: self.variant, size: self.size, currentPageIndex: self.$currentPageIndex, viewModel: viewModel)
        } else {
            ProgressTrackerVerticalView(intent: self.intent, variant: self.variant, size: self.size, currentPageIndex: self.$currentPageIndex, viewModel: viewModel)
        }
    }

    private func gestureHandler(frame: CGRect, indicators: [CGRect]) -> any ProgressTrackerGestureHandling {

        switch self.viewModel.interactionState {
        case .none:
            return ProgressTrackerNoneGestureHandler()
        case .discrete:
            return ProgressTrackerDiscreteGestureHandler(
                currentPageIndex: self._currentPageIndex,
                currentTouchedPageIndex: self.$viewModel.currentPressedIndicator,
                indicators: indicators, 
                frame: frame,
                disabledIndices: self.viewModel.disabledIndices
            )
        case .continuous:
            return ProgressTrackerContinuousGestureHandler(
                currentPageIndex: self._currentPageIndex,
                currentTouchedPageIndex: self.$viewModel.currentPressedIndicator,
                indicators: indicators, 
                frame: frame,
                disabledIndices: self.viewModel.disabledIndices
            )
        case .independent:
            return ProgressTrackerIndependentGestureHandler(
                currentPageIndex: self._currentPageIndex,
                currentTouchedPageIndex: self.$viewModel.currentPressedIndicator,
                indicators: indicators,
                frame: frame,
                disabledIndices: self.viewModel.disabledIndices
            )
        }
    }

    // MARK: - Public modifiers
    /// If use full width is set to true, the horizontal view will try and scale as wide as possible. If it is not true, it will only use as little space as required.
    public func useFullWidth(_ fullWidth: Bool) -> Self {
        self.viewModel.useFullWidth = fullWidth
        return self
    }

    /// Set the indicator image at the specified index
    /// - Parameters:
    ///   - image: An optional image. Setting the image to nil will remove it.
    ///   - forIndex: The index to use the image
    public func indicatorImage(_ image: Image?, forIndex index: Int) -> Self {
        self.viewModel.content.setIndicatorImage(image, atIndex: index)
        return self
    }

    /// Set the current indicator image at the given index. This indicator image will be shown when the page is selected
    /// - Parameters:
    ///   - image: An optional image. Setting the image to nil will remove it
    ///   - forIndex: The page index for the image
    public func currentPageIndicatorImage(_ image: Image?, forIndex index: Int) -> Self {
        self.viewModel.content.setCurrentPageIndicatorImage(image, atIndex: index)
        return self
    }

    /// Set an attributed label aligned to the corresponding indicator. This will be below the indicator in a horizontal alignment and to the right of it in a vertical alignment. Setting an attributed label and label are mutually exclusive. Setting a label at the position of an attributed label will overwrite the attributed label.
    /// - Parameters:
    ///   - attributedLabel: An optional attributed label to set at the given index. Setting this value to nil will remove an existing attributedLabel or label at the index.
    ///   - forIndex: The index of the label
    public func attributedLabel(_ attributedLabel: AttributedString?, forIndex index: Int) -> Self {
        self.viewModel.content.setAttributedLabel(attributedLabel, atIndex: index)
        return self
    }

    /// Set a label at the corresponding index. This will overwrite an existing attributed label at the same position.
    /// - Parameters:
    ///   - label: An optional label. Setting it to nil, will remove an existing label or attributed label.
    ///   - index: The page index
    public func label(_ label: String?, forIndex index: Int) -> Self {
        let attributedLabel = label.map(AttributedString.init)
        self.viewModel.content.setAttributedLabel(attributedLabel, atIndex: index)
        return self
    }

    /// Set a character on the indicator for the given index.
    /// - Parameters:
    ///   - label: An optional character for the indicator label
    ///   - forIndex: The index of the indicator
    public func indicatorLabel(_ label: String?, forIndex index: Int) -> Self {
        self.viewModel.content.setIndicatorLabel(label, atIndex: index)
        return self
    }

    /// Set the indicator image of the already visited pages
    public func completedIndicatorImage(_ image: Image?) -> Self {
        self.viewModel.content.completedPageIndicatorImage = image
        return self
    }

    /// Set the indicator at
    public func disable(_ isDisabled: Bool, forIndex index: Int) -> Self {
        guard index < self.viewModel.numberOfPages else { return self }

        self.viewModel.setIsEnabled(isEnabled: !isDisabled, forIndex: index)
        return self
    }

    /// Set the default preferred indicator image
    public func preferredIndicatorImage(_ image: Image?) -> Self {
        self.viewModel.content.preferredIndicatorImage = image

        return self
    }

    /// Set the default image for the current page indicator
    public func preferredCurrentPageIndicatorImage(_ image: Image?) -> Self {
        self.viewModel.content.preferredCurrentPageIndicatorImage = image
        return self
    }

    /// Set if the default page number should be shown
    public func showDefaultPageNumber(_ showPageNumber: Bool) -> Self {
        self.viewModel.showDefaultPageNumber = showPageNumber
        return self
    }

    /// Set the current interaction state
    public func interactionState(_ interactionState: ProgressTrackerInteractionState) -> Self {
        self.viewModel.interactionState = interactionState
        return self
    }
}

extension CGRect {
    var normalized: CGRect {
        return CGRect(x: max(self.origin.x, 0), y: max(self.origin.y, 0), width: self.width, height: self.height)
    }
}
