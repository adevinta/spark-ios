//
//  SwitchComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct SwitchComponentView: View {

    // MARK: - Properties

    let viewModel = SwitchComponentViewModel()

    @State private var uiKitViewHeight: CGFloat = .zero

    @State private var versionSheetIsPresented = false
    @State var version: ComponentVersion = .uiKit

    @State private var isOnSheetIsPresented = false
    @State var isOn: Bool = true

    @State private var alignmentSheetIsPresented = false
    @State var alignment: SwitchAlignment = .left

    @State private var intentSheetIsPresented = false
    @State var intent: SwitchIntent = .main

    @State private var isEnabledSheetIsPresented = false
    @State var isEnabled: Bool = true

    @State private var hasImagesSheetIsPresented = false
    @State var hasImages: Bool = false

    @State private var isMultilineTextSheetIsPresented = false
    @State var isMultilineText: Bool = true

    @State private var textContentSheetIsPresented = false
    @State var textContent: SwitchTextContentDefault = .text

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
                        Text("Version: ")
                            .bold()
                        Button("\(self.version.name)") {
                            self.versionSheetIsPresented = true
                        }
                        .confirmationDialog("Select an version", isPresented: self.$versionSheetIsPresented) {
                            ForEach(ComponentVersion.allCases, id: \.self) { version in
                                Button("\(version.name)") {
                                    self.version = version
                                }
                            }
                        }
                    }
                    // **

                    // Is On
                    HStack() {
                        Text("Is on: ")
                            .bold()
                        Toggle("", isOn: self.$isOn)
                            .labelsHidden()
                    }

                    // **
                    // Alignment
                    HStack() {
                        Text("Alignment: ")
                            .bold()
                        Button("\(self.alignment.name)") {
                            self.alignmentSheetIsPresented = true
                        }
                        .confirmationDialog("Select an alignment", isPresented: self.$alignmentSheetIsPresented) {
                            ForEach(SwitchAlignment.allCases, id: \.self) { alignment in
                                Button("\(alignment.name)") {
                                    self.alignment = alignment
                                }
                            }
                        }
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
                            ForEach(SwitchIntent.allCases, id: \.self) { intent in
                                Button("\(intent.name)") {
                                    self.intent = intent
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

                    // Has Images
                    HStack() {
                        Text("Has images: ")
                            .bold()
                        Toggle("", isOn: self.$hasImages)
                            .labelsHidden()
                    }

                    // Text Content
                    HStack() {
                        Text("Text content: ")
                            .bold()
                        Button("\(self.textContent.name)") {
                            self.textContentSheetIsPresented = true
                        }
                        .confirmationDialog("Select an text content", isPresented: self.$textContentSheetIsPresented) {
                            ForEach(SwitchTextContentDefault.allCases, id: \.self) { textContent in
                                Button("\(textContent.name)") {
                                    self.textContent = textContent
                                }
                            }
                        }
                    }
                }

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()

                if self.version == .swiftUI {
                    Text("Not dev yet !")
                } else {
                    GeometryReader { geometry in
                        SwitchComponentItemsUIView(
                            viewModel: self.viewModel,
                            width: geometry.size.width,
                            height: self.$uiKitViewHeight,
                            isOn: self.$isOn,
                            alignment: self.$alignment.wrappedValue,
                            intent: self.$intent.wrappedValue,
                            isEnabled: self.$isEnabled.wrappedValue,
                            hasImages: self.$hasImages.wrappedValue,
                            textContent: self.$textContent.wrappedValue
                        )
                        .frame(width: geometry.size.width, height: self.uiKitViewHeight, alignment: .leading)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitle(Text("Switch"))
    }
}

struct SwitchComponentView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchComponentView()
    }
}

// MARK: - Extension

private extension SwitchAlignment {

    var name: String {
        switch self {
        case .left:
            return "Toggle on left"
        case .right:
            return "Toggle on right"
        @unknown default:
            return "Please, add this unknow alignment value"
        }
    }
}

private extension SwitchIntent {

    var name: String {
        switch self {
        case .alert:
            return "Alert"
        case .error:
            return "Error"
        case .info:
            return "Info"
        case .neutral:
            return "Neutral"
        case .main:
            return "Main"
        case .support:
            return "Support"
        case .success:
            return "Success"
        @unknown default:
            return "Please, add this unknow intent value"
        }
    }
}

private extension SwitchTextContentDefault {

    var name: String {
        switch self {
        case .text:
            return "Text"
        case .attributedText:
            return "Attributed Text"
        case .multilineText:
            return "Multiline Text"
        }
    }
}
