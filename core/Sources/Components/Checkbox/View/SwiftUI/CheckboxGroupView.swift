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
    private var checkedImage: UIImage
    @Binding private var items: [any CheckboxGroupItemProtocol]
    private var theme: Theme
    private var layout: CheckboxGroupLayout
    private var checkboxPosition: CheckboxPosition
    private var accessibilityIdentifierPrefix: String

    @ScaledMetric private var spacingSmall: CGFloat
    @ScaledMetric private var spacingXLarge: CGFloat

    // MARK: - Initialization

    /// Initialize a group of one or multiple checkboxes.
    /// - Parameters:
    ///   - title: An optional group title displayed on top of the checkbox group..
    ///   - checkedImage: The tick-checkbox image for checked-state.
    ///   - items: An array containing of multiple `CheckboxGroupItemProtocol`. Each array item is used to render a single checkbox.
    ///   - layout: The layout of the group can be horizontal or vertical.
    ///   - checkboxPosition: The checkbox is positioned on the leading or trailing edge of the view.
    ///   - theme: The Spark-Theme.
    ///   - accessibilityIdentifierPrefix: All checkbox-views are prefixed by this identifier followed by the `CheckboxGroupItemProtocol`-identifier.
    public init(
        title: String? = nil,
        checkedImage: UIImage,
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        checkboxPosition: CheckboxPosition,
        theme: Theme,
        accessibilityIdentifierPrefix: String
    ) {
        self.title = title ?? ""
        self.checkedImage = checkedImage
        self._items = items
        self.layout = layout
        self.checkboxPosition = checkboxPosition
        self.theme = theme
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix

        self._spacingSmall = .init(wrappedValue: theme.layout.spacing.small)
        self._spacingXLarge = .init(wrappedValue: theme.layout.spacing.xLarge)
    }

    // MARK: - Body

    /// Returns the rendered checkbox group view.
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !self.title.isEmpty {
                Text(self.title)
                    .foregroundColor(self.theme.colors.base.onSurface.color)
                    .font(self.theme.typography.subhead.font)
                    .padding(.bottom, self.spacingXLarge - self.spacingSmall)
            }

            let spacing = self.spacingXLarge - self.spacingSmall * 2
            switch self.layout {
            case .horizontal:
                HStack(alignment: .top, spacing: spacing) {
                    self.contentView
                }
            case .vertical:
                VStack(alignment: .leading, spacing: spacing) {
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
                checkedImage: self.checkedImage,
                checkboxPosition: self.checkboxPosition,
                theme: self.theme,
                state: item.state.wrappedValue,
                selectionState: item.selectionState
            )
            .accessibilityIdentifier(identifier)
        }
    }

    private var spacing: LayoutSpacing {
        return self.theme.layout.spacing
    }
}
