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
    @State var showText = CheckboxSelectionState.selected
    @State var showIcon = CheckboxSelectionState.selected
    @State var showBadge = CheckboxSelectionState.unselected
    @State var isDisabled = CheckboxSelectionState.unselected
    @State var allDisabled = CheckboxSelectionState.unselected
    @State var equalSize = CheckboxSelectionState.selected
    @State var longLabel = CheckboxSelectionState.unselected
    @State var tabSize: TabSize = .md
    @State var numberOfTabs = 2
    @State var selectedTab = 0
    @State var height = CGFloat(50)
    @State var badgePosition = 0
    @State var disabledTab = 0

    var stateVals: [CheckboxSelectionState] {
        [self.showIcon, self.showIcon, self.showBadge, self.longLabel]
    }

    // MARK: - View
    var body: some View {
        Component(
            name: "Tab Item",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an intent",
                    values: TabIntent.allCases,
                    value: self.$intent
                )

                EnumSelector(
                    title: "Size",
                    dialogTitle: "Select a size",
                    values: TabSize.allCases,
                    value: self.$tabSize
                )

                RangeSelector(
                    title: "No. of Tabs",
                    range: 1...20,
                    selectedValue: self.$numberOfTabs
                )

                HStack {
                    CheckboxView(
                        text: "With Label",
                        checkedImage: DemoIconography.shared.checkmark.image,
                        theme: theme,
                        isEnabled: true,
                        selectionState: self.$showText
                    )
                    CheckboxView(
                        text: "Long",
                        checkedImage: DemoIconography.shared.checkmark.image,
                        theme: theme,
                        isEnabled: true,
                        selectionState: self.$longLabel
                    )
                }

                HStack {
                    CheckboxView(
                        text: "With Icon",
                        checkedImage: DemoIconography.shared.checkmark.image,
                        theme: theme,
                        isEnabled: true,
                        selectionState: self.$showIcon
                    )

                    CheckboxView(
                        text: "Show Badge",
                        checkedImage: DemoIconography.shared.checkmark.image,
                        theme: theme,
                        isEnabled: true,
                        selectionState: self.$showBadge
                    )
                    .onChange(of: self.showBadge) { _ in
                        self.badgePosition = (0..<self.numberOfTabs).randomElement() ?? 0
                    }
                }

                CheckboxView(
                    text: "Disable Random Tab",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    isEnabled: true,
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
                    text: "Disable All Tabs",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$allDisabled
                )

                CheckboxView(
                    text: "Equal sized",
                    checkedImage: DemoIconography.shared.checkmark.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$equalSize
                )

            },
            integration: {
                TabView(
                    theme: self.theme,
                    intent: self.intent,
                    tabSize: self.tabSize,
                    content: self.tabs(),
                    selectedIndex: self.$selectedTab
                )
                .apportionsSegmentWidthsByContent(!self.equalSize.isSelected)
                .badge(self.badge(), index: self.badgePosition)
                .disabled(isDisabled.isSelected, index: self.disabledTab)
                .disabled(self.allDisabled == .selected)
            }
        )
        .onChange(of: self.numberOfTabs) { _ in
            self.redraw()
        }
        .onChange(of: self.stateVals) { _ in
            self.redraw()
        }
    }

    func redraw() {
        self.equalSize.toggle()
        DispatchQueue.main.async {
            self.equalSize.toggle()
        }
    }

    func badge() -> BadgeView? {
        if self.showBadge.isSelected {
            return BadgeView(theme: theme, intent: .danger, value: 99).borderVisible(false)
        } else {
            return nil
        }

    }

    private func tabs() -> [TabItemContent] {
        return (0..<self.numberOfTabs).map {
            .init(
                icon: self.showIcon.isSelected ? .image(at: $0) : nil,
                title: self.showText.isSelected ? self.label($0) : nil
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

    mutating func toggle() {
        if self == .selected {
            self = .unselected
        } else {
            self = .selected
        }
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

