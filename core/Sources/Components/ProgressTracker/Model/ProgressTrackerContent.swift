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

// A model representing the content of a single Progress Tracker Indicator
protocol ProgressTrackerContentIndicating {
    associatedtype ImageType
    associatedtype TextType
    var indicatorImage: ImageType? { get set }
    var label: Character? { get set }

    init()
}

// The UIKit progress tracker indicator 
struct ProgressTrackerUIIndicatorContent: ProgressTrackerContentIndicating {
    typealias TextType = NSAttributedString

    var indicatorImage: UIImage?
    var label: Character?
}

struct ProgressTrackerIndicatorContent: ProgressTrackerContentIndicating {
    typealias TextType = AttributedString

    var indicatorImage: Image?
    var label: Character?
}

struct ProgressTrackerContent<ComponentContent: ProgressTrackerContentIndicating> {
    var numberOfPages: Int
    var showDefaultPageNumber: Bool 
    var currentPage: Int
    var preferredIndicatorImage: ComponentContent.ImageType?
    var preferredCurrentPageIndicatorImage:  ComponentContent.ImageType?
    var visitedPageIndicatorImage: ComponentContent.ImageType?
    private var content = [Int: ComponentContent]()
    private var currentPageIndicator = [Int: ComponentContent.ImageType]()
    var labels = [Int: ComponentContent.TextType?]()

    var hasLabel: Bool {
        return labels.reduce(false) { (partialResult, arg1) in
            let (_, value) = arg1
            return partialResult || value != nil
        }
    }

    init(
        numberOfPages: Int,
        currentPage: Int,
        showDefaultPageNumber: Bool = true,
        preferredIndicatorImage: ComponentContent.ImageType? = nil,
        preferredCurrentPageIndicatorImage: ComponentContent.ImageType? = nil,
        visitedPageIndicatorImage: ComponentContent.ImageType? = nil)
    {
        self.numberOfPages = numberOfPages
        self.currentPage = currentPage
        self.showDefaultPageNumber = showDefaultPageNumber
        self.preferredIndicatorImage = preferredIndicatorImage
        self.visitedPageIndicatorImage = visitedPageIndicatorImage
        self.preferredCurrentPageIndicatorImage = preferredCurrentPageIndicatorImage
    }

    func content(ofIndex index: Int) -> ComponentContent {
        var content: ComponentContent

        if let pageContent = self.content[index] {
            content = pageContent
        } else {
            content = .init()
        }

        if content.label == nil && self.showDefaultPageNumber {
            content.label = "\(index + 1)".first
        }

        if index == self.currentPage {
            if let currentPageImage = self.currentPageIndicator[index]  {
                content.indicatorImage = currentPageImage
            } else if let currentPageImage = self.preferredCurrentPageIndicatorImage {
                content.indicatorImage = currentPageImage
            } else if content.indicatorImage == nil {
                content.indicatorImage = self.preferredIndicatorImage
            }
        } else if index < self.currentPage, content.indicatorImage == nil {
            content.indicatorImage =  self.visitedPageIndicatorImage ?? self.preferredIndicatorImage
        } else if content.indicatorImage == nil {
            content.indicatorImage = self.preferredIndicatorImage
        }

        return content
    }

    mutating func setIndicatorImage(_ image: ComponentContent.ImageType?, forIndex index: Int) {
        var content: ComponentContent

        if let pageContent = self.content[index] {
            content = pageContent
        } else {
            content = .init()
        }
        content.indicatorImage = image
        self.content[index] = content
    }

    mutating func setCurrentPageIndicatorImage(_ image: ComponentContent.ImageType?, forIndex index: Int) {

        self.currentPageIndicator[index] = image
    }

    mutating func setAttributedLabel(_ attributedLabel: ComponentContent.TextType?, forIndex index: Int) {
        self.labels[index] = attributedLabel
    }

    func getAttributedLabel(ofIndex index: Int) -> ComponentContent.TextType? {
        return self.labels[index].flatMap{ $0 }
    }

    mutating func setContentLabel(_ label: Character?, ofIndex index: Int) {
        var content: ComponentContent

        if let pageContent = self.content[index] {
            content = pageContent
        } else {
            content = .init()
        }
        content.label = label
        self.content[index] = content
    }
}
