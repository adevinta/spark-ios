//
//  RatingComponent.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 04.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import SwiftUI

struct RatingComponent: View {

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var ratingSize: RatingDisplaySize = .medium
    @State private var rating = 2
    @State private var numberOfStars: RatingStarsCount = .five

    private var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.multiplier = 0.5
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()

    var body: some View {
        Component(
            name: "Rating Display Item",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Size",
                    dialogTitle: "Select a size",
                    values: RatingDisplaySize.allCases,
                    value: self.$ratingSize
                )

                EnumSelector(
                    title: "Number of stars",
                    dialogTitle: "Select number",
                    values: RatingStarsCount.allCases,
                    value: self.$numberOfStars
                )

                RangeSelector(
                    title: "Rating",
                    range: 2...10,
                    selectedValue: self.$rating,
                    numberFormatter: self.numberFormatter
                )
            },
            integration: {
                RatingDisplayView(
                    theme: self.theme,
                    intent: .main,
                    count: self.numberOfStars,
                    size: self.ratingSize,
                    rating: CGFloat(self.rating) / 2
                )
            }
        )
    }
}

#Preview {
    RatingComponent()
}
