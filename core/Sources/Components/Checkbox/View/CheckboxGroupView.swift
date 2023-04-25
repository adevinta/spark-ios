//
//  CheckboxGroupView.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 06.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct CheckboxGroupView: View {

    // MARK: - Type Alias

    private typealias AccessibilityIdentifier = CheckboxAccessibilityIdentifier

    // MARK: - Private properties

    private var title: String
    @Binding private var items: [any CheckboxGroupItemProtocol]
    private var theming: CheckboxTheming
    private var layout: CheckboxGroupLayout
    private var checkboxPosition: CheckboxPosition
    private var accessibilityIdentifierPrefix: String

    // MARK: - Initialization

    public init(
        title: String? = nil,
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        checkboxPosition: CheckboxPosition,
        theming: CheckboxTheming,
        accessibilityIdentifierPrefix: String
    ) {
        self.title = title ?? ""
        self._items = items
        self.layout = layout
        self.checkboxPosition = checkboxPosition
        self.theming = theming
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
    }

    public var body: some View {
        let spacing: CGFloat = spacing.xLarge / 2

        VStack(alignment: .leading, spacing: 0) {
            // Title will be refactored once we have a custom label component.
            if !title.isEmpty {
                Text(title)
                    .foregroundColor(theming.theme.colors.base.onSurface.color)
                    .font(theming.theme.typography.subhead.font)
                    .padding(.bottom, theming.theme.layout.spacing.medium)
            }

            if layout == .horizontal {
                HStack(alignment: .top, spacing: spacing) {
                    contentView
                }
            } else {
                VStack(alignment: .leading, spacing: spacing - self.spacing.small) {
                    contentView
                }
            }
        }
    }

    private var contentView: some View {
        ForEach($items, id: \.id) { item in
            let identifier = "\(accessibilityIdentifierPrefix).\(item.id.wrappedValue)"
            CheckboxView(
                text: item.title.wrappedValue,
                checkboxPosition: checkboxPosition,
                theming: theming,
                state: item.state.wrappedValue,
                selectionState: item.selectionState,
                accessibilityIdentifier: identifier
            )
        }
    }

    private var spacing: LayoutSpacing {
        theming.theme.layout.spacing
    }
}
