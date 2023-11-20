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
            self.ratingSize = self.spacingUseCase.execute(spacing: theme.layout.spacing, size: size)
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
            self.ratingSize = self.spacingUseCase.execute(spacing: theme.layout.spacing, size: size)
        }
    }

    var count: RatingStarsCount {
        didSet {
            guard self.count != oldValue else { return }
            self.updateRatingValue()
        }
    }

    var rating: CGFloat {
        didSet {
            guard self.rating != oldValue else { return }
            self.updateRatingValue()
        }
    }

    @Published var colors: RatingColors
    @Published var ratingSize: RatingSizeAttributes
    @Published var ratingValue: CGFloat

    private let colorsUseCase: RatingGetColorsUseCaseable
    private let spacingUseCase: RatingSizeAttributesUseCaseable

    init(theme: Theme, 
         intent: RatingIntent,
         size: RatingDisplaySize,
         count: RatingStarsCount,
         rating: CGFloat,
         colorsUseCase: RatingGetColorsUseCaseable = RatingGetColorsUseCase(),
         spacingUseCase: RatingSizeAttributesUseCaseable = RatingSizeAttributesUseCase()
    ) {
        self.theme = theme
        self.intent = intent
        self.size = size
        self.colorsUseCase = colorsUseCase
        self.colors = colorsUseCase.execute(theme: theme, intent: intent, state: .standard)
        self.spacingUseCase = spacingUseCase
        self.ratingSize = spacingUseCase.execute(spacing: theme.layout.spacing, size: size)
        self.ratingValue = count.ratingValue(rating)
        self.rating = rating
        self.count = count
    }

    private func updateRatingValue() {
        self.ratingValue = self.count.ratingValue(self.rating)
    }
}

private extension RatingStarsCount {
    func ratingValue(_ rating: CGFloat) -> CGFloat {
        switch self {
        case .five: return rating
        case .one: return rating / 5.0
        }
    }
}
