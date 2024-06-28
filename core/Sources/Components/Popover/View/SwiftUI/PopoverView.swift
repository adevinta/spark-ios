//
//  PopoverView.swift
//  SparkCore
//
//  Created by louis.borlee on 27/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

@available(iOS 16.4, *)
struct PopoverView<Content>: View where Content: View {

    private let viewModel: PopoverViewModel
    private let content: (PopoverColors) -> Content

    init(
        theme: Theme,
        intent: PopoverIntent,
        showArrow: Bool,
        content: @escaping (PopoverColors) -> Content
    ) {
        self.viewModel = .init(theme: theme, intent: intent, showArrow: showArrow)
        self.content = content
    }

    var body: some View {
        ZStack {
            self.viewModel.colors.background.color
                .scaleEffect(1.5)  // Needed to fill the arrow
            self.content(self.viewModel.colors)
                .padding(
                    EdgeInsets(
                        vertical: self.viewModel.spaces.vertical,
                        horizontal: self.viewModel.spaces.horizontal
                    )
                )
        }
        .presentationCompactAdaptation(.popover)
    }
}
