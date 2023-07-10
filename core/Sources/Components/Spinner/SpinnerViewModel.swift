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

final class SpinnerViewModel: ObservableObject {

    private let useCase: any GetSpinnerIntentColorUseCasable

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

    @Published var size: CGFloat
    @Published var intentColor: any ColorToken
    @Published var isSpinning: Bool = false
    let duration = Constants.duration

    let strokeWidth = Constants.stroke

    init(theme: Theme,
         intent: SpinnerIntent,
         spinnerSize: SpinnerSize,
         userCase: any GetSpinnerIntentColorUseCasable = GetSpinnerIntentColorUseCase()) {
        self.theme = theme
        self.intent = intent
        self.spinnerSize = spinnerSize
        self.useCase = userCase
        self.size = spinnerSize.numeric
        self.intentColor = userCase.execute(colors: theme.colors, intent: intent)
    }
}

private extension SpinnerSize {
    var numeric: CGFloat {
        switch self {
        case .small: return Constants.small
        case .medium: return Constants.medium
        }
    }
}
