//
//  DividerComponentView.swift
//  SparkDemo
//
//  Created by louis.borlee on 31/07/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import SparkDivider

struct DividerComponentView: View {

    private let theme = SparkTheme.shared

    @State private var text: String = "Text"
    @State private var intent: DividerIntent = .outline
    @State private var axis: DividerAxis = .horizontal
    @State private var alignment: DividerAlignment = .center

    @State private var withText: CheckboxSelectionState = .unselected

    var body: some View {
        Component(
            name: "Divider") {
                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an intent",
                    values: DividerIntent.allCases,
                    value: self.$intent
                )
                EnumSelector(
                    title: "Axis",
                    dialogTitle: "Select an axis",
                    values: DividerAxis.allCases,
                    value: self.$axis
                )
                EnumSelector(
                    title: "Alignment",
                    dialogTitle: "Select an alignment",
                    values: DividerAlignment.allCases,
                    value: self.$alignment
                )
                HStack(spacing: 12) {
                    Text("Text")
                    TextField("Divider text", text: $text)
                        .textFieldStyle(.roundedBorder)
                }
            } integration: {
                let divider = divider()
                if axis == .vertical {
                    divider
                        .frame(height: 300)
                } else {
                    divider
                }
            }
    }

    @ViewBuilder
    private func divider() -> some View {
        HStack {
            Spacer(minLength: 0)
            if text.isEmpty == false {
                DividerView(
                    theme: theme,
                    intent: intent,
                    axis: axis,
                    alignment: alignment,
                    text: {
                        Text(text)
                    }
                )
            } else {
                DividerView(
                    theme: SparkTheme.shared,
                    intent: intent,
                    axis: axis,
                    alignment: alignment
                )
            }
            Spacer(minLength: 0)
        }
    }
}
