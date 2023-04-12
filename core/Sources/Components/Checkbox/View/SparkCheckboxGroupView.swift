//
//  SparkCheckboxGroupView.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 06.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct SparkCheckboxGroupView: View {

    @Binding var items: [any SparkCheckboxItemProtocol]
    var theming: SparkCheckboxTheming
    var layout: SparkCheckboxGroupLayout
    var checkboxPosition: SparkCheckboxView.CheckboxPosition

    public init(
        items: Binding<[any SparkCheckboxItemProtocol]>,
        layout: SparkCheckboxGroupLayout = .vertical,
        checkboxPosition: SparkCheckboxView.CheckboxPosition,
        theming: SparkCheckboxTheming
    ) {
        self._items = items
        self.layout = layout
        self.checkboxPosition = checkboxPosition
        self.theming = theming
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
            SparkCheckboxView(
                text: item.title.wrappedValue,
                checkboxPosition: checkboxPosition,
                theming: theming,
                state: item.state.wrappedValue,
                selectionState: item.selectionState
            )
        }
    }
}

public protocol SparkCheckboxItemProtocol: Hashable {
    var title: String { get set }
    var id: String { get }

    var selectionState: SparkCheckboxSelectionState { get set }
    var state: SparkSelectButtonState { get set }
}
