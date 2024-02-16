//
//  ProgressTrackerHorizontalView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 16.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

struct ProgressTrackerHorizontalView: View {
    typealias Content = ProgressTrackerContent<ProgressTrackerIndicatorContent>
    typealias AccessibilityIdentifier = ProgressTrackerAccessibilityIdentifier

    private let viewModel: ProgressTrackerViewModel<ProgressTrackerIndicatorContent>
    private let intent: ProgressTrackerIntent
    private let variant: ProgressTrackerVariant
    private let size: ProgressTrackerSize
    @ScaledMetric private var scaleFactor = 1.0
    @StateObject private var indicatorPositions = IndicatorPositions()
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

    var body: some View {
        self.horizontalLayout()
            .coordinateSpace(name: AccessibilityIdentifier.identifier)
            .onAppear {
                print("BODY ON APPEAR")
                self.indicatorPositions.pageCount = self.viewModel.numberOfPages
            }
            .onChange(of: self.viewModel.content) { viewModel in
                print("BODY ON CHANGE")
                self.indicatorPositions.pageCount = viewModel.numberOfPages
            }

    }

    @ViewBuilder
    private func horizontalLayout() -> some View {
        HStack(alignment: .top, spacing: self.spacing ) {
            ForEach((0..<self.viewModel.content.numberOfPages), id: \.self) { index in
                VStack(alignment: .center) {
                    self.content(at: index)
                }
                .onAppear{
                    print("VSTACK ON APPEAR")
                }
            }
            .onAppear{
                print("FOREACH ON APPEAR")
            }

        }
        .onAppear{
            print("HORIZONTAL ON APPEAR")
        }
        .background(alignment: .topLeading) {
            self.dashedHorizontalLines()
        }
    }

    @ViewBuilder
    private func dashedHorizontalLines() -> some View {
        ZStack(alignment: .topLeading) {
            let interval: Range<Int> = (0..<max(self.indicatorPositions.pageCount-1, 0))

            ForEach(interval, id: \.self) { index in
                if let position = self.indicatorPositions.positions[index],
                   let nextPosition = self.indicatorPositions.positions[index+1]
                {
                    self.track()
                        .frame(width: nextPosition.minX - (position.maxX + self.trackIndicatorSpacing * 2))
                        .padding(.leading, position.maxX + self.trackIndicatorSpacing)
                        .padding(.top, position.midY)
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
        .onAppear{ print("INDICATOR ON APPEAR") }
        .overlay {
            GeometryReader { geo in
                let _ = self.indicatorPositions.setNormalized(geo.frame(in: .named(AccessibilityIdentifier.identifier)), for: index)
                Color.clear.onAppear()
            }
        }
    }
}

