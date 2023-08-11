//
//  TabItemUIComponentView.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 31.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct TabItemUIComponentView: View {
    // MARK: - Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - View
    var body: some View {
        let badge = BadgeUIView(
            theme: themePublisher.theme,
            intent: .danger,
            value: 5,
            isBorderVisible: false)
        TabItemUIComponentRepresentableView(
            theme: themePublisher.theme,
            intent: .main,
            tabSize: .md,
            title: "Tab 1",
            icon: UIImage(systemName: "fleuron.fill"),
            badge: badge,
            isSelected: true,
            isEnabled: true
        )
    }
}

struct TabItemUIComponentRepresentableView: UIViewRepresentable {
    let theme: Theme
    let intent: TabIntent
    let tabSize: TabSize
    let title: String?
    let icon: UIImage?
    let badge: BadgeUIView?
    let isSelected: Bool
    let isEnabled: Bool

    init(theme: Theme,
         intent: TabIntent,
         tabSize: TabSize,
         title: String?,
         icon: UIImage?,
         badge: BadgeUIView?,
         isSelected: Bool,
         isEnabled: Bool
    ) {
        self.theme = theme
        self.intent = intent
        self.tabSize = tabSize
        self.title = title
        self.icon = icon
        self.badge = badge
        self.isSelected = isSelected
        self.isEnabled = isEnabled
    }

    func makeUIView(context: Context) -> SparkCore.TabItemUIView {
        let view = TabItemUIView(
            theme: self.theme,
            intent: self.intent,
            tabSize: self.tabSize,
            title: self.title,
            icon: self.icon)

        view.icon = self.icon
        view.badge = self.badge
        view.isSelected = self.isSelected
        view.isEnabled = self.isEnabled

        return view
    }

    func updateUIView(_ uiView: SparkCore.TabItemUIView, context: Context) {
        uiView.theme = self.theme
        uiView.intent = self.intent
        uiView.tabSize = self.tabSize
        uiView.badge = self.badge
        uiView.icon = self.icon
        uiView.title = self.title
        uiView.isEnabled = self.isEnabled
        uiView.isSelected = self.isSelected
    }
}

struct TabItemUIComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemUIComponentView()
    }
}
