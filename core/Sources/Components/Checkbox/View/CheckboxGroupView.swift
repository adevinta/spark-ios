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

    @Binding private var items: [any CheckboxGroupItemProtocol]
    private var theming: CheckboxTheming
    private var layout: CheckboxGroupLayout
    private var checkboxPosition: CheckboxPosition
    private var accessibilityIdentifierPrefix: String

    // MARK: - Initialization

    public init(
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        checkboxPosition: CheckboxPosition,
        theming: CheckboxTheming,
        accessibilityIdentifierPrefix: String
    ) {
        self._items = items
        self.layout = layout
        self.checkboxPosition = checkboxPosition
        self.theming = theming
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
    }

    public var body: some View {
        let spacing: CGFloat = 12
        if layout == .horizontal {
            HStack(alignment: .top, spacing: spacing) {
                contentView
            }
        } else {
            VStack(alignment: .leading, spacing: spacing - 4) {
                contentView
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
}
