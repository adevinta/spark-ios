//
//  TextEditorComponentView.swift
//  SparkDemo
//
//  Created by alican.aycil on 20.06.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkCore

@available(iOS 16.0, *)
struct TextEditorComponentView: View {

    // MARK: - Constants

    private enum Constants {
        static let minHeightRange = 75
    }

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: TextEditorIntent = .neutral
    @State var text: String = ""
    @State private var placeholderType: TextEditorContent = .short
    @State private var isEnabledState: CheckboxSelectionState = .selected
    @State private var heightType: HeightType = .none
    @State private var heightValue: Int = Constants.minHeightRange

    @ScaledMetric private var scaleFactor: CGFloat = 1.0

    // MARK: - View

    var body: some View {
        Component(
            name: "TextEditor",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "",
                    values: TextEditorIntent.allCases,
                    value: self.$intent
                )

                EnumSelector(
                    title: "PlaceHolder Type",
                    dialogTitle: "",
                    values: TextEditorContent.allCases,
                    value: self.$placeholderType
                )

                Checkbox(title: "Is Enabled", selectionState: $isEnabledState)

                EnumSelector(
                    title: "Height Type",
                    dialogTitle: "",
                    values: HeightType.allCases,
                    value: self.$heightType
                )

                if self.heightType.shouldSetFrame {
                    RangeSelector(
                        title: "Height value",
                        range: Constants.minHeightRange...400,
                        selectedValue: self.$heightValue,
                        stepper: 25
                    )
                }
            },
            integration: {
//                TextEditorView(
//                    self.contentType(self.placeholderType),
//                    text: self.$text,
//                    theme: self.theme,
//                    intent: self.intent
//                )
//                .disabled(self.isEnabledState == .unselected)
//                .frame(
//                    type: self.heightType,
//                    value: self.heightValue,
//                    scaleFactor: self.scaleFactor
//                )
            }
        )
    }

    private func contentType(_ value: TextEditorContent) -> String {
        switch value {
        case .none:
            return ""
        case .short:
            return "What is Lorem Ipsum?"
        case .medium:
            return "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        case .long:
            return "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."
        }
    }
}

// MARK: - Extension

private extension View {

    @ViewBuilder
    func frame(type: HeightType, value: Int, scaleFactor: CGFloat) -> some View {
        switch type {
        case .none:
            self
        case .fixed:
            self.frame(height: CGFloat(value) * scaleFactor)
        case .minimum:
            self.frame(minHeight: CGFloat(value) * scaleFactor)
        }
    }
}

// MARK: - Enum

private enum HeightType: CaseIterable {
    case none
    case fixed
    case minimum

    // MARK: - Properties

    var shouldSetFrame: Bool {
        switch self {
        case .none: false
        case .fixed, .minimum: true
        }
    }
}
