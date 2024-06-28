//
//  PopoverDemoView.swift
//  SparkCore
//
//  Created by louis.borlee on 27/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore

@available(iOS 16.4, *)
struct PopoverDemoView: View {

    private let theme = SparkTheme()

    var body: some View {
        ForEach(PopoverIntent.allCases, id: \.self) { intent in
            let colors = intent.getColors(theme: theme)
            PopoverDemoItem(intent: intent, colors: colors)
        }
        .buttonStyle(.borderedProminent)
    }
}

@available(iOS 16.4, *)
struct PopoverDemoItem: View {
    let intent: PopoverIntent
    let colors: PopoverColors
    @State var isPresented: Bool = false

    var body: some View {
        Button(intent.name) {
            isPresented = true
        }
        .tint(colors.background.color)
        .foregroundStyle(colors.foreground.color)
        .popover(theme: SparkTheme(), intent: intent, isPresented: $isPresented) { colors in
            Text("This is a label that should be multiline, depending on the content size. This is a label that should be multiline, depending on the content size.")
                .foregroundStyle(colors.foreground.color)
                .frame(width: 300)
        }

    }
}
