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

final class TabItemViewModelTests: XCTestCase {
    
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
        tabGetStateAttributesUseCase.executeWithThemeAndIntentAndStateReturnValue = TabStateAttributes(
            spacings: self.spacings,
            colors: self.colors,
            opacity: nil,
            separatorLineHeight: theme.border.width.small
        )
    }
    
    // MARK: - Tests
    func test_initialization() {
        let text = "Text"
        let icon = UIImage(systemName: "pencil.circle")
        let sut = self.sut(icon: icon, text: text)
        XCTAssertIdentical(sut.theme as AnyObject, self.theme, "sut theme should be the same as self.theme")
        XCTAssertEqual(sut.intent, .main, "sut intent should be main")
        XCTAssertEqual(sut.isSelected, false, "sut's isSelected parameter should be false")
        XCTAssertEqual(sut.isPressed, false, "sut's isPressed parameter should be false")
        XCTAssertEqual(sut.isDisabled, false, "sut's isDisabled parameter should be false")
        XCTAssertEqual(sut.icon, icon, "sut's icon should be icon")
        XCTAssertEqual(sut.text, text, "sut's text should be text")
    }
    
    func test_usecase_is_executed_on_initialization() {
        _ = self.sut(intent: .support)
        let arguments = self.tabGetStateAttributesUseCase.executeWithThemeAndIntentAndStateReceivedArguments
        XCTAssertIdentical(arguments?.theme as AnyObject, self.theme, "sut theme should be the same as self.theme")
        XCTAssertEqual(arguments?.intent, .support, "sut intent should be support")
        XCTAssertEqual(arguments?.state, TabState(), "sut state should be TabState that has default parameters")
    }
    
    func test_published_attributes_on_initialization() {
        let sut = self.sut()
        let expectedAttributes = TabStateAttributes(
            spacings: self.spacings,
            colors: self.colors,
            opacity: nil,
            separatorLineHeight: self.theme.border.width.small
        )
        
        let expectation = expectation(description: "wait for attributes")
        sut.$tabStateAttributes.sink { attributes in
            XCTAssertEqual(attributes, expectedAttributes)
            expectation.fulfill()
        }
        .store(in: &self.cancellables)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_published_content_on_initialization() {
        let text = "Text"
        let icon = UIImage(systemName: "pencil.circle")
        let expectedContent = TabUIItemContent(icon: icon, text: text)
        let sut = self.sut(icon: icon, text: text)
        
        let expectation = expectation(description: "wait for attributes")
        sut.$content.sink { content in
            XCTAssertEqual(content, expectedContent)
            expectation.fulfill()
        }
        .store(in: &self.cancellables)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_published_attributes_on_change() {
        let sut = self.sut()
        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2
        sut.$tabStateAttributes.sink { _ in
            expectation.fulfill()
        }
        .store(in: &self.cancellables)
        sut.isSelected = true
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_attributes_not_published() {
        let sut = self.sut()
        let expectation = expectation(description: "wait for attributes")
        sut.$tabStateAttributes.sink { _ in
            expectation.fulfill()
        }
        .store(in: &self.cancellables)
        sut.isSelected = false
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_published_is_pressed_on_change() {
        let sut = self.sut()
        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2
        sut.$tabStateAttributes.sink { _ in
            expectation.fulfill()
        }
        .store(in: &self.cancellables)
        sut.isPressed = true
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_published_is_disable_on_change() {
        let sut = self.sut()
        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2
        var counter = 0
        sut.$tabStateAttributes.sink { _ in
            counter += 1
            let arguments = self.tabGetStateAttributesUseCase.executeWithThemeAndIntentAndStateReceivedArguments
            XCTAssertEqual(arguments?.state.isDisabled, counter == 2)
            expectation.fulfill()
        }
        .store(in: &self.cancellables)
        sut.isDisabled = true
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_published_icon_on_change() {
        let icon = UIImage(systemName: "pencil.circle")
        let expectedIcon = UIImage(systemName: "pencil.circle.fill")
        let sut = self.sut(icon: icon)
        
        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2
        var counter = 0
        sut.$content.sink { content in
            counter += 1
            XCTAssertEqual(content.icon == expectedIcon, counter == 2)
            expectation.fulfill()
        }
        .store(in: &self.cancellables)
        sut.icon = UIImage(systemName: "pencil.circle.fill")
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_published_text_on_change() {
        let text = "Text"
        let expectedText = "Expected Text"
        let sut = self.sut(text: text)
        
        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2
        var counter = 0
        sut.$content.sink { content in
            counter += 1
            XCTAssertEqual(content.text == expectedText, counter == 2)
            expectation.fulfill()
        }
        .store(in: &self.cancellables)
        sut.text = expectedText
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_published_attribute_text_on_change() {
        let attributeText = NSAttributedString(string: "Text")
        let expectedAttributeText = NSAttributedString(string: "Expected Text")
        let sut = self.sut(attributeText: attributeText)
        
        let expectation = expectation(description: "wait for attributes")
        expectation.expectedFulfillmentCount = 2
        var counter = 0
        sut.$content.sink { content in
            counter += 1
            XCTAssertEqual(content.attributeText == expectedAttributeText, counter == 2)
            expectation.fulfill()
        }
        .store(in: &self.cancellables)
        sut.attributeText = expectedAttributeText
        wait(for: [expectation], timeout: 0.1)
    }
}

// MARK: - Helper
private extension TabItemViewModelTests {
    
    func sut(
        intent: TabIntent = .main,
        icon: UIImage? = nil,
        text: String? = nil,
        attributeText: NSAttributedString? = nil
    ) -> TabItemViewModel {
        return TabItemViewModel(
            theme: self.theme,
            intent: intent,
            tabState: TabState(),
            content: TabUIItemContent(
                icon: icon,
                text: text,
                attributeText: attributeText
            ),
            tabGetStateAttributesUseCase: self.tabGetStateAttributesUseCase
        )
    }
}
