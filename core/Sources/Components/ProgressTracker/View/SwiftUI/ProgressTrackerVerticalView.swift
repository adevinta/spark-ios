//
//  ProgressTrackerVerticalView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 16.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

/// A progress tracker with a horizontal layout
struct ProgressTrackerVerticalView: View {
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

    private var verticalStackSpacing: CGFloat {
        return (self.trackIndicatorSpacing * 2.0) + self.trackSize
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
            self.verticalLayout()
                .coordinateSpace(name: AccessibilityIdentifier.identifier)
        }
        .overlayPreferenceValue(ProgressTrackerSizePreferences.self) { preferences in
            self.verticalTracks(preferences: preferences)
        }
    }

    // MARK: - Private functions
    @ViewBuilder
    private func verticalLayout() -> some View {
        VStack(alignment: .leading, spacing: self.verticalStackSpacing) {
            ForEach((0..<self.viewModel.content.numberOfPages), id: \.self) { index in
                self.pageContent(at: index)
                    .frame(maxHeight: .infinity)
                    .disabled(!self.viewModel.isEnabled(at: index))
                    .accessibilityAttributes(viewModel: self.viewModel, index: index)
            }
        }
    }

    @ViewBuilder
    private func pageContent(at index: Int) -> some View {
        HStack(alignment: .xAlignment) {
            self.indicator(at: index)
                .alignmentGuide(.xAlignment) { $0.height / 2 }

            if let label = self.viewModel.content.getAttributedLabel(atIndex: index)  {
                self.label(label, at: index)
                    .fixedSize(horizontal: false, vertical: true)
                    .alignmentGuide(.xAlignment) { ($0.height - ($0[.lastTextBaseline] - $0[.firstTextBaseline])) / 2 }
            }
        }
    }

    @ViewBuilder
    private func verticalTracks(preferences: [Int: CGRect]) -> some View {
        let trackSpacing = self.trackIndicatorSpacing
        GeometryReader { geometry in
            ForEach((1..<self.viewModel.numberOfPages), id: \.self) { key in
                if let rect = preferences[key], let previousRect = preferences[key - 1] {
                    let height = previousRect.yDistance(to: rect, offset: trackSpacing)
                    self.track()
                        .disabled(!self.viewModel.isEnabled(at: key))
                        .frame(height: height)
                        .offset(
                            x: rect.width / 2,
                            y: previousRect.maxY + trackSpacing
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
        self.indicator(at: index)

        if let label = self.viewModel.content.getAttributedLabel(atIndex: index)  {
            self.label(label, at: index)
        }
    }

    @ViewBuilder
    private func label(_ label: AttributedString, at index: Int) -> some View {
        Text(label)
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

/// Alignment guide for the label and the indicator. The first line of the label is to be aligned centrally with the indicator.
private extension VerticalAlignment {
    private enum XAlignment: AlignmentID {
        static func defaultValue(in dimension: ViewDimensions) -> CGFloat {
            return dimension[VerticalAlignment.top]
        }
    }
    static let xAlignment = VerticalAlignment(XAlignment.self)
}

/// Vertical distance from one point to the next including an offset.
private extension CGRect {
    func yDistance(to other: CGRect, offset: CGFloat = 0) -> CGFloat {
        return max((other.minY - self.maxY) - (offset * 2.0), 0)
    }
}
