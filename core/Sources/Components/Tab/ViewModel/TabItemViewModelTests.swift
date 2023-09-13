//
//  TabItemViewModelTests.swift
//  SparkCoreTests
//
//  Created by alican.aycil on 25.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import SparkCore
import XCTest

final class TabItemViewModelTests: TestCase {
    
    // MARK: - Private properties
    private var theme: ThemeGeneratedMock!
    private var tabGetStateAttributesUseCase: TabGetStateAttributesUseCasableGeneratedMock!
    private var cancellables = Set<AnyCancellable>()
    private var spacings: TabItemSpacings!
    private var colors: TabItemColors!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.theme = ThemeGeneratedMock.mocked()
        tabGetStateAttributesUseCase = TabGetStateAttributesUseCasableGeneratedMock()
        
        self.spacings = TabItemSpacings(
            verticalEdge: self.theme.layout.spacing.medium,
            horizontalEdge: self.theme.layout.spacing.large,
            content: self.theme.layout.spacing.medium
        )
        self.colors = TabItemColors(
            label: self.theme.colors.base.outline,
            line: self.theme.colors.base.outline,
            background: self.theme.colors.base.surface
        )

        let expectedHeights = TabItemHeights(
            separatorLineHeight: self.theme.border.width.small,
            itemHeight: 40,
            iconHeight: 16
        )
        tabGetStateAttributesUseCase.executeWithThemeAndIntentAndStateAndTabSizeAndHasTitleReturnValue = TabStateAttributes(
            spacings: self.spacings,
            colors: self.colors,
            heights: expectedHeights,
            font: theme.typography.body1
        )
    }
    
    // MARK: - Tests
    func test_initialization() {
        // Given
        let title = "Text"
        let icon = UIImage(systemName: "pencil.circle")
        let sut = self.sut(icon: icon, title: title)

        // Then
        XCTAssertIdentical(sut.theme as AnyObject, self.theme, "sut theme should be the same as self.theme")
        XCTAssertEqual(sut.intent, .main, "sut intent should be main")
        XCTAssertFalse(sut.isSelected, "sut's isSelected parameter should be false")
        XCTAssertFalse(sut.isPressed, "sut's isPressed parameter should be false")
        XCTAssertTrue(sut.isEnabled, "sut's isDisabled parameter should be false")
    }
    
    func test_usecase_is_executed_on_initialization() {
        // Given
        _ = self.sut(intent: .support)
        let arguments = self.tabGetStateAttributesUseCase.executeWithThemeAndIntentAndStateAndTabSizeAndHasTitleReceivedArguments

        // Then
        XCTAssertIdentical(arguments?.theme as AnyObject, self.theme, "sut theme should be the same as self.theme")
        XCTAssertEqual(arguments?.intent, .support, "sut intent should be support")
        XCTAssertEqual(arguments?.state, TabState(), "sut state should be TabState that has default parameters")
    }
    
    func test_published_attributes_on_initialization() {
        // Given
        let sut = self.sut()
        let expectedHeights = TabItemHeights(
            separatorLineHeight: self.theme.border.width.small,
            itemHeight: 40,
            iconHeight: 16
        )

        let expectedAttributes = TabStateAttributes(
            spacings: self.spacings,
            colors: self.colors,
            heights: expectedHeights,
            font: self.theme.typography.body1
        )
        
        let expectation = expectation(description: "wait for attributes")
        var givenAttributes: TabStateAttributes?

        // When
        sut.$tabStateAttributes.sink { attributes in
            givenAttributes = attributes
            expectation.fulfill()
        }
        .store(in: &self.cancellables)

        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(givenAttributes, expectedAttributes)
    }
    
    func test_published_attributes_on_change() {
        // Given
        let sut = self.sut()
        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2
        sut.$tabStateAttributes.sink { _ in
            expectation.fulfill()
        }
        .store(in: &self.cancellables)

        // When
        sut.isSelected = true

        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_attributes_not_published() {
        // Given
        let sut = self.sut()
        let expectation = expectation(description: "wait for attributes")
        sut.$tabStateAttributes.sink { _ in
            expectation.fulfill()
        }
        .store(in: &self.cancellables)

        // When
        sut.isSelected = false

        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_published_is_pressed_on_change() {
        // Given
        let sut = self.sut()
        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2
        sut.$tabStateAttributes.sink { _ in
            expectation.fulfill()
        }
        .store(in: &self.cancellables)

        // When
        sut.isPressed = true

        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_published_is_disable_on_change() {
        // Given
        let sut = self.sut()
        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2
        var counter = 0
        sut.$tabStateAttributes.sink { _ in
            counter += 1
            let arguments = self.tabGetStateAttributesUseCase.executeWithThemeAndIntentAndStateAndTabSizeAndHasTitleReceivedArguments

            XCTAssertEqual(arguments?.state.isEnabled, counter == 1)
            expectation.fulfill()
        }
        .store(in: &self.cancellables)

        // When
        sut.isEnabled = false

        // Then
        wait(for: [expectation], timeout: 0.1)
    }

    func test_published_attribute_on_size_change() {
        // Given
        let sut = self.sut(size: .md, title: "Hello")

        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2

        sut.$tabStateAttributes.sink { attributes in
            expectation.fulfill()
        }
        .store(in: &self.cancellables)

        // When
        sut.tabSize = .xs

        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(self.tabGetStateAttributesUseCase.executeWithThemeAndIntentAndStateAndTabSizeAndHasTitleReceivedArguments?.tabSize, .xs)
    }

    func test_not_published_attribute_when_no_size_change() {
        // Given
        let sut = self.sut(size: .xs, title: "Hello")

        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 1

        sut.$tabStateAttributes.sink { attributes in
            expectation.fulfill()
        }
        .store(in: &self.cancellables)

        // When
        sut.tabSize = .xs

        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(self.tabGetStateAttributesUseCase.executeWithThemeAndIntentAndStateAndTabSizeAndHasTitleReceivedArguments?.tabSize, .xs)
    }

    func test_when_theme_changes_then_attributes_published() {
        // Given
        let sut = self.sut(size: .sm, title: "Label")

        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2

        sut.$tabStateAttributes.sink { attributes in
            expectation.fulfill()
        }
        .store(in: &self.cancellables)

        // When
        sut.theme = ThemeGeneratedMock.mocked()

        // Then
        wait(for: [expectation], timeout: 0.1)
    }


    func test_when_intent_changes_then_attributes_published() {
        // Given
        let sut = self.sut(intent: .main, title: "Label")

        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2

        sut.$tabStateAttributes.sink { attributes in
            expectation.fulfill()
        }
        .store(in: &self.cancellables)

        // When
        sut.intent = .support

        // Then
        wait(for: [expectation], timeout: 0.1)
    }

    func test_when_intent_does_not_change_then_nothing_published() {
        // Given
        let sut = self.sut(intent: .main, title: "Label")

        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 1

        sut.$tabStateAttributes.sink { attributes in
            expectation.fulfill()
        }
        .store(in: &self.cancellables)

        // When
        sut.intent = .main

        // Then
        wait(for: [expectation], timeout: 0.1)
    }
}

// MARK: - Helper
private extension TabItemViewModelTests {
    
    func sut(
        intent: TabIntent = .main,
        size: TabSize = .md,
        icon: UIImage? = nil,
        title: String? = nil
    ) -> TabItemViewModel<TabUIItemContent> {
        return TabItemViewModel(
            theme: self.theme,
            intent: intent,
            tabSize: size,
            tabState: TabState(),
            content: .init(icon: icon, title: title),
            tabGetStateAttributesUseCase: self.tabGetStateAttributesUseCase
        )
    }
}
