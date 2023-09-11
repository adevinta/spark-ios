//
//  TabItem_Preview.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 04.09.23.
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

    @State var intent: TabIntent = .basic
    @State var isIntentPresented = false
    @State var showText = CheckboxSelectionState.selected
    @State var showIcon = CheckboxSelectionState.selected
    @State var showBadge = CheckboxSelectionState.unselected
    @State var isEnabled = CheckboxSelectionState.selected
    @State var equalSize = CheckboxSelectionState.unselected
    @State var longLabel = CheckboxSelectionState.unselected
    @State var tabSize: TabSize = .md
    @State var isSizePresented = false
    @State var numberOfTabs = 2
    @State var selectedTab = 0
    @State var height = CGFloat(50)
    @State var badgePosition = 0

    // MARK: - View
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Configuration")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 6)
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
                    Button("-") {
                        guard self.numberOfTabs > 1 else { return }
                        self.numberOfTabs -= 1
                    }
                    Text("\(self.numberOfTabs)")
                    Button("+") {
                        self.numberOfTabs += 1
                    }
                }

                HStack {
                    CheckboxView(
                        text: "With Label",
                        checkedImage: DemoIconography.shared.checkmark,
                        theme: theme,
                        state: .enabled,
                        selectionState: self.$showText
                    )
                    CheckboxView(
                        text: "Long",
                        checkedImage: DemoIconography.shared.checkmark,
                        theme: theme,
                        state: .enabled,
                        selectionState: self.$longLabel
                    )
                }

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
                .onChange(of: self.showBadge) { _ in
                    self.badgePosition = (0..<self.numberOfTabs).randomElement() ?? 0
                }

                CheckboxView(
                    text: "Is Enabled",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$isEnabled
                )

                CheckboxView(
                    text: "Equal sized",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$equalSize
                )

            }
            .padding(.horizontal, 16)

            VStack(alignment: .leading, spacing: 16) {

                Divider()

                Button("Button", action: {}
                )
                .disabled(!isEnabled.isSelected)

                Text("Integration \(self.selectedTab)")
                    .font(.title2)
                    .bold()

                TabView<BadgeView>(
                    theme: self.themePublisher.theme,
                    intent: self.intent,
                    tabSize: self.tabSize,
                    content: self.tabs(),
                    selectedIndex: self.$selectedTab,
                    apportionsSegmentWidthsByContent: !self.equalSize.isSelected
                )
                .disabled(!isEnabled.isSelected)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .navigationBarTitle(Text("Tab Item"))

    }

    func badge() -> BadgeView {
        BadgeView(theme: theme, intent: .danger, value: 99)
    }

    private func tabs() -> [(Image?, String?, BadgeView?)] {

        return (0..<self.numberOfTabs).map {
            (self.showIcon.isSelected ? .image(at: $0) : nil,
             self.showText.isSelected ? self.label($0) : nil,
             self.showBadge.isSelected && self.badgePosition == $0 ? self.badge() : nil
            )
        }
    }

    private func label(_ index: Int) -> String {
        if self.longLabel.isSelected && index == 1 {
            return "Long label \(index)"
        } else {
            return "Tab \(index)"
        }
    }

}

private extension CheckboxSelectionState {
    var isSelected: Bool {
        return self == .selected
    }
}

private extension Image {
    static let names = [
        "fleuron",
        "trash",
        "folder",
        "paperplane",
        "tray",
        "externaldrive",
        "internaldrive",
        "archivebox",
        "doc",
        "clipboard",
        "terminal",
        "book",
        "greetingcard",
        "menucard",
        "magazine"
    ]

    // swiftlint: disable force_unwrapping
    static func image(at index: Int) -> Image {
        let allSfs: [String] = names.flatMap{ [$0, "\($0).fill"] }
        let imageName = allSfs[index % names.count]
        return Image(systemName: imageName)
    }
}

struct TabItem_Preview_Previews: PreviewProvider {

    static var previews: some View {
        TabComponent()
    }
}

