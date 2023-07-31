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
            label: "Tab 1",
            icon: UIImage(systemName: "fleuron.fill"),
            badge: badge
        )
    }
}

struct TabItemUIComponentRepresentableView: UIViewRepresentable {
    let theme: Theme
    let label: String
    let icon: UIImage?
    let badge: BadgeUIView?

    init(theme: Theme,
         label: String,
         icon: UIImage?,
         badge: BadgeUIView?) {
        self.theme = theme
        self.label = label
        self.icon = icon
        self.badge = badge
    }

    func makeUIView(context: Context) -> SparkCore.TabItemUIView {
        let view = TabItemUIView(theme: self.theme, label: self.label)
        view.icon = self.icon
        view.badge = self.badge

        return view
    }

    func updateUIView(_ uiView: SparkCore.TabItemUIView, context: Context) {
    }
}

struct TabItemUIComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemUIComponentView()
    }
}
