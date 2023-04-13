//
//  SparkCheckboxGroupView.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 06.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct SparkCheckboxGroupView: View {

    // MARK: - Type Alias

    private typealias AccessibilityIdentifier = SparkCheckboxAccessibilityIdentifier

    // MARK: - Private properties

    @Binding private var items: [any SparkCheckboxGroupItemProtocol]
    private var theming: SparkCheckboxTheming
    private var layout: SparkCheckboxGroupLayout
    private var checkboxPosition: SparkCheckboxView.CheckboxPosition
    private var accessibilityIdentifierPrefix: String

    // MARK: - Initialization

    public init(
        items: Binding<[any SparkCheckboxGroupItemProtocol]>,
        layout: SparkCheckboxGroupLayout = .vertical,
        checkboxPosition: SparkCheckboxView.CheckboxPosition,
        theming: SparkCheckboxTheming,
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
        if layout == .horizontal{
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
            SparkCheckboxView(
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
