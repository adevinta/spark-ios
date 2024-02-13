//
//  ProgressTrackerView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 15.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

public struct ProgressTrackerView: View {
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

    private var trackIndicatorSpacing: CGFloat {
        return self.viewModel.spacings.trackIndicatorSpacing * self.scaleFactor
    }

    public init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize,
        labels: [String],
        orientation: ProgressTrackerOrientation = .horizontal,
        currentPageIndex: Binding<Int>
    ) {
        var content = Content(numberOfPages: labels.count)
        content.currentPageIndex = currentPageIndex.wrappedValue
        for (index, label) in labels.enumerated() {
            content.setAttributedLabel(AttributedString(stringLiteral: label), atIndex: index)
        }

        self.init(theme: theme, intent: intent, variant: variant, size: size, orientation: orientation, currentPageIndex: currentPageIndex, content: content)
    }

    public init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize,
        numberOfPages: Int,
        orientation: ProgressTrackerOrientation = .horizontal,
        currentPageIndex: Binding<Int>
    ) {
        var content = Content(numberOfPages: numberOfPages)
        content.currentPageIndex = currentPageIndex.wrappedValue

        self.init(theme: theme, intent: intent, variant: variant, size: size, orientation: orientation, currentPageIndex: currentPageIndex, content: content)
    }

    init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize,
        orientation: ProgressTrackerOrientation = .horizontal,
        currentPageIndex: Binding<Int>,
        content: Content
    ) {
        let viewModel = ProgressTrackerViewModel<ProgressTrackerIndicatorContent>(
            theme: theme,
            orientation: orientation,
            content: content)

        self.viewModel = viewModel
        self.variant = variant
        self.size = size
        self.intent = intent
        self._currentPageIndex = currentPageIndex
    }

    public var body: some View {
        content
            .coordinateSpace(name: AccessibilityIdentifier.identifier)
            .onAppear {
                self.indicatorPositions.pageCount = self.viewModel.numberOfPages
            }

    }

    @ViewBuilder
    private var content: some View {
        if self.viewModel.orientation == .horizontal {
            self.horizontalLayout()
        } else {
            self.verticalLayout()
        }
    }

    @ViewBuilder 
    private func horizontalLayout() -> some View {
        HStack(alignment: .top, spacing: self.spacing ) {
            ForEach((0..<self.viewModel.content.numberOfPages), id: \.self) { index in
                VStack(alignment: .center) {
                    self.content(at: index)
                }
            }
        }
        .background(alignment: .topLeading) {
            self.dashedLines()
        }
    }

    @ViewBuilder
    private func dashedLines() -> some View {
        ZStack(alignment: .topLeading) {
            let interval: Range<Int> = (0..<max(self.indicatorPositions.pageCount-1, 0))

            ForEach(interval, id: \.self) { index in
                if let position = self.indicatorPositions.positions[index],
                   let nextPosition = self.indicatorPositions.positions[index+1]
                {
                    ProgressTrackerTrackView(
                        theme: self.viewModel.theme,
                        intent: self.intent,
                        orientation: self.viewModel.orientation)
                    .frame(width: nextPosition.minX - (position.maxX + self.trackIndicatorSpacing * 2))
                    .padding(.leading, position.maxX + self.trackIndicatorSpacing)
                    .padding(.top, position.midY)
                } else {
                    EmptyView()
                }
            }

//            ForEach(interval, id: \.self) { index in
//                if let position = self.indicatorPositions.positions[index],
//                   let nextPosition = self.indicatorPositions.positions[index+1]
//                {
//                    ProgressTrackerTrackView(
//                        theme: self.viewModel.theme,
//                        intent: self.viewModel.intent,
//                        orientation: self.viewModel.orientation)
//                        .frame(width: nextPosition.minX - position.maxX)
//                        .padding(.leading, position.maxX)
//                        .padding(.top, position.midY)
//                } else {
//                    EmptyView()
//                }
//            }
        }

    }

    @ViewBuilder
    private func verticalLayout() -> some View {
        VStack(alignment: .leading, spacing: self.spacing) {
            ForEach((0..<self.viewModel.content.numberOfPages), id: \.self) { index in
                HStack(alignment: .xAlignment) {
                    self.indicator(at: index)
                        .alignmentGuide(.xAlignment) { $0.height / 2 }
                    if let label = self.viewModel.content.getAttributedLabel(atIndex: index)  {
                        self.label(label, at: index)
                            .alignmentGuide(.xAlignment) { ($0.height - ($0[.lastTextBaseline] - $0[.firstTextBaseline])) / 2 }
                    }
                }
            }
        }
        .background {
            ForEach((0..<self.indicatorPositions.pageCount), id: \.self) { index in
                let _ = self.indicatorPositions.positions[index]
                let _ = print("GET \(index) \(self.indicatorPositions.positions[index])")
                Rectangle().fill(Color.blue).frame(width: 1)
                    .padding(.leading, 5.0)
            }
        }
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
        .overlay {
            GeometryReader { geo in
                let _ = print("SET \(index) \(geo.frame(in: .named(AccessibilityIdentifier.identifier)))")
                let _ = self.indicatorPositions.setNormalized(geo.frame(in: .named(AccessibilityIdentifier.identifier)), for: index)
                Color.clear
            }
        }
    }
}

extension VerticalAlignment {
    private enum XAlignment : AlignmentID {
        static func defaultValue(in dimension: ViewDimensions) -> CGFloat {
            return dimension[VerticalAlignment.top]
        }
    }
    static let xAlignment = VerticalAlignment(XAlignment.self)
}


class IndicatorPositions: ObservableObject {
    var positions = [Int: CGRect]()

    @Published var pageCount: Int = 0

    func setNormalized(_ rect: CGRect, for index: Int) {
        let normalzedRect = CGRect(x: max(rect.origin.x, 0), y: max(rect.origin.y, 0), width: rect.width, height: rect.height)

//        print("\(index): \(normalzedRect)")
        positions[index] = normalzedRect
    }
}
