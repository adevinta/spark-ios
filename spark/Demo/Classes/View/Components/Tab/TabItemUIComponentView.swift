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
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var body: some View {
        let badge = BadgeUIView(
            theme: themePublisher.theme,
            intent: .danger,
            value: 5,
            isBorderVisible: false)
        TabItemUIComponentRepresentableView(
            theme: themePublisher.theme,
            intent: .main,
            label: "Tab 1",
            icon: UIImage(systemName: "fleuron.fill"),
            badge: badge,
            isSelected: true,
            isEnabled: true
        )

    }
}

struct TabItemUIComponentRepresentableView: UIViewRepresentable {
    let theme: Theme
    let label: String?
    let icon: UIImage?
    let badge: BadgeUIView?
    let intent: TabIntent
    let isSelected: Bool
    let isEnabled: Bool

    init(theme: Theme,
         intent: TabIntent,
         label: String?,
         icon: UIImage?,
         badge: BadgeUIView?,
         isSelected: Bool,
         isEnabled: Bool
    ) {
        self.theme = theme
        self.intent = intent
        self.label = label
        self.icon = icon
        self.badge = badge
        self.isSelected = isSelected
        self.isEnabled = isEnabled
    }

    func makeUIView(context: Context) -> SparkCore.TabItemUIView {
        let view = TabItemUIView(
            theme: self.theme,
            intent: self.intent,
            label: self.label,
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
        uiView.badge = self.badge
        uiView.icon = self.icon
        uiView.text = self.label
        uiView.isEnabled = self.isEnabled
        uiView.isSelected = self.isSelected
    }
}

struct TabItemUIComponentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TabItemUIComponentView()
            Text("Hello World")
        }
    }
}
