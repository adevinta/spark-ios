//
//  ProgressTrackerHorizontalView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 16.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

/// A progress tracker with a horizontal layout
struct ProgressTrackerHorizontalView: View {
    typealias Content = ProgressTrackerContent<ProgressTrackerIndicatorContent>
    typealias AccessibilityIdentifier = ProgressTrackerAccessibilityIdentifier

    @ObservedObject private var viewModel: ProgressTrackerViewModel<ProgressTrackerIndicatorContent>
    private let intent: ProgressTrackerIntent
    private let variant: ProgressTrackerVariant
    private let size: ProgressTrackerSize
    @ScaledMetric private var scaleFactor = 1.0
    @Binding var currentPageIndex: Int

    private var spacing: CGFloat {
        return self.viewModel.spacings.minLabelSpacing * self.scaleFactor
    }

    private var trackSize: CGFloat {
        return 1.0 * scaleFactor
    }

    private var trackIndicatorSpacing: CGFloat {
        return self.viewModel.spacings.trackIndicatorSpacing * self.scaleFactor
    }

    // MARK: - Initialization
    init(
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize,
        currentPageIndex: Binding<Int>,
        viewModel: ProgressTrackerViewModel<ProgressTrackerIndicatorContent>
    ) {
        self.viewModel = viewModel
        self.variant = variant
        self.size = size
        self.intent = intent
        self._currentPageIndex = currentPageIndex
    }

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            self.horizontalLayout()
                .coordinateSpace(name: AccessibilityIdentifier.identifier)
        }
        .overlayPreferenceValue(ProgressTrackerSizePreferences.self) { preferences in
            self.horizontalTracks(preferences: preferences)
        }
    }

    // MARK: - Private functions
    @ViewBuilder
    private func horizontalLayout() -> some View {
        HStack(alignment: .top, spacing: self.spacing) {
            ForEach((0..<self.viewModel.numberOfPages), id: \.self) { index in
                let content = self.content(at: index)
                    .accessibilityAttributes(viewModel: self.viewModel, index: index)
                    .disabled(!self.viewModel.isEnabled(at: index))

                if self.viewModel.useFullWidth {
                    content
                        .frame(maxWidth: .infinity)
                } else {
                    content
                }
            }
        }
    }

    @ViewBuilder
    private func horizontalTracks(preferences: [Int: CGRect]) -> some View {
        let trackSpacing = self.trackIndicatorSpacing
        GeometryReader { geometry in
            ForEach((1..<self.viewModel.numberOfPages), id: \.self) { key in
                if let rect = preferences[key], let previousRect = preferences[key - 1] {
                    let width = previousRect.xDistance(to: rect, offset: trackSpacing)
                    self.track()
                        .disabled(!self.viewModel.isEnabled(at: key))
                        .frame(width: width)
                        .offset(
                            x: previousRect.maxX + trackSpacing,
                            y: (rect.height / 2) + rect.minY
                        )
                } else {
                    EmptyView()
                }
            }
        }
    }

    @ViewBuilder
    private func track() -> ProgressTrackerTrackView {
        ProgressTrackerTrackView(
            theme: self.viewModel.theme,
            intent: self.intent,
            orientation: self.viewModel.orientation)
    }

    @ViewBuilder
    private func content(at index: Int) -> some View {
        VStack(alignment: .center) {
            if let label = self.viewModel.content.getAttributedLabel(atIndex: index)  {
                self.indicator(at: index)
                self.label(label, at: index)
            } else {
                self.indicator(at: index)
                    .accessibilityLabel(self.viewModel.content.getIndicatorAccessibilityLabel(atIndex: index))
            }
        }
    }

    @ViewBuilder
    private func label(_ label: AttributedString, at index: Int) -> some View {
        Text(label)
            .multilineTextAlignment(.center)
            .font(self.viewModel.font.font)
            .foregroundStyle(self.viewModel.labelColor.color)
            .opacity(self.viewModel.labelOpacity(forIndex: index))
    }

    @ViewBuilder
    private func indicator(at index: Int) -> some View {
        ProgressTrackerIndicatorView(
            theme: self.viewModel.theme,
            intent: self.intent,
            variant: self.variant,
            size: self.size,
            content: self.viewModel.content.pageContent(atIndex: index))
        .selected(self.viewModel.isSelected(at: index))
        .highlighted(self.viewModel.isHighlighted(at: index))
        .disabled(!self.viewModel.isEnabled(at: index))
        .overlay {
            GeometryReader { geo in
                Color.clear.anchorPreference(key: ProgressTrackerSizePreferences.self, value: .bounds) { anchor in
                    [index: geo.frame(in: .named(AccessibilityIdentifier.identifier)).normalized]
                }
            }
        }
    }
}

private extension View {
    func accessibilityAttributes(viewModel: ProgressTrackerViewModel<ProgressTrackerIndicatorContent>, index: Int) -> some View {
        return modifier(ProgressTrackerAccessibilityTraitsViewModifier(viewModel: viewModel, index: index))
    }
}

/// Horizontal distance from one point to the other including an offset.
private extension CGRect {
    func xDistance(to other: CGRect, offset: CGFloat = 0) -> CGFloat {
        return max((other.minX - self.maxX) - (offset * 2.0), 0)
    }
}
