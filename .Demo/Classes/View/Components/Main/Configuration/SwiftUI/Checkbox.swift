//
//  Checkbox.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 24.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import SwiftUI

struct Checkbox: View {
    @ObservedObject private var themePublisher = SparkThemePublisher.shared
    var theme: Theme {
        self.themePublisher.theme
    }

    var title: String
    var selectionState: Binding<CheckboxSelectionState>

    var body: some View {
        CheckboxView(
            text: self.title,
            checkedImage: DemoIconography.shared.checkmark.image,
            theme: self.theme,
            isEnabled: true,
            selectionState: self.selectionState
        )
    }
}
