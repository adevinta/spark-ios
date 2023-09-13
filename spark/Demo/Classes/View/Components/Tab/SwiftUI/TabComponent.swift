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
    @State var theme: Theme = SparkThemePublisher.shared.theme
    @State var intent: TabIntent = .basic
    @State var isIntentPresented = false
    @State var showText = CheckboxSelectionState.selected
    @State var showIcon = CheckboxSelectionState.selected
    @State var showBadge = CheckboxSelectionState.unselected
    @State var isDisabled = CheckboxSelectionState.unselected
    @State var equalSize = CheckboxSelectionState.selected
    @State var longLabel = CheckboxSelectionState.unselected
    @State var tabSize: TabSize = .md
    @State var isSizePresented = false
    @State var numberOfTabs = 4
    @State var selectedTab = 0
    @State var height = CGFloat(50)
    @State var badgePosition = 0
    @State var disabledTab = 0

    // MARK: - View
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Configuration")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 6)

                ThemeSelector(theme: self.$theme)

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

                HStack {
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
                }

                CheckboxView(
                    text: "Disabled",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$isDisabled
                )
                .onChange(of: self.isDisabled) { _ in
                    if self.isDisabled.isSelected {
                        self.disabledTab = (0..<self.numberOfTabs).randomElement() ?? 0
                    } else {
                        self.disabledTab = 0
                    }
                }

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

                Text("Integration \(self.selectedTab)")
                    .font(.title2)
                    .bold()

                TabView<BadgeView>(
                    theme: self.theme,
                    intent: self.intent,
                    tabSize: self.tabSize,
                    content: self.tabs(),
                    selectedIndex: self.$selectedTab,
                    apportionsSegmentWidthsByContent: !self.equalSize.isSelected
                )
                .disabled(isDisabled.isSelected, index: self.disabledTab)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .navigationBarTitle(Text("Tab Item"))
    }

    func badge() -> BadgeView {
        BadgeView(theme: theme, intent: .danger, value: 99)
    }

    private func tabs() -> [TabItemContent] {

        return (0..<self.numberOfTabs).map {
            .init(
                image: self.showIcon.isSelected ? .image(at: $0) : nil,
                title: self.showText.isSelected ? self.label($0) : nil,
                badge: self.showBadge.isSelected && self.badgePosition == $0 ? self.badge() : nil
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

