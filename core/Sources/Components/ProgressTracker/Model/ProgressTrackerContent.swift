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
    var label: String? { get set }

    init()
}

// The UIKit progress tracker indicator 
struct ProgressTrackerUIIndicatorContent: ProgressTrackerContentIndicating {
    typealias TextType = NSAttributedString

    var indicatorImage: UIImage?
    var label: String?
}

struct ProgressTrackerIndicatorContent: ProgressTrackerContentIndicating {
    typealias TextType = AttributedString

    var indicatorImage: Image?
    var label: String?
}

final class ProgressTrackerContent<ComponentContent: ProgressTrackerContentIndicating> {
    let numberOfPages: Int
    let showDefaultPageNumber: Bool
    var currentPage: Int
    var preferredIndicatorImage: ComponentContent.ImageType?
    var preferredCurrentPageIndicatorImage:  ComponentContent.ImageType?
    var visitedPageIndicatorImage: ComponentContent.ImageType?
    private var content = [Int: ComponentContent]()
    private var currentPageIndicator = [Int: ComponentContent.ImageType]()
    var labels = [Int: ComponentContent.TextType?]()

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

    func content(ofPage page: Int) -> ComponentContent {
        var content: ComponentContent

        if let pageContent = self.content[page] {
            content = pageContent
        } else {
            content = .init()
            self.content[page] = content
        }

        if content.label == nil && self.showDefaultPageNumber {
            content.label = "\(page)"
        }

        if page == self.currentPage {
            if let currentPageImage = self.currentPageIndicator[page]  {
                content.indicatorImage = currentPageImage
            } else if let currentPageImage = self.preferredCurrentPageIndicatorImage {
                content.indicatorImage = currentPageImage
            } else if content.indicatorImage == nil {
                content.indicatorImage = self.preferredIndicatorImage
            }
        } else if page < self.currentPage, content.indicatorImage == nil {
            content.indicatorImage =  self.visitedPageIndicatorImage ?? self.preferredIndicatorImage
        } else if content.indicatorImage == nil {
            content.indicatorImage = self.preferredIndicatorImage
        }

        return content
    }

    func setIndicatorImage(_ image: ComponentContent.ImageType?, forPage page: Int) {
        var content: ComponentContent

        if let pageContent = self.content[page] {
            content = pageContent
        } else {
            content = .init()
        }
        content.indicatorImage = image
        self.content[page] = content
    }

    func setCurrentPageIndicatorImage(_ image: ComponentContent.ImageType?, forPage page: Int) {

        self.currentPageIndicator[page] = image
    }

    func setAttributedLabel(_ attributedLabel: ComponentContent.TextType?, forPage page: Int) {
        self.labels[page] = attributedLabel
    }

    func getAttributedLabel(forPage page: Int) -> ComponentContent.TextType? {
        return self.labels[page].flatMap{ $0 }
    }

    func setContentLabel(_ label: String?, forPage page: Int) {
        var content: ComponentContent

        if let pageContent = self.content[page] {
            content = pageContent
        } else {
            content = .init()
        }
        content.label = label
        self.content[page] = content
    }
}
