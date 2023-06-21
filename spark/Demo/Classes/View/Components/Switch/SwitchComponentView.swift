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

    @State private var intentColorSheetIsPresented = false
    @State var intentColor: SwitchIntentColor = .primary

    @State private var isEnabledSheetIsPresented = false
    @State var isEnabled: Bool = true

    @State private var isVariantSheetIsPresented = false
    @State var isVariant: Bool = false

    @State private var isMultilineTextSheetIsPresented = false
    @State var isMultilineText: Bool = true

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
                    // Intent Color
                    HStack() {
                        Text("Intent color: ")
                            .bold()
                        Button("\(self.intentColor.name)") {
                            self.intentColorSheetIsPresented = true
                        }
                        .confirmationDialog("Select an intent color", isPresented: self.$intentColorSheetIsPresented) {
                            ForEach(SwitchIntentColor.allCases, id: \.self) { intentColor in
                                Button("\(intentColor.name)") {
                                    self.intentColor = intentColor
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

                    // Is Variant
                    HStack() {
                        Text("Is variant: ")
                            .bold()
                        Toggle("", isOn: self.$isVariant)
                            .labelsHidden()
                    }

                    // Is Multiline text
                    HStack() {
                        Text("Is multiline text: ")
                            .bold()
                        Toggle("", isOn: self.$isMultilineText)
                            .labelsHidden()
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
                            version: self.$version.wrappedValue,
                            alignment: self.$alignment.wrappedValue,
                            intentColor: self.$intentColor.wrappedValue,
                            isEnabled: self.$isEnabled.wrappedValue,
                            isVariant: self.$isVariant.wrappedValue,
                            isMultilineText: self.$isMultilineText.wrappedValue
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

private extension SwitchIntentColor {

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
        case .primary:
            return "Primary"
        case .secondary:
            return "Secondary"
        case .success:
            return "Success"
        @unknown default:
            return "Please, add this unknow intent color value"
        }
    }
}
