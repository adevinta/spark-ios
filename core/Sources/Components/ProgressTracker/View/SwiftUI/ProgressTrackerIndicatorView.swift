//
//  ProgressTrackerIndicatorView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 13.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import SparkTheming

/// The indicator view is the round indicator which may contain text (max 2 characters) or an image.
struct ProgressTrackerIndicatorView: View {
    @ObservedObject private var viewModel: ProgressTrackerIndicatorViewModel<ProgressTrackerIndicatorContent>

    @ScaledMetric var scaleFactor: CGFloat = 1.0

    private var imageHeight: CGFloat {
        return self.scaleFactor * ProgressTrackerConstants.iconHeight
    }

    private var borderWidth: CGFloat {
        return self.scaleFactor * ProgressTrackerConstants.borderWidth
    }

    //MARK: - Initialization
    init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize,
        content: ProgressTrackerIndicatorContent) {
            let viewModel = ProgressTrackerIndicatorViewModel<ProgressTrackerIndicatorContent>(

                theme: theme,
                intent: intent,
                variant: variant,
                size: size,
                content: content,
                state: .normal
            )

            self.viewModel = viewModel
    }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {

            Circle()
                .fill(self.viewModel.colors.background.color)

            if self.viewModel.size != .small {
                if let image = self.viewModel.content.indicatorImage {
                    image.resizable()
                        .renderingMode(.template)
                        .foregroundStyle(self.viewModel.colors.content.color)
                        .scaledToFit()
                        .frame(
                            width: self.imageHeight,
                            height: self.imageHeight
                        )
                } else if let label = self.viewModel.content.label {
                    Text(String(label))
                        .font(self.viewModel.font.font)
                        .foregroundStyle(self.viewModel.colors.content.color)
                }
            }

            Circle()
                .strokeBorder(
                    self.viewModel.colors.outline.color,
                    lineWidth: self.borderWidth
                )
        }
        .frame(width: self.viewModel.size.rawValue * self.scaleFactor, height: self.viewModel.size.rawValue * self.scaleFactor)
        .compositingGroup()
        .opacity(self.viewModel.opacity)
    }

    //MARK: Modifiers
    func highlighted(_ isHighlighted: Bool) -> Self {
        self.viewModel.set(highlighted: isHighlighted)
        return self
    }

    func selected(_ isSelected: Bool) -> Self {
        self.viewModel.set(selected: isSelected)
        return self
    }

    func disabled(_ isDisabled: Bool) -> some View {
        self.viewModel.set(enabled: !isDisabled)
        return self
    }

}
