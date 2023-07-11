//
//  SpinnerViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation

private enum Constants {
    static let small = 20.0
    static let medium = 28.0
    static let stroke = 2.0
    static let duration = 1.0
}

/// `SpinnerViewModel` is the view model for both the SwiftUI `SpinnerView` as well as the UIKit `SpinnerUIView`.
/// The view model is responsible for returning the varying attributes to the views, i.e. colors and size. These are determined by the theme, intent and spinnerSize.
/// When the theme or the intent change the new values are calculated and published.
final class SpinnerViewModel: ObservableObject {

    // MARK: - Private attributes
    private let useCase: any GetSpinnerIntentColorUseCasable

    // MARK: - Public attribues
    var theme: Theme {
        didSet {
            self.intentColor = self.useCase.execute(colors: theme.colors, intent: intent)
        }
    }

    var intent: SpinnerIntent {
        didSet {
            guard self.intent != oldValue else { return }
            self.intentColor = self.useCase.execute(colors: theme.colors, intent: intent)
        }
    }

    var spinnerSize: SpinnerSize {
        didSet {
            guard self.spinnerSize != oldValue else { return }
            self.size = self.spinnerSize.numeric
        }
    }

    let duration = Constants.duration
    let strokeWidth = Constants.stroke

    // MARK: Published attribues
    @Published var size: CGFloat
    @Published var intentColor: any ColorToken
    @Published var isSpinning: Bool = false

    // MARK: Init
    /// Init
    /// Parameters:
    /// - theme: the current `Theme`
    /// - intent: the `SpinnerIntent`, which will determine the color of the spinner
    /// - spinnerSize: the `SpinnerSize`
    /// - userCase: `GetSpinnerIntentColorUseCasable` has a default value `GetSpinnerIntentColorUseCase`
    init(theme: Theme,
         intent: SpinnerIntent,
         spinnerSize: SpinnerSize,
         useCase: any GetSpinnerIntentColorUseCasable = GetSpinnerIntentColorUseCase()) {
        self.theme = theme
        self.intent = intent
        self.spinnerSize = spinnerSize
        self.useCase = useCase
        self.size = spinnerSize.numeric
        self.intentColor = useCase.execute(colors: theme.colors, intent: intent)
    }
}

// MARK: - Private helpers
private extension SpinnerSize {
    var numeric: CGFloat {
        switch self {
        case .small: return Constants.small
        case .medium: return Constants.medium
        }
    }
}
