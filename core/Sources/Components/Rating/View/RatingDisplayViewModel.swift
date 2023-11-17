//
//  RatingDisplayViewModel.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

final class RatingDisplayViewModel: ObservableObject {
    
    var theme: Theme {
        didSet {
            self.colors = self.colorsUseCase.execute(theme: self.theme, intent: self.intent)
        }
    }

    var intent: RatingIntent {
        didSet {
            guard self.intent != oldValue else { return }
            self.colors = self.colorsUseCase.execute(theme: self.theme, intent: self.intent)
        }
    }

    var size: RatingDisplaySize {
        didSet {
            guard self.size != oldValue else { return }
            self.ratingSize = self.size.sizeAttributes
        }
    }

    @Published var colors: RatingColors
    @Published var spacing: CGFloat
    @Published var ratingSize: RatingSizeAttributes

    private let colorsUseCase: RatingGetColorsUseCase

    init(theme: Theme, 
         intent: RatingIntent,
         size: RatingDisplaySize,
         colorsUseCase: RatingGetColorsUseCase = RatingGetColorsUseCase()
    ) {
        self.theme = theme
        self.intent = intent
        self.size = size
        self.colorsUseCase = colorsUseCase
        self.colors = colorsUseCase.execute(theme: theme, intent: intent)
        self.spacing = theme.layout.spacing.small
        self.ratingSize = size.sizeAttributes
    }
}

private extension RatingDisplaySize {
    var sizeAttributes: RatingSizeAttributes {
        switch self {
        case .small: return .init(borderWidth: 1.0, height: self.height)
        case .medium: return .init(borderWidth: 1.33, height: self.height)
        case .input: return .init(borderWidth: 3.33, height: self.height)
        }
    }

    var height: CGFloat {
        return CGFloat(self.rawValue)
    }
}
