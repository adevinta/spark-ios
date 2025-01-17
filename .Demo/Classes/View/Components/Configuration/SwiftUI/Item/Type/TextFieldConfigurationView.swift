//
//  TextFieldConfigurationView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

struct TextFieldConfigurationView: View {

    // MARK: - Properties

    let name: String
    let text: Binding<String>

    // MARK: - View

    var body: some View {
        ItemConfigurationView(name: self.name, spacing: .small) {
            TextField(self.name, text: self.text)
                .padding(.vertical, .xSmall)
                .padding(.horizontal, .small)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
