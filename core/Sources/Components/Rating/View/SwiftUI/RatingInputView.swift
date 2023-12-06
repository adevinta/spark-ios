//
//  RatingInputView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 06.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct RatingInputView: View {

    @ObservedObject private var viewModel: RatingDisplayViewModel

    @State private var starFrames: [CGRect] = .init(repeating: .zero, count: 5)
    @State private var viewRect: CGRect = .zero
    @State private var displayRating: CGFloat
    @Binding private var rating: CGFloat
    @ScaledMetric private var scaleFactor: CGFloat = 1.0
    @GestureState private var starPressed = false
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
        
        GeometryReader { viewGeometry in
            HStack(spacing: spacing) {
                ForEach((0...4), id: \.self) { index in
                    GeometryReader { geometry in
                            StarView(
                                rating: self.displayRating - CGFloat(index),
                                fillMode: .full,
                                lineWidth: self.viewModel.ratingSize.borderWidth * self.scaleFactor,
                                borderColor: self.viewModel.colors.strokeColor.color,
                                fillColor: self.viewModel.colors.fillColor.color,
                                configuration: self.configuration
                            )
                            .frame(
                                width: size,
                                height: size
                            )
                            .onAppear {
                                self.starFrames[index] = geometry.frame(in: .named("RatingInput"))
                            }
                    }
                }
            }
            .onAppear {
                self.viewRect = viewGeometry.frame(in: .local)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0.0)
                .onChanged({ value in
                    if !self.viewRect.contains(value.location) {
                        self.displayRating = self._rating.wrappedValue
                        self.viewModel.updateState(isPressed: false)
                    } else if let index = self.starFrames.index(closestTo: value.location) {
                        self.displayRating = CGFloat(index + 1)
                        self.viewModel.updateState(isPressed: true)
                    }
                })
                .onEnded({ value in
                    if !self.viewRect.contains(value.location) {
                        self.displayRating = self._rating.wrappedValue
                    } else if let index = self.starFrames.index(closestTo: value.location) {
                        self.rating = CGFloat(index + 1)
                        self.displayRating = CGFloat(index + 1)
                    }
                    self.viewModel.updateState(isPressed: false)
                })
        )
        .frame(width: width, height: size)
        .coordinateSpace(name: "RatingInput")
    }
}
