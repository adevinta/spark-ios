//
//  ProgressTrackerIndicatorView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 13.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

struct ProgressTrackerIndicatorView: View {

    typealias AccessibilityIdentifier = ProgressTrackerAccessibilityIdentifier

    @ObservedObject private var viewModel: ProgressTrackerIndicatorViewModel<ProgressTrackerIndicatorContent>

    @ScaledMetric var scaleFactor: CGFloat = 1.0

    private var borderWidth: CGFloat {
        return self.scaleFactor * ProgressTrackerConstants.borderWidth
    }

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
    
    var body: some View {

        GeometryReader { geo in

            ZStack(alignment: .center) {

                Circle()
                    .fill(self.viewModel.colors.background.color)

                if let image = self.viewModel.content.indicatorImage {
                    image
                } else if let label = self.viewModel.content.label {
                    Text(String(label))
                        .font(self.viewModel.font.font)
                        .foregroundStyle(self.viewModel.colors.content.color)
                }

                Circle()
                    .strokeBorder(
                        self.viewModel.colors.outline.color,
                        lineWidth: self.borderWidth
                    )
            }
            .onAppear {
                print("INDICATOR GEO ON APPEAR \(geo.frame(in: .named(AccessibilityIdentifier.identifier)))")
            }
        }
        .frame(width: self.viewModel.size.rawValue * self.scaleFactor, height: self.viewModel.size.rawValue * self.scaleFactor)
        .compositingGroup()
        .opacity(self.viewModel.opacity)
        .isEnabledChanged{ isEnabled in
            self.viewModel.set(enabled: isEnabled)
        }

    }

    func highlighted(_ isHighlighted: Bool) -> Self {
        self.viewModel.set(highlighted: isHighlighted)
        return self
    }

    func selected(_ isSelected: Bool) -> Self {
        self.viewModel.set(selected: isSelected)
        return self
    }

}
