//
//  OptionalEnumSelector.swift
//  SparkDemo
//
//  Created by louis.borlee on 19/09/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

struct OptionalEnumSelector<Value>: View where Value: CaseIterable & Hashable {
    let title: String
    let dialogTitle: String
    let values: [Value]
    @Binding var value: Value?

    var nameFormatter: (Value?) -> String = { value in
        return value?.name ?? "Default"
    }

    @State private var isPresented = false

    var body: some View {
        HStack {
            Text("\(title): ").bold()
            Button(self.nameFormatter(value)) {
                self.isPresented = true
            }
            .confirmationDialog(dialogTitle, isPresented: self.$isPresented) {
                ForEach(self.values, id: \.self) { value in
                    Button(self.nameFormatter(value)) {
                        self.value = value
                    }
                }
                Button("Default") {
                    self.value = nil
                }
            }
        }
    }
}
