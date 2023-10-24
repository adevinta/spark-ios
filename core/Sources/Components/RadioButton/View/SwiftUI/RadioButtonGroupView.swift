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
/// The radio button group is created by providing:
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
    private let items: [RadioButtonItem<ID>]
    private let title: String?
    private let groupLayout: RadioButtonGroupLayout
    private let alignment: RadioButtonLabelAlignment
    private let supplementaryLabel: String?
    private let viewModel: RadioButtonGroupViewModel

    // MARK: - Local properties

    @ScaledMetric private var spacing: CGFloat
    @ScaledMetric private var titleSpacing: CGFloat

    // MARK: - Initialization

    /// - Parameters
    ///   - theme: The theme defining colors and layout options.
    ///   - title: An option string. The title is rendered above the radio button items, if it is not empty.
    ///   - selectedID: a binding to the selected value.
    ///   - items: A list of ``RadioButtonItem``
    @available(*, deprecated, message: "Use init with intent instead.")
    public init(theme: Theme,
                title: String? = nil,
                selectedID: Binding<ID>,
                items: [RadioButtonItem<ID>],
                radioButtonLabelPosition: RadioButtonLabelPosition = .right,
                groupLayout: RadioButtonGroupLayout = .vertical,
                state: RadioButtonGroupState = .enabled,
                supplementaryLabel: String? = nil
    ) {
        self.init(theme: theme,
                  intent: state.intent,
                  title: title,
                  selectedID: selectedID,
                  items: items,
                  alignment: radioButtonLabelPosition.alignment,
                  groupLayout: groupLayout,
                  supplementaryLabel: supplementaryLabel
        )
        self.viewModel.isDisabled = state == .disabled
    }

    /// - Parameters
    ///   - theme: The theme defining colors and layout options.
    ///   - title: An option string. The title is rendered above the radio button items, if it is not empty.
    ///   - selectedID: a binding to the selected value.
    ///   - items: A list of ``RadioButtonItem``
    public init(theme: Theme,
                intent: RadioButtonIntent,
                title: String? = nil,
                selectedID: Binding<ID>,
                items: [RadioButtonItem<ID>],
                alignment: RadioButtonLabelAlignment = .trailing,
                groupLayout: RadioButtonGroupLayout = .vertical,
                supplementaryLabel: String? = nil
    ) {
        self.items = items
        self.selectedID = selectedID
        self.title = title
        self.groupLayout = groupLayout
        self.alignment = alignment
        self.supplementaryLabel = supplementaryLabel
        self.viewModel = RadioButtonGroupViewModel(theme: theme, intent: intent)
        self._spacing = ScaledMetric(wrappedValue: self.viewModel.spacing)
        self._titleSpacing = ScaledMetric(wrappedValue: self.viewModel.labelSpacing)
    }

    // MARK: - Content

    public var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            if let title = self.title {
                radioButtonTitle(title)
                    .padding(.bottom, self.titleSpacing)
            }

            if groupLayout == .vertical {
                radioButtonItems
            } else {
                horizontalRadioButtons
            }

            if let supplementaryLabel = self.supplementaryLabel {
                radioButtonSublabel(supplementaryLabel)
                    .padding(.top, self.titleSpacing)
            }
        }
    }

    public func theme(_ theme: Theme) -> Self {
        self.viewModel.theme = theme
        return self
    }

    @ViewBuilder
    private func radioButtonTitle(_ title: String) -> some View {
        Text(title)
            .fixedSize(horizontal: false, vertical: true)
            .font(self.viewModel.titleFont.font)
            .foregroundColor(self.viewModel.titleColor.color)
    }

    @ViewBuilder
    private func radioButtonSublabel(_ label: String) -> some View {
        Text(label)
            .font(self.viewModel.sublabelFont.font)
            .foregroundColor(self.viewModel.sublabelColor.color)
    }

    @ViewBuilder
    private var horizontalRadioButtons: some View {
        HStack(alignment: .top, spacing: self.spacing) {
            radioButtonItems
        }
    }

    @ViewBuilder
    private var radioButtonItems: some View {
        ForEach(self.items, id: \.id) { item in
            RadioButtonView(
                theme: self.viewModel.theme,
                intent: self.viewModel.intent, id: item.id,
                label: item.label,
                selectedID: self.selectedID,
                alignment: self.alignment
            )
            .disabled(self.viewModel.isDisabled)
            .accessibilityIdentifier(RadioButtonAccessibilityIdentifier.radioButtonIdentifier(id: item.id))
            .padding(.bottom, self.bottomPadding(of: item))
        }
    }

    private func bottomPadding(of item: RadioButtonItem<ID>) -> CGFloat {
        if item.id == items.last?.id {
            return 0
        } else {
            return self.viewModel.spacing
        }
    }
}
