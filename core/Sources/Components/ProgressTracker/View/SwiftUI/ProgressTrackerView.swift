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

    @ObservedObject private var viewModel: ProgressTrackerViewModel<ProgressTrackerIndicatorContent>
    private let intent: ProgressTrackerIntent
    private let variant: ProgressTrackerVariant
    private let size: ProgressTrackerSize
    @Binding var currentPageIndex: Int

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
        if self.viewModel.orientation == .horizontal {
            ProgressTrackerHorizontalView(intent: self.intent, variant: self.variant, size: self.size, currentPageIndex: self.$currentPageIndex, viewModel: self.viewModel)
        } else {
            ProgressTrackerVerticalView(intent: self.intent, variant: self.variant, size: self.size, currentPageIndex: self.$currentPageIndex, viewModel: self.viewModel)
        }
    }

}

class IndicatorPositions: ObservableObject {
    var positions = [Int: CGRect]()

    private var updateCount = 0
    @Published var pageCount: Int = 0

    func setNormalized(_ rect: CGRect, for index: Int) {
        let normalizedRect = CGRect(x: max(rect.origin.x, 0), y: max(rect.origin.y, 0), width: rect.width, height: rect.height)

        print("SET x: \(normalizedRect.origin.x), y: \(normalizedRect.origin.y)")
        positions[index] = normalizedRect
    }

    func updateNormalized(_ rect: CGRect, for index: Int) {
        let normalizedRect = CGRect(x: max(rect.origin.x, 0), y: max(rect.origin.y, 0), width: rect.width, height: rect.height)

        print("SET x: \(normalizedRect.origin.x), y: \(normalizedRect.origin.y)")
        positions[index] = normalizedRect

        self.updateCount += 1
        if self.pageCount > 0 && self.updateCount == self.pageCount {
            self.pageCount = self.updateCount
            self.updateCount = 0
        }
    }
}

extension CGRect {
    var normalized: CGRect {
        return CGRect(x: max(self.origin.x, 0), y: max(self.origin.y, 0), width: self.width, height: self.height)
    }
}
