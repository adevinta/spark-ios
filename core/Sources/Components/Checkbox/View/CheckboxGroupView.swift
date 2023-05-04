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

    private var title: String
    @Binding private var items: [any CheckboxGroupItemProtocol]
    private var theming: Theme
    private var layout: CheckboxGroupLayout
    private var checkboxPosition: CheckboxPosition
    private var accessibilityIdentifierPrefix: String

    // MARK: - Initialization

    /// Initialize a group of one or multiple checkboxes.
    /// - Parameters:
    ///   - title: An optional group title displayed on top of the checkbox group..
    ///   - items: An array containing of multiple `CheckboxGroupItemProtocol`. Each array item is used to render a single checkbox.
    ///   - layout: The layout of the group can be horizontal or vertical.
    ///   - checkboxPosition: The checkbox is positioned on the leading or trailing edge of the view.
    ///   - theming: The Spark-Theme.
    ///   - accessibilityIdentifierPrefix: All checkbox-views are prefixed by this identifier followed by the `CheckboxGroupItemProtocol`-identifier.
    public init(
        title: String? = nil,
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        checkboxPosition: CheckboxPosition,
        theming: Theme,
        accessibilityIdentifierPrefix: String
    ) {
        self.title = title ?? ""
        self._items = items
        self.layout = layout
        self.checkboxPosition = checkboxPosition
        self.theming = theming
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
    }

    // MARK: - Body

    /// Returns the rendered checkbox group view.
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !self.title.isEmpty {
                Text(self.title)
                    .foregroundColor(self.theming.colors.base.onSurface.color)
                    .font(self.theming.typography.subhead.font)
                    .padding(.bottom, self.theming.layout.spacing.medium)
            }

            let horizontalSpacing = spacing.xLarge / 2
            switch self.layout {
            case .horizontal:
                HStack(alignment: .top, spacing: horizontalSpacing) {
                    self.contentView
                }
            case .vertical:
                VStack(alignment: .leading, spacing: horizontalSpacing - self.spacing.small) {
                    self.contentView
                }
            }
        }
    }

    private var contentView: some View {
        ForEach(self.$items, id: \.id) { item in
            let identifier = "\(self.accessibilityIdentifierPrefix).\(item.id.wrappedValue)"
            CheckboxView(
                text: item.title.wrappedValue,
                checkboxPosition: checkboxPosition,
                theming: self.theming,
                state: item.state.wrappedValue,
                selectionState: item.selectionState
            )
            .accessibilityIdentifier(identifier)
        }
    }

    private var spacing: LayoutSpacing {
        return self.theming.layout.spacing
    }
}
