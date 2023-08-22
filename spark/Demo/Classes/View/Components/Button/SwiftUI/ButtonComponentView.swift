//
//  ButtonComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct ButtonComponentView: View {

    // MARK: - Properties

    let viewModel = ButtonComponentViewModel()

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }
    @State var isThemePresented = false

    var themes: [ThemeCellModel] = [
        .init(title: "Spark", theme: SparkTheme()),
        .init(title: "Purple", theme: PurpleTheme())
    ]

    @State private var uiKitViewHeight: CGFloat = .zero

    @State private var intentSheetIsPresented = false
    @State var intent: ButtonIntent = .main

    @State private var variantSheetIsPresented = false
    @State var variant: ButtonVariant = .filled

    @State private var sizeSheetIsPresented = false
    @State var size: ButtonSize = .medium

    @State private var shapeSheetIsPresented = false
    @State var shape: ButtonShape = .rounded

    @State private var alignmentSheetIsPresented = false
    @State var alignment: ButtonAlignment = .leadingIcon

    @State private var contentSheetIsPresented = false
    @State var content: ButtonContentDefault = .text

    @State private var isEnabledSheetIsPresented = false
    @State var isEnabled: Bool = true

    @State var shouldShowReverseBackgroundColor: Bool = false

    // MARK: - View

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Configuration")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 16) {
                    // **
                    // Version
                    HStack() {
                        Text("Theme: ").bold()
                        let selectedTheme = self.theme is SparkTheme ? themes.first : themes.last
                        Button(selectedTheme?.title ?? "") {
                            self.isThemePresented = true
                        }
                        .confirmationDialog("Select a theme",
                                            isPresented: self.$isThemePresented) {
                            ForEach(themes, id: \.self) { theme in
                                Button(theme.title) {
                                    themePublisher.theme = theme.theme
                                }
                            }
                        }
                        .onChange(of: self.intent) { newValue in
                            self.shouldShowReverseBackgroundColor = (newValue == .surface)
                        }
                        Spacer()
                    }
                    // **

                    // **
                    // Intent
                    HStack() {
                        Text("Intent: ")
                            .bold()
                        Button("\(self.intent.name)") {
                            self.intentSheetIsPresented = true
                        }
                        .confirmationDialog("Select an intent", isPresented: self.$intentSheetIsPresented) {
                            ForEach(ButtonIntent.allCases, id: \.self) { intent in
                                Button("\(intent.name)") {
                                    self.intent = intent
                                }
                            }
                        }
                    }
                    // **

                    // **
                    // Variant
                    HStack() {
                        Text("Variant: ")
                            .bold()
                        Button("\(self.variant.name)") {
                            self.variantSheetIsPresented = true
                        }
                        .confirmationDialog("Select a variant", isPresented: self.$variantSheetIsPresented) {
                            ForEach(ButtonVariant.allCases, id: \.self) { variant in
                                Button("\(variant.name)") {
                                    self.variant = variant
                                }
                            }
                        }
                    }
                    // **

                    // **
                    // Size
                    HStack() {
                        Text("Size: ")
                            .bold()
                        Button("\(self.size.name)") {
                            self.sizeSheetIsPresented = true
                        }
                        .confirmationDialog("Select a size", isPresented: self.$sizeSheetIsPresented) {
                            ForEach(ButtonSize.allCases, id: \.self) { size in
                                Button("\(size.name)") {
                                    self.size = size
                                }
                            }
                        }
                    }
                    // **

                    // **
                    // Shape
                    HStack() {
                        Text("Shape: ")
                            .bold()
                        Button("\(self.shape.name)") {
                            self.shapeSheetIsPresented = true
                        }
                        .confirmationDialog("Select a shape", isPresented: self.$shapeSheetIsPresented) {
                            ForEach(ButtonShape.allCases, id: \.self) { shape in
                                Button("\(shape.name)") {
                                    self.shape = shape
                                }
                            }
                        }
                    }
                    // **

                    // **
                    // Alignment
                    HStack() {
                        Text("Alignment: ")
                            .bold()
                        Button("\(self.alignment.name)") {
                            self.alignmentSheetIsPresented = true
                        }
                        .confirmationDialog("Select a alignment", isPresented: self.$alignmentSheetIsPresented) {
                            ForEach(ButtonAlignment.allCases, id: \.self) { alignment in
                                Button("\(alignment.name)") {
                                    self.alignment = alignment
                                }
                            }
                        }
                    }
                    // **

                    // **
                    // Content
                    HStack() {
                        Text("Content: ")
                            .bold()
                        Button("\(self.content.name)") {
                            self.contentSheetIsPresented = true
                        }
                        .confirmationDialog("Select a content", isPresented: self.$contentSheetIsPresented) {
                            ForEach(ButtonContentDefault.allCases, id: \.self) { content in
                                Button("\(content.name)") {
                                    self.content = content
                                }
                            }
                        }
                    }
                    // **

                    // Is Enabled
                    HStack() {
                        Text("Is enabled: ")
                            .bold()
                        Toggle("", isOn: self.$isEnabled)
                            .labelsHidden()
                    }
                }

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()

                GeometryReader { geometry in
                    ButtonComponentItemsUIView(
                        viewModel: self.viewModel,
                        width: geometry.size.width,
                        height: self.$uiKitViewHeight,
                        intent: self.$intent.wrappedValue,
                        variant: self.$variant.wrappedValue,
                        size: self.$size.wrappedValue,
                        shape: self.$shape.wrappedValue,
                        alignment: self.$alignment.wrappedValue,
                        content: self.$content.wrappedValue,
                        isEnabled: self.$isEnabled.wrappedValue
                    )
                    .frame(width: geometry.size.width, height: self.uiKitViewHeight, alignment: .center)
                    .padding(.horizontal, self.shouldShowReverseBackgroundColor ? 4 : 0)
                    .padding(.vertical, self.shouldShowReverseBackgroundColor ? 4 : 0)
                    .background(self.shouldShowReverseBackgroundColor ? Color.gray : Color.clear)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitle(Text("Button"))
    }
}

