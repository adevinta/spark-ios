//
//  ItemSelector.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 14.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct EnumSelector<Value>: View where Value: CaseIterable & Hashable {
    let title: String
    let dialogTitle: String
    let values: [Value]
    @Binding var value: Value

    var nameFormatter: (Value) -> String = { value in
        return value.name
    }

    @State private var isPresented = false

    var body: some View {
        HStack() {
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
            }
        }
    }
}
