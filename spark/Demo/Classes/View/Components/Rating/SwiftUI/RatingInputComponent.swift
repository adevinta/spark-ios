//
//  RatingInputComponentView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 07.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SwiftUI

struct RatingInputComponent: View {

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var ratingSize: RatingDisplaySize = .medium
    @State private var rating: CGFloat = 2.0
    @State private var isEnabled = CheckboxSelectionState.selected

    var body: some View {
        Component(
            name: "Rating Input (SwiftUI)",
            configuration: {
                ThemeSelector(theme: self.$theme)

                CheckboxView(
                    text: "Is Enabled",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$isEnabled
                )
            },
            integration: {
                VStack {
                    RatingInputView(
                        theme: self.theme,
                        intent: .main,
                        rating: self.$rating
                    )
                    .disabled(self.isEnabled != .selected)

                    Text("Current Rating \(String(format: "%.1f", self.rating))")
                }
            }
        )
    }
}

#Preview {
    RatingInputComponent()
}