struct ButtonComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonComponentView()
    }
}

// MARK: - Extension

private extension ButtonIntent {

    var name: String {
        switch self {
        case .accent:
            return "Accent"
        case .basic:
            return "Basic"
        case .alert:
            return "Alert"
        case .danger:
            return "Danger"
        case .neutral:
            return "Neutral"
        case .main:
            return "Main"
        case .support:
            return "Support"
        case .success:
            return "Success"
        case .surface:
            return "Surface"
        }
    }
}

private extension ButtonVariant {

    var name: String {
        switch self {
        case .filled:
            return "Filled"
        case .outlined:
            return "Outlined"
        case .tinted:
            return "Tinted"
        case .ghost:
            return "Ghost"
        case .contrast:
            return "Contrast"
        @unknown default:
            return "Please, add this unknow variant value"
        }
    }
}


private extension ButtonSize {

    var name: String {
        switch self {
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        @unknown default:
            return "Please, add this unknow variant value"
        }
    }
}

private extension ButtonShape {

    var name: String {
        switch self {
        case .square:
            return "Square"
        case .rounded:
            return "Rounde"
        case .pill:
            return "Pill"
        @unknown default:
            return "Please, add this unknow variant value"
        }
    }
}

private extension ButtonAlignment {

    var name: String {
        switch self {
        case .leadingIcon:
            return "Icon on left"
        case .trailingIcon:
            return "Icon on right"
        @unknown default:
            return "Please, add this unknow alignment value"
        }
    }
}

private extension ButtonContentDefault {

    var name: String {
        switch self {
        case .icon:
            return "Icon"
        case .text:
            return "Text"
        case .attributedText:
            return "Attributed Text"
        case .iconAndText:
            return "Icon & Text"
        case .iconAndAttributedText:
            return "Icon & Attributed Text"
        }
    }
}
