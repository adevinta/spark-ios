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

    public init(
        items: Binding<[any SparkCheckboxItemProtocol]>,
        theming: SparkCheckboxTheming
    ) {
        self._items = items
        self.theming = theming
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach($items, id: \.id) { item in
                SparkCheckboxView(
                    text: item.title.wrappedValue,
                    theming: theming,
                    state: item.state.wrappedValue,
                    selectionState: item.selectionState
                )
            }
        }
    }
}

public protocol SparkCheckboxItemProtocol: Hashable {
    var title: String { get set }
    var id: String { get }

    var selectionState: SparkCheckboxSelectionState { get set }
    var state: SparkSelectButtonState { get set }
}
