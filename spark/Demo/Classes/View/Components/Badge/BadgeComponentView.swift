//
//  BadgeComponentView.swift
//  Spark
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

private struct BadgePreviewFormatter: BadgeFormatting {
    func formatText(for value: Int?) -> String {
        guard let value else {
            return "_"
        }
        return "Test \(value)"
    }
}

struct BadgeComponentView: View {

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    @State var version: ComponentVersion = .uiKit
    @State var isVersionPresented = false

    @State var intent: BadgeIntentType = .danger
    @State var isIntentPresented = false

    @State var size: BadgeSize = .medium
    @State var isSizePresented = false

    @State var value: Int? = 99

    @State var format: BadgeFormat = .default
    @State var isFormatPresented = false

    @State var isBorderVisible: CheckboxSelectionState = .unselected

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Configuration")
                .font(.title2)
                .bold()
                .padding(.bottom, 6)

            VStack(alignment: .leading, spacing: 8) {
                HStack() {
                    Text("Version: ").bold()
                    Button(self.version.name) {
                        self.isVersionPresented = true
                    }
                    .confirmationDialog("Select a version",
                                        isPresented: self.$isVersionPresented) {
                        ForEach(ComponentVersion.allCases, id: \.self) { version in
                            Button(version.name) {
                                self.version = version
                            }
                        }
                    }
                    Spacer()
                }
                HStack() {
                    Text("Intent: ").bold()
                    Button(self.intent.name) {
                        self.isIntentPresented = true
                    }
                    .confirmationDialog("Select an intent", isPresented: self.$isIntentPresented) {
                        ForEach(BadgeIntentType.allCases, id: \.self) { intent in
                            Button(intent.name) {
                                self.intent = intent
                            }
                        }
                    }
                }
                HStack() {
                    Text("Badge Size: ").bold()
                    Button(self.size.name) {
                        self.isSizePresented = true
                    }
                    .confirmationDialog("Select a size", isPresented: self.$isSizePresented) {
                        ForEach(BadgeSize.allCases, id: \.self) { size in
                            Button(size.name) {
                                self.size = size
                            }
                        }
                    }
                }
                HStack() {
                    Text("Format ").bold()
                    Button(self.format.name) {
                        self.isFormatPresented = true
                    }
                    .confirmationDialog("Select a format", isPresented: self.$isFormatPresented) {
                        ForEach(BadgeFormat.allNames, id: \.self) { name in
                            Button(name) {
                                self.format = BadgeFormat.from(name: name)
                            }
                        }
                    }
                }
                HStack() {
                    Text("Value ").bold()
                    TextField("Value", value: self.$value, formatter: NumberFormatter())
                }

                CheckboxView(
                    text: "With Border",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$isBorderVisible
                )
            }

            Divider()

            Text("Integration")
                .font(.title2)
                .bold()


            if version == .swiftUI {
                BadgeView(theme: self.theme, intent: self.intent, value: self.value)
                    .size(self.size)
                    .format(self.format)
                    .borderVisible(self.isBorderVisible == .selected)
            } else {
                UIBadgeView(theme: self.theme,
                            intent: self.intent,
                            size: self.size,
                            value: self.value,
                            format: self.format,
                            isBorderVisible: self.isBorderVisible == .selected)
                .fixedSize()
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarTitle(Text("Badge"))
    }
}

struct BadgeComponentView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeComponentView()
    }
}

private extension BadgeFormat {
    enum Names {
        static let `default` = "Default"
        static let custom = "Custom"
        static let overflowCounter = "Overflow Counter"
    }

    static var allNames: [String] = [Names.default, Names.custom, Names.overflowCounter]

    var name: String {
        switch self {
        case .default: return Names.default
        case .custom: return Names.custom
        case .overflowCounter: return Names.overflowCounter
        @unknown default:
            fatalError("Unknown Badge Format")
        }
    }

    static func from(name: String) -> BadgeFormat {
        switch name {
        case Names.custom: return .custom(formatter: BadgePreviewFormatter())
        case Names.overflowCounter: return .overflowCounter(maxValue: 99)
        default: return .default
        }
    }
}
