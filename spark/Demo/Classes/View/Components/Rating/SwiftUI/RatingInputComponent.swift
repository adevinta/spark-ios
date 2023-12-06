//
//  RatingInputComponentView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 07.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import SwiftUI

struct RatingInputComponent: View {

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var ratingSize: RatingDisplaySize = .medium
    @State private var rating: CGFloat = 2.0

    var body: some View {
        Component(
            name: "Rating Display Item",
            configuration: {
                ThemeSelector(theme: self.$theme)
            },
            integration: {
                VStack {
                    RatingInputView(
                        theme: self.theme,
                        intent: .main,
                        rating: self.$rating
                    )

                    Text("Current Rating \(self.rating)")
                }
            }
        )
    }
}

#Preview {
    RatingInputComponent()
}
