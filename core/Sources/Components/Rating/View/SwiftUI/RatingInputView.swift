//
//  RatingInputView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 06.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct RatingInputView: View {

    @Environment(\.isEnabled) var isEnabled: Bool
    @ObservedObject private var viewModel: RatingDisplayViewModel

    @State private var displayRating: CGFloat
    @Binding private var rating: CGFloat
    @ScaledMetric private var scaleFactor: CGFloat = 1.0
    private let configuration: StarConfiguration

    // MARK: - Initialization
    /// Create a rating display view with the following parameters
    /// - Parameters:
    ///   - theme: The current theme
    ///   - intent: The intent to define the colors
    ///   - rating: The rating value. This should be a value within the range 0...5
    ///   - configuration: A configuration of the star. A default value is defined.
    public init(
        theme: Theme,
        intent: RatingIntent,
        rating: Binding<CGFloat>,
        configuration: StarConfiguration = .default
    ) {
        self._rating = rating
        self._displayRating = State(initialValue: rating.wrappedValue)
        self.configuration = configuration
        self.viewModel = RatingDisplayViewModel(
            theme: theme,
            intent: intent,
            size: .input,
            count: .five)
    }

    public var body: some View {
        let size = self.viewModel.ratingSize.height * self.scaleFactor
        let spacing = self.viewModel.ratingSize.spacing * self.scaleFactor
        let width = size * 5 + spacing * 4
        let viewRect = CGRect(x: 0, y: 0, width: width, height: size)
        let colors = self.viewModel.colors(isEnabled: self.isEnabled)

        HStack(spacing: spacing) {
            ForEach((0...4), id: \.self) { index in
                StarView(
                    rating: self.displayRating - CGFloat(index),
                    fillMode: .full,
                    lineWidth: self.viewModel.ratingSize.borderWidth * self.scaleFactor,
                    borderColor: colors.strokeColor.color,
                    fillColor: colors.fillColor.color,
                    configuration: self.configuration
                )
                .frame(
                    width: size,
                    height: size
                )
            }
        }
        .compositingGroup()
        .opacity(colors.opacity)
        .gesture(
            DragGesture(minimumDistance: 0.0)
                .onChanged({ value in
                    if let index = viewRect.pointIndex(of: value.location, with: 5) {
                        self.displayRating = CGFloat(index + 1)
                        self.viewModel.updateState(isPressed: true)
                    } else {
                        self.displayRating = self._rating.wrappedValue
                        self.viewModel.updateState(isPressed: false)
                    }
                })
                .onEnded({ value in
                    if let index = viewRect.pointIndex(of: value.location, with: 5) {
                        self.rating = CGFloat(index + 1)
                        self.displayRating = CGFloat(index + 1)
                    } else {
                        self.displayRating = self._rating.wrappedValue
                    }
                    self.viewModel.updateState(isPressed: false)
                })
        )
        .frame(width: width, height: size)
        .onAppear{
            self.viewModel.updateState(isEnabled: self.isEnabled)
        }
    }

}
