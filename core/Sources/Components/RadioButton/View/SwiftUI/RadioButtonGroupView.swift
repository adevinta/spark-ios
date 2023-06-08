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
    private let groupLayout: RadioButtonGroupLayout
    private let radioButtonLabelPosition: RadioButtonLabelPosition

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
                items: [RadioButtonItem<ID>],
                radioButtonLabelPosition: RadioButtonLabelPosition = .right,
                groupLayout: RadioButtonGroupLayout = .vertical) {
        self.theme = theme
        self.items = items
        self.selectedID = selectedID
        self.title = title
        self.groupLayout = groupLayout
        self.radioButtonLabelPosition = radioButtonLabelPosition
        self._spacing = ScaledMetric(wrappedValue: theme.layout.spacing.xLarge)
    }

    // MARK: - Content

    public var body: some View {

        if let title = self.title {
            VStack(alignment: .leading, spacing: self.spacing) {
                radioButtonTitle(title)

                if self.groupLayout == .vertical {
                    radioButtonItems
                } else {
                    horizontalRadioButtons
                }
            }
        } else if groupLayout == .vertical {
            verticalRadioButtons
        } else {
            horizontalRadioButtons
        }
    }

    @ViewBuilder
    private func radioButtonTitle(_ title: String) -> some View {
        Text(title)
            .font(self.theme.typography.subhead.font)
            .foregroundColor(self.theme.colors.base.onSurface.color)
    }

    @ViewBuilder
    private var horizontalRadioButtons: some View {
        HStack(alignment: .top, spacing: self.spacing) {
            radioButtonItems
        }
    }

    @ViewBuilder
    private var verticalRadioButtons: some View {
        VStack(alignment: .leading, spacing: self.spacing) {
            radioButtonItems
        }
    }

    @ViewBuilder
    private var radioButtonItems: some View {
        ForEach(items, id: \.id) { item in
            RadioButtonView(
                theme: theme,
                id: item.id,
                label: item.label,
                selectedID: self.selectedID,
                state: item.state,
                labelPosition: self.radioButtonLabelPosition
            )
            .accessibilityIdentifier(RadioButtonAccessibilityIdentifier.radioButtonIdentifier(id: item.id))
        }
    }
}
