//
//  ColorSchemeConfigurationView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

struct ColorSchemeConfigurationView: View {

    // MARK: - Properties
    
    @Binding var selectedValue: ColorScheme

    // MARK: - View

    var body: some View {
        ToggleConfigurationView(
            name: "Is Light Mode",
            isOn: Binding<Bool>(
                get: { self.selectedValue == .light },
                set: { value in
                    self.selectedValue = value ? .light : .dark
                })
        )
    }
}
