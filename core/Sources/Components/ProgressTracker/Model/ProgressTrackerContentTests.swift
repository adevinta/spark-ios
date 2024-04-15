//
//  ProgressTrackerContentTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 25.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class ProgressTrackerContentTests: XCTestCase {

    // MARK: - Tests
    func test_uses_default_label()  {
        // GIVEN
        let sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(numberOfPages: 2, currentPageIndex: 1, showDefaultPageNumber: true)

        // THEN
        XCTAssertEqual(sut.pageContent(atIndex: 0).label, "1", "Expected label to be 1")
        XCTAssertEqual(sut.pageContent(atIndex: 1).label
            , "2", "Expected label to be 1")
    }

    func test_uses_no_label()  {
        // GIVEN
        let sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(numberOfPages: 2, currentPageIndex: 1, showDefaultPageNumber: false)

        // THEN
        XCTAssertNil(sut.pageContent(atIndex: 0).label, "Expected label 1 to be nil")
        XCTAssertNil(sut.pageContent(atIndex: 1).label, "Expected label 2 to be nil")
    }

    func test_uses_set_indicator_label()  {
        // GIVEN
        var sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(numberOfPages: 2, currentPageIndex: 1, showDefaultPageNumber: false)

        // WHEN
        sut.setIndicatorLabel("X", atIndex: 0)
        XCTAssertEqual(sut.getIndicatorLabel(atIndex: 0), "X", "Expected indicator label to be X")

        sut.setIndicatorLabel("A", atIndex: 0)
        sut.setIndicatorLabel("B", atIndex: 1)

        // THEN
        XCTAssertFalse(sut.hasLabel, "Expected not to labels")
        XCTAssertEqual(sut.pageContent(atIndex: 0).label, "A", "Expected label 1 to be A")
        XCTAssertEqual(sut.pageContent(atIndex: 1).label, "B", "Expected label 2 to be B")
    }

    func test_indicator_label_max_length()  {
        // GIVEN
        var sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(numberOfPages: 2, currentPageIndex: 1, showDefaultPageNumber: false)

        // WHEN
        sut.setIndicatorLabel("XXX", atIndex: 0)

        // THEN
        XCTAssertEqual(sut.getIndicatorLabel(atIndex: 0), "XX", "Expected indicator label to be XX")

    }

    func test_uses_set_label()  {
        // GIVEN
        var sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(numberOfPages: 4, currentPageIndex: 1, showDefaultPageNumber: false)

        // WHEN
        sut.setAttributedLabel(NSAttributedString(string: "A"), atIndex: 0)
        sut.setAttributedLabel(NSAttributedString(string: "B"), atIndex: 1)
        sut.setAttributedLabel(nil, atIndex: 3)

        // THEN
        XCTAssertTrue(sut.hasLabel, "Expected hasLabel to be true")
        XCTAssertEqual(sut.numberOfLabels, 2, "Expected number of labels to be 2")
        XCTAssertEqual(sut.labels[0], NSAttributedString(string: "A"), "Expected label to be A")
        XCTAssertEqual(sut.labels[1], NSAttributedString(string: "B"), "Expected label 2 to be B")
    }

    func test_uses_preferred_image()  {
        // GIVEN
        let preferredImage = UIImage(systemName: "pencil")!
        let sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(numberOfPages: 2, currentPageIndex: 1, showDefaultPageNumber: false, preferredIndicatorImage: preferredImage)

        // THEN
        XCTAssertEqual(sut.pageContent(atIndex: 0).indicatorImage, preferredImage, "Expected image 1 to be preferred")
        XCTAssertEqual(sut.pageContent(atIndex: 1).indicatorImage, preferredImage, "Expected image 2 to be preferred")
    }

    func test_uses_preferred_current_page_image()  {
        // GIVEN
        let preferredImage = UIImage(systemName: "pencil")!
        let currentPagePreferredImage = UIImage(systemName: "lock.circle")
        let sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(
            numberOfPages: 2,
            currentPageIndex: 1,
            showDefaultPageNumber: false,
            preferredIndicatorImage: preferredImage,
            preferredCurrentPageIndicatorImage: currentPagePreferredImage
        )

        // THEN
        XCTAssertEqual(sut.pageContent(atIndex: 0).indicatorImage, preferredImage, "Expected image 1 to be preferred")
        XCTAssertEqual(sut.pageContent(atIndex: 1).indicatorImage, currentPagePreferredImage, "Expected image 2 to be currentPagePreferredImage")
    }

    func test_uses_image_set()  {
        // GIVEN
        let preferredImage = UIImage(systemName: "pencil")!
        let currentPagePreferredImage = UIImage(systemName: "lock.circle")
        let contentImage = UIImage(systemName: "pencil.circle")!

        var sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(
            numberOfPages: 3,
            currentPageIndex: 2,
            showDefaultPageNumber: false,
            preferredIndicatorImage: preferredImage,
            preferredCurrentPageIndicatorImage: currentPagePreferredImage
        )

        /// WHEN
        sut.setIndicatorImage(preferredImage, atIndex: 1)
        sut.setIndicatorImage(contentImage, atIndex: 1)
        sut.setIndicatorImage(contentImage, atIndex: 2)

        // THEN
        XCTAssertEqual(sut.pageContent(atIndex: 0).indicatorImage, preferredImage, "Expected image 1 to be preferredImage")
        XCTAssertEqual(sut.pageContent(atIndex: 1).indicatorImage, contentImage, "Expected image 2 to be currentImage")
        XCTAssertEqual(sut.pageContent(atIndex: 2).indicatorImage, currentPagePreferredImage, "Expected image 3 to be contentPagePreferredImage")
    }

    func test_uses_current_page_image_set()  {
        // GIVEN
        let preferredImage = UIImage(systemName: "pencil")!
        let currentPagePreferredImage = UIImage(systemName: "lock.circle")
        let visitedImage = UIImage(systemName: "pencil.circle")!
        let currentContentImage = UIImage(systemName: "trash")!

        var sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(
            numberOfPages: 3,
            currentPageIndex: 1,
            showDefaultPageNumber: false,
            preferredIndicatorImage: preferredImage,
            preferredCurrentPageIndicatorImage: currentPagePreferredImage,
            completedPageIndicatorImage: visitedImage
        )

        sut.setCurrentPageIndicatorImage(currentContentImage, atIndex: 1)

        // THEN
        XCTAssertEqual(sut.pageContent(atIndex: 0).indicatorImage, visitedImage, "Expected image 1 to be currentPagePreferredImage")
        XCTAssertEqual(sut.pageContent(atIndex: 1).indicatorImage, currentContentImage, "Expected image 2 to be contentImage")
        XCTAssertEqual(sut.pageContent(atIndex: 2).indicatorImage, preferredImage, "Expected image 3 to be preferred")
    }

    func test_attributed_label() {
        // GIVEN
        var sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(
            numberOfPages: 3,
            currentPageIndex: 2
        )

        // WHEN
        sut.setAttributedLabel(NSAttributedString(string: "hello"), atIndex: 1)

        // THEN
        XCTAssertEqual(sut.getAttributedLabel(atIndex: 1)?.string, "hello")
    }

    func test_needs_update_of_layout_when_pagecount_differs() {
        // GIVEN
        let sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(
            numberOfPages: 3,
            currentPageIndex: 2
        )

        let other = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(
            numberOfPages: 4,
            currentPageIndex: 2
        )

        // THEN
        XCTAssertTrue(sut.needsUpdateOfLayout(otherComponent: other))
    }

    func test_needs_update_of_label_counts_differ() {
        // GIVEN
        let sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(
            numberOfPages: 3,
            currentPageIndex: 2
        )

        var other = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(
            numberOfPages: 3,
            currentPageIndex: 2
        )

        other.setAttributedLabel(NSAttributedString(string: "A"), atIndex: 0)

        // THEN
        XCTAssertTrue(sut.needsUpdateOfLayout(otherComponent: other))
    }

    func test_no_need_for_layout_updated() {
        // GIVEN
        let sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(
            numberOfPages: 3,
            currentPageIndex: 2
        )

        let other = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(
            numberOfPages: 3,
            currentPageIndex: 2
        )

        // THEN
        XCTAssertFalse(sut.needsUpdateOfLayout(otherComponent: other))
    }

    func test_accessibility_label_with_no_content() {
        // GIVEN
        let sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(numberOfPages: 2, currentPageIndex: 1, showDefaultPageNumber: false)

        // THEN
        XCTAssertEqual(sut.getIndicatorAccessibilityLabel(atIndex: 0), "1", "Expected label 0 to be 1")
        XCTAssertEqual(sut.getIndicatorAccessibilityLabel(atIndex: 1), "2", "Expected label 1 to be 2")
    }

    func test_accessibility_label_with_content() {
        // GIVEN
        var sut = ProgressTrackerContent<ProgressTrackerUIIndicatorContent>(numberOfPages: 2, currentPageIndex: 1, showDefaultPageNumber: false)

        // WHEN
        sut.setIndicatorLabel("A", atIndex: 0)
        sut.setIndicatorLabel("B", atIndex: 1)

        // THEN
        XCTAssertEqual(sut.getIndicatorAccessibilityLabel(atIndex: 0), "A", "Expected accessibility label to be A")
        XCTAssertEqual(sut.getIndicatorAccessibilityLabel(atIndex: 1), "B", "Expected accessibility label to be B")
    }
}
