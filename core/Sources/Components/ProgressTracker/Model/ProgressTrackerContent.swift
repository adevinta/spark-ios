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

public protocol ProgressTrackerContenting {
    associatedtype ImageType
    associatedtype TextType
    var indicatorImage: ImageType? { get set }
    var currentPageIndicatorImage: ImageType? { get set }
    var attributedLabel: TextType? { get set }
    var label: String? { get set }
    var contentLabel: String? { get set}
}

public struct ProgressTrackerUIItemContent: ProgressTrackerContenting {
    public var indicatorImage: UIImage?
    public var currentPageIndicatorImage: UIImage?
    public var attributedLabel: NSAttributedString?
    public var label: String?
    public var contentLabel: String?
}

public struct ProgressTrackerItemContent: ProgressTrackerContenting {
    public var indicatorImage: Image?
    public var currentPageIndicatorImage: Image?
    public var attributedLabel: AttributedString?
    public var label: String?
    public var contentLabel: String?
}

public struct ProgressTrackerContent<ComponentContent: ProgressTrackerContenting> {
    let numberOfPages: Int
    let showDefaultPageNumber: Bool
    var preferredIndicatorImage: ComponentContent.ImageType?
    var content = [Int: ComponentContent]()

    public init(
        numberOfPages: Int,
        showDefaultPageNumber: Bool,
        preferredIndicatorImage: ComponentContent.ImageType? = nil,
        content: [Int: ComponentContent] = [Int: ComponentContent]())
    {
        self.numberOfPages = numberOfPages
        self.showDefaultPageNumber = showDefaultPageNumber
        self.preferredIndicatorImage = preferredIndicatorImage
        self.content = content
    }

    mutating func setIndicatorImage(_ image: ComponentContent.ImageType?, forPage page: Int) {
        var pageContent = content[page]
        content[page]?.indicatorImage = image
    }

    mutating func setCurrentPageIndicatorImage(_ image: ComponentContent.ImageType?, forPage page: Int) {
        content[page]?.currentPageIndicatorImage = image
    }

    mutating func setAttributedLabel(_ attributedLabel: ComponentContent.TextType?, forPage page: Int) {
        content[page]?.attributedLabel = attributedLabel
    }

    mutating func setLabel(_ label: String?, forPage page: Int) {
        content[page]?.label = label
    }

    mutating func setContentLabel(_ label: String?, forPage page: Int) {
        content[page]?.label = label
    }
}
