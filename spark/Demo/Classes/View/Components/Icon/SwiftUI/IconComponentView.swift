//
//  IconComponentView.swift
//  SparkDemo
//
//  Created by Jacklyn Situmorang on 25.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct IconComponentView: View {

    // MARK: - Properties

    @State var theme: Theme = SparkThemePublisher.shared.theme

    @State private var uiKitViewHeight: CGFloat = .zero
    @State var size: IconSize = .medium
    @State var intent: IconIntent = .main

    // MARK: - View

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Configuration")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 16) {
                    ThemeSelector(theme: self.$theme)

                    // Intent
                    EnumSelector(
                        title: "Intent",
                        dialogTitle: "Select an Intent",
                        values: IconIntent.allCases,
                        value: self.$intent)

                    // Size
                    EnumSelector(
                        title: "Size",
                        dialogTitle: "Select a Size",
                        values: IconSize.allCases,
                        value: self.$size)
                }

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()


                IconView(
                    theme: SparkTheme.shared,
                    intent: self.intent,
                    size: self.size,
                    iconImage: Image("alert")
                )

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitle(Text("Icon"))
    }
}

struct IconComponentView_Previews: PreviewProvider {
    static var previews: some View {
        IconComponentView()
    }
}
