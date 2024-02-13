//
//  ProgressTrackerContent.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 22.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

/// A model representing the content of a single Progress Tracker Indicator
protocol ProgressTrackerContentIndicating {
    associatedtype ImageType
    associatedtype TextType
    var indicatorImage: ImageType? { get set }
    var label: String? { get set }

    init()
}

/// The content model of the UIKit progress tracker indicator
struct ProgressTrackerUIIndicatorContent: ProgressTrackerContentIndicating, Equatable {
    typealias TextType = NSAttributedString

    var indicatorImage: UIImage?
    var label: String?
}

/// The content model of tje SwiftUI progress tracker indicator
struct ProgressTrackerIndicatorContent: ProgressTrackerContentIndicating, Equatable {
    typealias TextType = AttributedString

    var indicatorImage: Image?
    var label: String?
}

/// A model representing the content of a progress tracker.
struct ProgressTrackerContent<ComponentContent: ProgressTrackerContentIndicating> where ComponentContent: Equatable {
    var numberOfPages: Int {
        didSet {
            self.currentPageIndex = min(self.currentPageIndex, self.numberOfPages - 1)
        }
    }
    var showDefaultPageNumber: Bool
    var currentPageIndex: Int {
        didSet {
            self.currentPageIndex = min(max(self.currentPageIndex, 0), self.numberOfPages - 1)
        }
    }
    var preferredIndicatorImage: ComponentContent.ImageType?
    var preferredCurrentPageIndicatorImage:  ComponentContent.ImageType?
    var completedPageIndicatorImage: ComponentContent.ImageType?
    private var content = [Int: ComponentContent]()
    private var currentPageIndicator = [Int: ComponentContent.ImageType]()
    var labels = [Int: ComponentContent.TextType]()

    /// Returns true, if the content contains a label
    var hasLabel: Bool {
        return self.numberOfLabels > 0
    }

    /// The number of labels
    var numberOfLabels: Int {
        return labels.values.reduce(0) { (partialResult, value) in
            return partialResult + 1
        }
    }

    // MARK: - Initialization
    init(
        numberOfPages: Int,
        currentPageIndex: Int = 0,
        showDefaultPageNumber: Bool = true,
        preferredIndicatorImage: ComponentContent.ImageType? = nil,
        preferredCurrentPageIndicatorImage: ComponentContent.ImageType? = nil,
        completedPageIndicatorImage: ComponentContent.ImageType? = nil)
    {
        self.numberOfPages = numberOfPages
        self.currentPageIndex = currentPageIndex
        self.showDefaultPageNumber = showDefaultPageNumber
        self.preferredIndicatorImage = preferredIndicatorImage
        self.completedPageIndicatorImage = completedPageIndicatorImage
        self.preferredCurrentPageIndicatorImage = preferredCurrentPageIndicatorImage
    }

    /// A function which determines, that so much content has changed, that the view needs to be setup again.
    /// The view needs to be setup from fresh, when the number of pages have changed, or the number of labels.
    func needsUpdateOfLayout(otherComponent content: Self) -> Bool {
        if content.numberOfPages != self.numberOfPages {
            return true
        }
        if content.numberOfLabels != self.numberOfLabels {
            return true
        }

        return false
    }

    /// Return the content for the indicator at that given index.
    func pageContent(atIndex index: Int) -> ComponentContent {
        var content: ComponentContent

        if let pageContent = self.content[index] {
            content = pageContent
        } else {
            content = .init()
        }

        if content.label == nil && self.showDefaultPageNumber {
            content.label = "\(index + 1)"
        }

        if index == self.currentPageIndex {
            if let currentPageImage = self.currentPageIndicator[index]  {
                content.indicatorImage = currentPageImage
            } else if let currentPageImage = self.preferredCurrentPageIndicatorImage {
                content.indicatorImage = currentPageImage
            } else if content.indicatorImage == nil {
                content.indicatorImage = self.preferredIndicatorImage
            }
        } else if index < self.currentPageIndex, let completedImage = self.completedPageIndicatorImage {
            content.indicatorImage = completedImage
        } else if content.indicatorImage == nil {
            content.indicatorImage = self.preferredIndicatorImage
        }

        return content
    }

    /// Set the indicator image at the specified index
    mutating func setIndicatorImage(_ image: ComponentContent.ImageType?, atIndex index: Int) {
        var content: ComponentContent

        if let pageContent = self.content[index] {
            content = pageContent
        } else {
            content = .init()
        }
        content.indicatorImage = image
        self.content[index] = content
    }

    /// Set the current page indicator image at the specified index
    mutating func setCurrentPageIndicatorImage(_ image: ComponentContent.ImageType?, atIndex index: Int) {

        self.currentPageIndicator[index] = image
    }

    /// Set an attribute label at the given index
    mutating func setAttributedLabel(_ attributedLabel: ComponentContent.TextType?, atIndex index: Int) {
        self.labels[index] = attributedLabel
    }

    /// Return the attributed label at the given index
    func getAttributedLabel(atIndex index: Int) -> ComponentContent.TextType? {
        return self.labels[index].flatMap{ $0 }
    }

    /// Set the indicator label at the given index
    mutating func setIndicatorLabel(_ label: String?, atIndex index: Int) {
        var content: ComponentContent

        var indicatorLabel: String?

        if let label = label {
            indicatorLabel = String(label.prefix(2))
        }

        if let pageContent = self.content[index] {
            content = pageContent
        } else {
            content = .init()
        }
        content.label = indicatorLabel
        self.content[index] = content
    }

    /// Return the indicator label at the given index
    func getIndicatorLabel(atIndex index:  Int) -> String? {
        return self.content[index]?.label
    }
}
