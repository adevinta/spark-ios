//
//  RatingInputView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 06.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// A SwiftUI native rating input component.
public struct RatingInputView: View {
    // MARK: - Private variables
    @ObservedObject private var viewModel: RatingDisplayViewModel
    @Environment(\.isEnabled) private var isEnabled: Bool
    private var rating: Binding<CGFloat>
    private var configuration: StarConfiguration
    private var intent: RatingIntent

    // MARK: - Initialization
    /// Create a rating display view with the following parameters
    /// - Parameters:
    ///   - theme: The current theme
    ///   - intent: The intent to define the colors
    ///   - rating: A binding containg the rating value. This should be a value within the range 0...5
    ///   - configuration: A configuration of the star. A default value is defined.
    public init(
        theme: Theme,
        intent: RatingIntent,
        rating: Binding<CGFloat>,
        configuration: StarConfiguration = .default
    ) {
        self.rating = rating
        self.intent = intent
        self.configuration = configuration
        self.viewModel = RatingDisplayViewModel(
            theme: theme,
            intent: intent,
            size: .input,
            count: .five)
    }

    // MARK: - View
    public var body: some View {
        RatingInputInternalView(viewModel: viewModel.updateState(isEnabled: self.isEnabled), rating: self.rating, configuration: self.configuration)
    }

    // MARK: - Internal functions
    /// This function is just exposed for testing
    internal func highlighted(_ isHiglighed: Bool) -> Self {
        self.viewModel.updateState(isPressed: isHiglighed)
        return self
    }
}

// MARK: - Internal Rating Input
struct RatingInputInternalView: View {

    // MARK: - Private variables
    @ObservedObject private var viewModel: RatingDisplayViewModel
    @State private var displayRating: CGFloat
    @Binding private var rating: CGFloat
    @ScaledMetric private var scaleFactor: CGFloat = 1.0
    private let configuration: StarConfiguration

    // MARK: - Initialization
    /// Create a rating display view with the following parameters
    /// - Parameters:
    ///   - viewModel: The view model of the view.
    ///   - rating: A binding containg the rating value. This should be a value within the range 0...5
    ///   - configuration: A configuration of the star
    init(
        viewModel: RatingDisplayViewModel,
        rating: Binding<CGFloat>,
        configuration: StarConfiguration
    ) {
        self._rating = rating
        self._displayRating = State(initialValue: rating.wrappedValue)
        self.configuration = configuration
        self.viewModel = viewModel
    }

    // MARK: - View
    var body: some View {
        let size = self.viewModel.ratingSize.height * self.scaleFactor
        let lineWidth = self.viewModel.ratingSize.borderWidth * self.scaleFactor
        let spacing = self.viewModel.ratingSize.spacing * self.scaleFactor
        let width = size * CGFloat(self.viewModel.count.rawValue) + spacing * CGFloat(self.viewModel.count.maxIndex)
        let viewRect = CGRect(x: 0, y: 0, width: width, height: size)
        let colors = self.viewModel.colors

        HStack(spacing: spacing) {
            ForEach((0...self.viewModel.count.maxIndex), id: \.self) { index in
                StarView(
                    rating: self.displayRating - CGFloat(index),
                    fillMode: .full,
                    lineWidth: lineWidth,
                    borderColor: colors.strokeColor.color,
                    fillColor: colors.fillColor.color,
                    configuration: self.configuration
                )
                .frame(
                    width: size,
                    height: size
                )
                .accessibilityIdentifier("\(RatingInputAccessibilityIdentifier.identifier)-\(index)")
            }
        }
        .compositingGroup()
        .opacity(colors.opacity)
        .gesture(self.dragGesture(viewRect: viewRect))
        .frame(width: width, height: size)
        .accessibilityIdentifier(RatingInputAccessibilityIdentifier.identifier)
        .accessibilityElement()
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                guard self.displayRating <= CGFloat(self.viewModel.count.maxIndex) else { break }
                self.displayRating += 1
            case .decrement:
                guard self.displayRating > 1 else { break }
                self.displayRating -= 1
            @unknown default:
                break
            }
            self.rating = self.displayRating
        }
        .accessibilityValue(self.displayRating.description)
    }

    // MARK: - Private functions
    private func dragGesture(viewRect: CGRect) -> some Gesture {
        DragGesture(minimumDistance: 0.0)
            .onChanged({ value in
                if let index = viewRect.pointIndex(of: value.location, horizontalSlices: self.viewModel.count.rawValue) {
                    self.displayRating = CGFloat(index + 1)
                    self.viewModel.updateState(isPressed: true)
                } else {
                    self.displayRating = self._rating.wrappedValue
                    self.viewModel.updateState(isPressed: false)
                }
            })
            .onEnded({ value in
                if let index = viewRect.pointIndex(of: value.location, horizontalSlices: self.viewModel.count.rawValue) {
                    self.rating = CGFloat(index + 1)
                    self.displayRating = CGFloat(index + 1)
                } else {
                    self.displayRating = self._rating.wrappedValue
                }
                self.viewModel.updateState(isPressed: false)
            })
    }
}

private extension RatingStarsCount {
    var maxIndex: Int {
        return rawValue - 1
    }
}
