//
//  TabItemComponent.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 01.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct TabComponent: View {

    // MARK: Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    @State private var versionSheetIsPresented = false
    @State var version: ComponentVersion = .uiKit

    @State var intent: TabIntent = .main
    @State var isIntentPresented = false
    @State var showText = CheckboxSelectionState.selected
    @State var showIcon = CheckboxSelectionState.selected
    @State var showBadge = CheckboxSelectionState.unselected
    @State var isSelected = CheckboxSelectionState.unselected
    @State var isEnabled = CheckboxSelectionState.selected
    @State var tabSize: TabSize = .md
    @State var isSizePresented = false
    @State var numberOfTabs = 3

    // MARK: - View
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Configuration")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 6)
                HStack() {
                    Text("Version: ").bold()
                    Button(self.version.name) {
                        self.versionSheetIsPresented = true
                    }
                    .confirmationDialog("Select a version",
                                        isPresented: self.$versionSheetIsPresented) {
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
                        ForEach(TabIntent.allCases, id: \.self) { intent in
                            Button(intent.name) {
                                self.intent = intent
                            }
                        }
                    }
                }
                HStack() {
                    Text("Size: ").bold()
                    Button(self.tabSize.name) {
                        self.isSizePresented = true
                    }
                    .confirmationDialog("Select a size", isPresented: self.$isSizePresented) {
                        ForEach(TabSize.allCases, id: \.self) { size in
                            Button(size.name) {
                                self.tabSize = size
                            }
                        }
                    }
                }

                HStack() {
                    Text("No. of Tabs ").bold()
                    TextField("Number of Tabs", value: self.$numberOfTabs, formatter: NumberFormatter())
                }

                CheckboxView(
                    text: "With Label",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$showText
                )

                CheckboxView(
                    text: "With Icon",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$showIcon
                )

                CheckboxView(
                    text: "Show Badge",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$showBadge
                )

                CheckboxView(
                    text: "Is Selected",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$isSelected
                )

                CheckboxView(
                    text: "Is Enabled",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$isEnabled
                )

            }
            .padding(.horizontal, 16)

            VStack(alignment: .leading, spacing: 16) {

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()

                if version == .swiftUI {
                    Text("Not available yet!")
                } else {
                    let badge = BadgeUIView(
                        theme: themePublisher.theme,
                        intent: .danger,
                        value: 5,
                        isBorderVisible: false)
                    TabUIComponentRepresentableView(
                        theme: self.theme,
                        intent: self.intent,
                        tabSize: self.tabSize,
                        showText: self.showText.isSelected,
                        showIcon: self.showIcon.isSelected,
                        badge: self.showBadge.isSelected ? badge : nil,
                        isSelected: self.isSelected.isSelected,
                        isEnabled: self.isEnabled.isSelected,
                        numberOfTabs: self.numberOfTabs
                    )
                    .frame(width: 100, height: 40)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .navigationBarTitle(Text("Tab Item"))
    }
}

struct TabComponent_Previews: PreviewProvider {
    static var previews: some View {
        TabComponent()
    }
}

private extension CheckboxSelectionState {
    var isSelected: Bool {
        return self == .selected
    }
}

private extension TabSize {
    var name: String {
        switch self {
        case .md: return "Medium"
        case .sm: return "Small"
        case .xs: return "Xtra Small"
        @unknown default:
            fatalError()
        }
    }
}
