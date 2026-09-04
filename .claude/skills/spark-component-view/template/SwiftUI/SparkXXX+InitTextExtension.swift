//
//  SparkXXX+InitTextExtension.swift
//  SparkComponentXXX
//
//  Created by robin.lemaire on 11/02/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkCommon

public extension SparkXXX {

    /// Create a rating with a value and a text positioned on the right.
    ///
    /// - Parameters:
    ///   - value: The Double value.
    ///   Must be between **0 and 5**.
    ///   - text: The text that describes the purpose of the rating.
    ///
    /// ## Example of usage
    ///
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///
    ///     var body: some View {
    ///         SparkXXX(
    ///             value: 2.75,
    ///             text: "2,75"
    ///         )
    ///         .sparkTheme(self.theme)
    ///         .sparkXXXSize(.small)
    ///         .sparkXXXStars(.one)
    ///     }
    /// }
    /// ```
    ///
    /// ## Rendering
    ///
    /// ![XXX rendering.](rating_display_text.png)
    /// 
    init(
        value: Double,
        text: String
    ) where ValueLabel == Text, CountLabel == EmptyView, AdditionalLabel == EmptyView {
        self.init(
            value,
            valueLabel: { Text(text) },
            countLabel: { EmptyView() },
            additionalLabel: { EmptyView() }
        )
    }

    /// Creates a rating with a value and a value and count text.
    ///
    /// - Parameters:
    ///   - value: The Double value.
    ///   Must be between **0 and 5**.
    ///   - valueText: The text that displays the value.
    ///   - countText: The text that displays the count of reviews.
    ///   **Parentheses** is added **automatically**, do not add them.
    ///
    /// ## Example of usage
    ///
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///
    ///     var body: some View {
    ///         SparkXXX(
    ///             value: 4.5,
    ///             valueText: "4,5",
    ///             countText: "120"
    ///         )
    ///         .sparkTheme(self.theme)
    ///         .sparkXXXSize(.medium)
    ///         .sparkXXXStars(.five)
    ///     }
    /// }
    /// ```
    ///
    /// ## Rendering
    ///
    /// ![XXX rendering.](rating_display_value_and_count_text.png)
    ///
    init(
        value: Double,
        valueText: String,
        countText: String
    ) where ValueLabel == Text, CountLabel == Text, AdditionalLabel == EmptyView {
        self.init(
            value,
            countAccessibilityLabel: .accessibilityLabelDisplayCount(text: countText),
            valueLabel: { Text(valueText) },
            countLabel: { Text(countText.addParentheses) },
            additionalLabel: { EmptyView() }
        )
    }

    /// Creates a rating with a value, value text, and additional text.
    ///
    /// - Parameters:
    ///   - value: The Double value.
    ///   Must be between **0 and 5**.
    ///   - valueText: The text that displays the value.
    ///   - additionalText: The text that provides additional information.
    ///
    /// ## Example of usage
    ///
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///
    ///     var body: some View {
    ///         SparkXXX(
    ///             value: 4.5,
    ///             valueText: "4,5",
    ///             additionalText: "Excellent"
    ///         )
    ///         .sparkTheme(self.theme)
    ///         .sparkXXXSize(.medium)
    ///         .sparkXXXStars(.five)
    ///     }
    /// }
    /// ```
    ///
    /// ## Rendering
    ///
    /// ![XXX rendering.](rating_display_value_and_additional_text.png)
    ///
    init(
        value: Double,
        valueText: String,
        additionalText: String
    ) where ValueLabel == Text, CountLabel == EmptyView, AdditionalLabel == Text {
        self.init(
            value,
            valueLabel: { Text(valueText) },
            countLabel: { EmptyView() },
            additionalLabel: { Text(additionalText) }
        )
    }

    /// Creates a rating with a value, value text, count text, and additional text.
    ///
    /// - Parameters:
    ///   - value: The Double value.
    ///   Must be between **0 and 5**.
    ///   - valueText: The text that displays the value.
    ///   - countText: The text that displays the count of reviews.
    ///   **Parentheses** is added **automatically**, do not add them.
    ///   - additionalText: The text that provides additional information.
    ///
    /// ## Example of usage
    ///
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///
    ///     var body: some View {
    ///         SparkXXX(
    ///             value: 4.5,
    ///             valueText: "4.5",
    ///             countText: "120",
    ///             additionalText: "Excellent"
    ///         )
    ///         .sparkTheme(self.theme)
    ///         .sparkXXXSize(.medium)
    ///         .sparkXXXStars(.five)
    ///     }
    /// }
    /// ```
    ///
    /// ## Rendering
    ///
    /// ![XXX rendering.](rating_display_all_text.png)
    init(
        value: Double,
        valueText: String,
        countText: String,
        additionalText: String
    ) where ValueLabel == Text, CountLabel == Text, AdditionalLabel == Text {
        self.init(
            value,
            countAccessibilityLabel: .accessibilityLabelDisplayCount(text: countText),
            valueLabel: { Text(valueText) },
            countLabel: { Text(countText.addParentheses) },
            additionalLabel: { Text(additionalText) }
        )
    }
}
