//
//  RadioButtonGroupView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// RadioButtonGroupView is a radio button group control which renders a list of ``RadioButtonView``.
///
/// The radio buttion group is created by providing:
/// - A theme
/// - An option title. If the title is empty, no title will be rendered.
/// - The selectedID, a binding value.
/// - A list of ``RadioButtonItem``.
///
/// **Example**
/// ```swift
///    RadioButtonGroupView(
///       theme: self.theme,
///       title: "Radio Button Group",
///       selectedID: self.$selectedID,
///       items: [
///           RadioButtonItem(label: "Label 1", id: 1),
///           RadioButtonItem(label: "Label 2", id: 2)
///       ]
///    }
///  ```
public struct RadioButtonGroupView<ID: Equatable & Hashable & CustomStringConvertible> : View {

    // MARK: - Injected properties

    private var selectedID: Binding<ID>
    private let theme: Theme
    private let items: [RadioButtonItem<ID>]
    private let title: String?

    // MARK: - Local properties

    @ScaledMetric private var spacing: CGFloat
    @ScaledMetric private var titlePadding = RadioButtonConstants.radioButtonPadding

    // MARK: - Initialization

    /// - Parameters
    ///   - theme: The theme defining colors and layout options.
    ///   - title: An option string. The title is rendered above the radio button items, if it is not empty.
    ///   - selectedID: a binding to the selected value.
    ///   - items: A list of ``RadioButtonItem``
    public init(theme: Theme,
                title: String? = nil,
                selectedID: Binding<ID>,
                items: [RadioButtonItem<ID>]) {
        self.theme = theme
        self.items = items
        self.selectedID = selectedID
        self.title = title

        self._spacing = ScaledMetric(wrappedValue: theme.layout.spacing.xLarge - RadioButtonConstants.radioButtonPadding * 2)
    }

    // MARK: - Content

    public var body: some View {
        VStack(alignment: .leading, spacing: self.spacing) {
            if let title = self.title {
                Text(title)
                    .font(self.theme.typography.subhead.font)
                    .foregroundColor(self.theme.colors.base.onSurface.color)
                    .padding(.leading, self.titlePadding)
            }

            ForEach(items, id: \.id) { item in
                RadioButtonView(
                    theme: theme,
                    id: item.id,
                    label: item.label,
                    selectedID: self.selectedID,
                    state: item.state
                )
            }
        }
        .accessibilityIdentifier(RadioButtonAccessibilityIdentifier.radioButtonGroup)
    }
}
