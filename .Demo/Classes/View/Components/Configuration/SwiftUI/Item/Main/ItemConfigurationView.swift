//
//  ItemConfigurationView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

struct ItemConfigurationView<Item: View>: View {

    // MARK: - Properties

    let name: String?
    let spacing: Spacing
    var item: () -> Item

    // MARK: - Initialization

    init(
        name: String?,
        spacing: Spacing = .none,
        @ViewBuilder item: @escaping () -> Item
    ) {
        self.item = item
        self.spacing = spacing
        self.name = name
    }

    // MARK: - View

    var body: some View {
        HStack(alignment: .center, spacing: self.spacing) {
            if let name {
                Text("\(name.capitalized)").bold()
            }

            self.item()
        }
    }
}

#Preview {
    ItemConfigurationView(name: "Name", item: {
        Text("Your name")
    })
}
