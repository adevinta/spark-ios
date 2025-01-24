//
//  DynamicTypeConfigurationView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

struct DynamicTypeConfigurationView: View {

    // MARK: - Properties

    let values: [DynamicTypeSize] = {
        DynamicTypeSize.allCases
    }()

    @Binding var selectedValue: DynamicTypeSize

    // MARK: - View

    var body: some View {
        VStack(spacing: Spacing.none) {
            Text(self.selectedValue.name + self.selectedValue.info)
                .font(.footnote)

            HStack(spacing: .small) {
                Text("A")
                    .dynamicTypeSize(.small)

                SliderConfigurationView(
                    name: nil,
                    selectedValue: Binding<Double>(
                        get: { Double(self.values.firstIndex(of: self.selectedValue) ?? 0) },
                        set: { index in
                            self.selectedValue = self.values[Int(index)]
                        }),
                    range: 0...Double(self.values.count-1),
                    step: 1
                )

                Text("A")
                    .dynamicTypeSize(.large)
            }
        }
    }
}
