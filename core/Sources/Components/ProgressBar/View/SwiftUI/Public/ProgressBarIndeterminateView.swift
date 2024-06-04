//
//  ProgressBarIndeterminateView.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Combine
@_spi(SI_SPI) import SparkCommon
import SparkTheming

public struct ProgressBarIndeterminateView: View {

    // MARK: - Type alias

    private typealias AccessibilityIdentifier = ProgressBarAccessibilityIdentifier
    private typealias Constants = ProgressBarConstants

    // MARK: - Properties

    @ObservedObject var viewModel: ProgressBarIndeterminateViewModel
    @State private var animationStepTimer = Self.createTimer()
    @State private var width: CGFloat = .zero

    // MARK: - Initialization

    /// Initialize a new progress bar indeterminate view
    /// - Parameters:
    ///   - theme: The spark theme of the progress bar indeterminate.
    ///   - intent: The intent of the progress bar indeterminate.
    ///   - shape: The shape of the progress bar indeterminate.
    ///   - isAnimating: Animate or not the progress bar indeterminate.
    public init(
        theme: any Theme,
        intent: ProgressBarIntent,
        shape: ProgressBarShape,
        isAnimating: Bool
    ) {
        self.viewModel = .init(
            for: .swiftUI,
            theme: theme,
            intent: intent,
            shape: shape,
            isAnimating: isAnimating
        )
    }

    // MARK: - View

    public var body: some View {
        ProgressBarContentView(
            trackCornerRadius: self.viewModel.cornerRadius,
            trackBackgroundColor: self.viewModel.colors?.trackBackgroundColorToken,
            indicatorView: {
                GeometryReader { geometryReader in
                    RoundedRectangle(cornerRadius: self.viewModel.cornerRadius ?? 0)
                        .fill(self.viewModel.colors?.indicatorBackgroundColorToken)
                        .frame(width: self.viewModel.animatedData?.indicatorWidth ?? 0)
                        .offset(x: self.viewModel.animatedData?.leadingSpaceWidth ?? 0)
                        .opacity(self.viewModel.indicatorOpacity ?? 0)
                        .accessibilityIdentifier(AccessibilityIdentifier.indicatorView)
                        .onAppear {
                            self.width = geometryReader.size.width
                        }
                        .onChange(of: geometryReader.size) { newSize in
                            self.width = newSize.width
                        }
                }
            }
        )
        .onReceive(self.viewModel.$animationType) { type in
            let animation: Animation?
            switch type {
            case .easeIn:
                animation = .easeIn(duration: Constants.Animation.duration)
            case .easeOut:
                animation = .easeOut(duration: Constants.Animation.duration)
            default:
                animation = .none
            }

            withAnimation(animation) {
                self.viewModel.updateAnimatedData(
                    from: self.width
                )
            }
        }
        .onReceive(self.animationStepTimer) { time in
            self.viewModel.animationStepIsDone()
        }
        .onReceive(self.viewModel.$animationStatus) { status in
            switch status {
            case .start:
                self.animationStepTimer = Self.createTimer()
            case .stop:
                self.animationStepTimer.upstream.connect().cancel()
            case .none:
                break
            }
        }
    }

    // MARK: - Timer

    private static func createTimer() -> Publishers.Autoconnect<Timer.TimerPublisher> {
        return Timer.publish(
            every: Constants.Animation.duration,
            on: .main,
            in: .common
        ).autoconnect()
    }
}
