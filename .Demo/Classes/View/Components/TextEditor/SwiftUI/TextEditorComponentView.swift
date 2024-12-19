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

    @FocusState private var focusedTextfield: FocusField?

    enum FocusField: Hashable {
        case textfield3, textfield4
    }


    var charactersCount: Int {
        self.text.count
    }

    // MARK: - View

    var body: some View {
//        ScrollView {
//            VStack {
//
//                ContentView()
//
//                TextEditorView(
//                    "azdazdazdzadazdazd",
//                    text: self.$text,
//                    theme: self.theme,
//                    intent: self.intent
//                )
////                .readHeight(self.text)
//                .focused($focusedTextfield, equals: .textfield3)
//                .disabled(self.isEnabledState == .unselected)
//                .frame(
//                    type: self.heightType,
//                    value: self.heightValue,
//                    scaleFactor: self.scaleFactor
//                )
//
//                Text("azazdazd \(self.charactersCount)")
//
//                Spacer()
//            }
//        }

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
                VStack {
                    TextEditorView(
                        self.contentType(self.placeholderType),
                        text: self.$text,
                        theme: self.theme,
                        intent: self.intent
                    )
                    .disabled(self.isEnabledState == .unselected)
                    .frame(
                        type: self.heightType,
                        value: self.heightValue,
                        scaleFactor: self.scaleFactor
                    )
                }
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


private struct MyTextField: View {

    @FocusState private var isFocused: Bool

    let title: String
    @Binding var text: String

    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }

    var body: some View {
        TextField(title, text: $text)
            .focused($isFocused) // important !
            .padding()
            .overlay(
                RoundedRectangle(
                    cornerRadius: 10.0, style: .continuous
                )
                .stroke(isFocused ? .green : .gray, lineWidth: isFocused ? 3 : 1)
            )
            .accentColor(Color(uiColor: .red))
    }
}


private struct ContentView: View {

    @FocusState private var focusedTextfield: FocusField?

    enum FocusField: Hashable {
        case textfield1, textfield2
    }

    @State private var input1 = "Hi"
    @State private var input2 = "Hi2"

    var body: some View {
        VStack(spacing: 16) {
            MyTextField("hello", text: $input1)
                .focused($focusedTextfield, equals: .textfield1)

            Text("Count \(self.input1.count)")

            MyTextField("hello", text: $input2)
                .focused($focusedTextfield, equals: .textfield2)

            Text("Count \(self.input2.count)")

            // test for changing focus
            Button("Field 1") { focusedTextfield = .textfield1}
            Button("Field 2") { focusedTextfield = .textfield2}

        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focusedTextfield = .textfield1
            }
        }
    }
}
