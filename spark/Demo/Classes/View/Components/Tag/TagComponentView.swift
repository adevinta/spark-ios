//
//  TagComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct TagComponentView: View {

    // MARK: - Properties

    let viewModel = TagComponentViewModel()

    @State private var uiKitViewHeight: CGFloat = .zero

    @State private var versionSheetIsPresented = false
    @State var version: ComponentVersion = .swiftUI

    @State private var intentColorSheetIsPresented = false
    @State var intentColor: TagIntentColor = .primary

    @State private var variantSheetIsPresented = false
    @State var variant: TagVariant = .filled

    @State private var contentSheetIsPresented = false
    @State var content: TagContent = .all

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

                    // **
                    // Intent Color
                    HStack() {
                        Text("Intent color: ")
                            .bold()
                        Button("\(self.intentColor.name)") {
                            self.intentColorSheetIsPresented = true
                        }
                        .confirmationDialog("Select an intent color", isPresented: self.$intentColorSheetIsPresented) {
                            ForEach(TagIntentColor.allCases, id: \.self) { intentColor in
                                Button("\(intentColor.name)") {
                                    self.intentColor = intentColor
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
                        .confirmationDialog("Select an variant", isPresented: self.$variantSheetIsPresented) {
                            ForEach(TagVariant.allCases, id: \.self) { variant in
                                Button("\(variant.name)") {
                                    self.variant = variant
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
                        .confirmationDialog("Select an content", isPresented: self.$contentSheetIsPresented) {
                            ForEach(TagContent.allCases, id: \.self) { content in
                                Button("\(content.name)") {
                                    self.content = content
                                }
                            }
                        }
                    }
                    // **
                }

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()

                if self.version == .swiftUI {
                    TagView(theme: SparkTheme.shared)
                        .intentColor(self.intentColor)
                        .variant(self.variant)
                        .iconImage(self.content.showIcon ? Image(self.viewModel.imageNamed) : nil)
                        .text(self.content.showText ? self.viewModel.text : nil)
                        .accessibility(identifier: "MyTag1",
                                       label: "It's my first tag")
                    
                } else {
                    GeometryReader { geometry in
                        TagComponentItemsUIView(
                            viewModel: self.viewModel,
                            height: self.$uiKitViewHeight,
                            intentColor: self.intentColor,
                            variant: self.variant,
                            content: self.content
                        )
                        .frame(height: self.uiKitViewHeight, alignment: .leading)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitle(Text("Tag"))
    }
}

struct TagComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TagComponentView()
    }
}

// MARK: - Extension

private extension TagIntentColor {

    var name: String {
        switch self {
        case .alert:
            return "Alert"
        case .danger:
            return "Danger"
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

private extension TagVariant {

    var name: String {
        switch self {
        case .filled:
            return "Filled"
        case .outlined:
            return "Outlined"
        case .tinted:
            return "Tinted"
        @unknown default:
            return "Please, add this unknow variant value"
        }
    }
}

private extension TagContent {

    var name: String {
        switch self {
        case .icon:
            return "Icon"
        case .text:
            return "Text"
        case .all:
            return "Icon & Text"
        }
    }
}
