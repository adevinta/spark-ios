//
//  CheckboxGroupView.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 06.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// The `CheckboxGroupView` renders a group containing of multiple`CheckboxView`-views. It supports a title, different layout and positioning options.
public struct CheckboxGroupView: View {

    // MARK: - Private properties

    @Binding private var items: [any CheckboxGroupItemProtocol]
    private var theme: Theme
    private var layout: CheckboxGroupLayout
    private var checkboxPosition: CheckboxView.CheckboxPosition
    private var accessibilityIdentifierPrefix: String

    // MARK: - Initialization

    /// Initialize a group of one or multiple checkboxes.
    /// - Parameters:
    ///   - items: An array containing of multiple `CheckboxGroupItemProtocol`. Each array item is used to render a single checkbox.
    ///   - layout: The layout of the group can be horizontal or vertical.
    ///   - checkboxPosition: The checkbox is positioned on the leading or trailing edge of the view.
    ///   - theme: The Spark-Theme.
    ///   - accessibilityIdentifierPrefix: All checkbox-views are prefixed by this identifier followed by the `CheckboxGroupItemProtocol`-identifier.
    public init(
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        checkboxPosition: CheckboxView.CheckboxPosition,
        theme: Theme,
        accessibilityIdentifierPrefix: String
    ) {
        self._items = items
        self.layout = layout
        self.checkboxPosition = checkboxPosition
        self.theme = theme
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
    }

    // MARK: - Body

    /// Returns the rendered checkbox group view.
    public var body: some View {
        let spacing: CGFloat = 12
        switch self.layout {
        case .horizontal:
            HStack(alignment: .top, spacing: spacing) {
                self.contentView
            }
        case .vertical:
            VStack(alignment: .leading, spacing: spacing - 4) {
                self.contentView
            }
        }
    }

    private var contentView: some View {
        ForEach(self.$items, id: \.id) { item in
            let identifier = "\(self.accessibilityIdentifierPrefix).\(item.id.wrappedValue)"
            CheckboxView(
                text: item.title.wrappedValue,
                checkboxPosition: checkboxPosition,
                theme: theme,
                state: item.state.wrappedValue,
                selectionState: item.selectionState
            )
            .accessibilityIdentifier(identifier)
        }
    }
}
