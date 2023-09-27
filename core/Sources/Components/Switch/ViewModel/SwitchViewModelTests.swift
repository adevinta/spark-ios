//
//  SwitchViewModelTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import Combine

@testable import SparkCore

final class SwitchViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Setup

    override func tearDown() {
        super.tearDown()

        // Clear publishers
        self.subscriptions.removeAll()
    }

    // MARK: - Init Tests

    func test_properties_on_init_when_frameworkType_is_UIKit() throws {
        try self.testPropertiesOnInit(
            givenFrameworkType: .uiKit
        )
    }

    func test_properties_on_init_when_frameworkType_is_SwiftUI() throws {
        try self.testPropertiesOnInit(
            givenFrameworkType: .swiftUI
        )
    }

    private func testPropertiesOnInit(
        givenFrameworkType: FrameworkType
    ) throws {
        // GIVEN
        let isOnMock = true
        let alignmentMock: SwitchAlignment = .left
        let intentMock: SwitchIntent = .alert
        let isEnabledMock = true

        let isUIKit = givenFrameworkType == .uiKit

        // WHEN
        let stub = Stub(
            frameworkType: givenFrameworkType,
            isOn: isOnMock,
            alignment: alignmentMock,
            intent: intentMock,
            isEnabled: isEnabledMock,
            isImages: true
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        // THEN
        XCTAssertEqual(viewModel.isOn,
                       isOnMock,
                       "Wrong isOn value")
        XCTAssertIdentical(viewModel.theme as? ThemeGeneratedMock,
                           stub.themeMock,
                           "Wrong theme value")
        XCTAssertEqual(viewModel.alignment,
                       alignmentMock,
                       "Wrong alignment value")
        XCTAssertEqual(viewModel.intent,
                       intentMock,
                       "Wrong intent value")
        XCTAssertEqual(viewModel.isEnabled,
                       isEnabledMock,
                       "Wrong isEnabled value")
        XCTAssertEqual(viewModel.images?.leftValue,
                       stub.imagesMock,
                       "Wrong images value")

        XCTAssertNil(viewModel.isOnChanged,
                     "Wrong isOnChanged value")

        // **
        // Published properties
        let publishedExpectedContainsValue = (isUIKit ? false : true)
        self.testIsOnChanged(on: stub, expectedValue: nil)
        self.testToggleState(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testColors(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testPosition(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testToggleDotImage(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testDisplayedText(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testTextFont(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testShowToggleLeftSpace(on: stub, expectedValue: isUIKit ? nil : true)

        self.testAllPublishedSinkCount(
            on: stub,
            expectedIsOnChangedPublishedSinkCount: 1,
            expectedIsToggleInteractionEnabledPublishedSinkCount: 1,
            expectedToggleOpacityPublishedSinkCount: 1,
            expectedToggleBackgroundColorTokenPublishedSinkCount: 1,
            expectedToggleDotBackgroundColorTokenPublishedSinkCount: 1,
            expectedToggleDotForegroundColorTokenPublishedSinkCount: 1,
            expectedTextForegroundColorTokenPublishedSinkCount: 1,
            expectedIsToggleOnLeftPublishedSinkCount: 1,
            expectedHorizontalSpacingPublishedSinkCount: 1,
            expectedShowToggleLeftSpacePublishedSinkCount: 1,
            expectedToggleDotImagePublishedSinkCount: 1,
            expectedDisplayedTextPublishedSinkCount: 1,
            expectedTextFontTokenPublishedSinkCount: 1
        )
        // **

        // **
        // Use Cases
        let useCaseNumberOfCalls = (isUIKit ? 0 : 1)
        self.testGetColorsUseCaseMock(
            on: stub,
            numberOfCalls: useCaseNumberOfCalls
        )
        self.testGetImageUseCaseMock(
            on: stub,
            numberOfCalls: useCaseNumberOfCalls
        )
        self.testGetToggleColorUseCaseMock(
            on: stub,
            numberOfCalls: isUIKit ? 0 : 2
        )
        self.testGetPositionUseCaseMock(
            on: stub,
            numberOfCalls: useCaseNumberOfCalls
        )
        self.testGetToggleStateUseCaseMock(
            on: stub,
            numberOfCalls: useCaseNumberOfCalls
        )
        // **

    }


    // MARK: - Load Tests

    func test_published_properties_on_load_when_frameworkType_is_UIKit() throws {
        try self.testPublishedPropertiesOnLoad(
            givenFrameworkType: .uiKit
        )
    }

    func test_published_properties_on_load_when_frameworkType_is_SwiftUI() throws {
        try self.testPublishedPropertiesOnLoad(
            givenFrameworkType: .swiftUI
        )
    }

    func testPublishedPropertiesOnLoad(
        givenFrameworkType: FrameworkType
    ) throws {
        // GIVEN
        let isOnMock = true
        let alignmentMock: SwitchAlignment = .left
        let intentMock: SwitchIntent = .alert
        let isEnabledMock = true

        let isUIKit = givenFrameworkType == .uiKit

        // WHEN
        let stub = Stub(
            frameworkType: givenFrameworkType,
            isOn: isOnMock,
            alignment: alignmentMock,
            intent: intentMock,
            isEnabled: isEnabledMock,
            isImages: true
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        // Reset all UseCase mock
        stub.resetMockedData()

        viewModel.load()

        // THEN
        // **
        // Published properties
        let publishedExpectedContainsValue = (isUIKit ? true : false)
        self.testIsOnChanged(on: stub, expectedValue: nil)
        self.testToggleState(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testColors(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testPosition(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testToggleDotImage(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testDisplayedText(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testTextFont(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testShowToggleLeftSpace(on: stub, expectedValue: isUIKit ? stub.isOnMock : nil)

        let publishedSinkCount = isUIKit ? 1 : 0
        self.testAllPublishedSinkCount(
            on: stub,
            expectedIsToggleInteractionEnabledPublishedSinkCount: publishedSinkCount,
            expectedToggleOpacityPublishedSinkCount: publishedSinkCount,
            expectedToggleBackgroundColorTokenPublishedSinkCount: publishedSinkCount,
            expectedToggleDotBackgroundColorTokenPublishedSinkCount: publishedSinkCount,
            expectedToggleDotForegroundColorTokenPublishedSinkCount: publishedSinkCount,
            expectedTextForegroundColorTokenPublishedSinkCount: publishedSinkCount,
            expectedIsToggleOnLeftPublishedSinkCount: publishedSinkCount,
            expectedHorizontalSpacingPublishedSinkCount: publishedSinkCount,
            expectedShowToggleLeftSpacePublishedSinkCount: publishedSinkCount,
            expectedToggleDotImagePublishedSinkCount: publishedSinkCount,
            expectedDisplayedTextPublishedSinkCount: publishedSinkCount,
            expectedTextFontTokenPublishedSinkCount: publishedSinkCount
        )
        // **

        // **
        // Use Cases
        let useCaseNumberOfCalls = (isUIKit ? 1 : 0)
        self.testGetColorsUseCaseMock(
            on: stub,
            numberOfCalls: useCaseNumberOfCalls,
            givenTheme: stub.themeMock,
            givenIntent: intentMock
        )
        self.testGetImageUseCaseMock(
            on: stub,
            numberOfCalls: useCaseNumberOfCalls,
            givenIsOn: isOnMock,
            givenImages: stub.imagesMock
        )
        self.testGetToggleColorUseCaseMock(
            on: stub,
            numberOfCalls: isUIKit ? 2 : 0,
            givenIsOn: isOnMock
        )
        self.testGetPositionUseCaseMock(
            on: stub,
            numberOfCalls: useCaseNumberOfCalls,
            givenTheme: stub.themeMock,
            givenAlignment: alignmentMock
        )
        self.testGetToggleStateUseCaseMock(
            on: stub,
            numberOfCalls: useCaseNumberOfCalls,
            givenTheme: stub.themeMock,
            givenIsEnabled: isEnabledMock
        )
        // **
    }

    // MARK: - Toggle Tests

    func test_toggle_when_isToggleInteractionEnabled_is_true_should_update_switch() {
        // GIVEN
        let expectedIsOn = true

        let isEnabledMock = false

        let stub = Stub(
            isOn: false,
            alignment: .right,
            intent: .support,
            isEnabled: isEnabledMock,
            isImages: true,
            userInteractionEnabled: true
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load()

        // Reset all UseCase mock
        stub.resetMockedData()

        // WHEN
        viewModel.toggle()

        // THEN
        XCTAssertEqual(viewModel.isOn,
                       expectedIsOn,
                       "Wrong isOn value")

        // **
        // Published properties
        self.testIsOnChanged(on: stub, expectedValue: expectedIsOn)
        self.testToggleState(on: stub)
        self.testColors(on: stub)
        self.testPosition(on: stub, expectedContainsValue: false)
        self.testToggleDotImage(on: stub)
        self.testDisplayedText(on: stub, expectedContainsValue: false)
        self.testTextFont(on: stub, expectedContainsValue: false)
        self.testShowToggleLeftSpace(on: stub, expectedValue: expectedIsOn)

        self.testAllPublishedSinkCount(
            on: stub,
            expectedIsOnChangedPublishedSinkCount: 1,
            expectedIsToggleInteractionEnabledPublishedSinkCount: 1,
            expectedToggleOpacityPublishedSinkCount: 1,
            expectedToggleBackgroundColorTokenPublishedSinkCount: 1,
            expectedToggleDotBackgroundColorTokenPublishedSinkCount: 1,
            expectedToggleDotForegroundColorTokenPublishedSinkCount: 1,
            expectedTextForegroundColorTokenPublishedSinkCount: 1,
            expectedIsToggleOnLeftPublishedSinkCount: 1,
            expectedShowToggleLeftSpacePublishedSinkCount: 1,
            expectedToggleDotImagePublishedSinkCount: 1
        )
        // **

        // **
        // Use Cases
        self.testGetImageUseCaseMock(
            on: stub,
            numberOfCalls: 1
        )
        self.testGetToggleColorUseCaseMock(
            on: stub,
            numberOfCalls: 2,
            givenIsOn: expectedIsOn
        )
        self.testGetToggleStateUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenTheme: stub.themeMock,
            givenIsEnabled: isEnabledMock
        )
        // **
    }

    func test_toggle_when_isToggleInteractionEnabled_is_false_should_do_nothing() {
        // GIVEN
        let isOnMock = false
        let alignmentMock: SwitchAlignment = .right
        let intentMock: SwitchIntent = .support
        let isEnabledMock = false

        let stub = Stub(
            isOn: isOnMock,
            alignment: alignmentMock,
            intent: intentMock,
            isEnabled: isEnabledMock,
            isImages: false,
            userInteractionEnabled: false
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load()

        // Reset all UseCase mock
        stub.resetMockedData()

        // WHEN
        viewModel.toggle()

        // THEN
        XCTAssertEqual(viewModel.isOn,
                       isOnMock,
                       "Wrong isOn value")

        // **
        // Published properties
        self.testIsOnChanged(on: stub, expectedValue: nil)
        self.testToggleState(on: stub, expectedContainsValue: false)
        self.testColors(on: stub, expectedContainsValue: false)
        self.testPosition(on: stub, expectedContainsValue: false)
        self.testToggleDotImage(on: stub, expectedContainsValue: false)
        self.testDisplayedText(on: stub, expectedContainsValue: false)
        self.testTextFont(on: stub, expectedContainsValue: false)
        self.testShowToggleLeftSpace(on: stub, expectedValue: nil)

        self.testAllPublishedSinkCount(on: stub)
        // **

        // **
        // Use Cases
        self.testGetImageUseCaseMock(
            on: stub,
            numberOfCalls: 0
        )
        self.testGetToggleColorUseCaseMock(
            on: stub,
            numberOfCalls: 0
        )
        self.testGetToggleStateUseCaseMock(
            on: stub,
            numberOfCalls: 0
        )
        // **
    }

    // MARK: - Setter Tests

    func test_set_theme() {
        // GIVEN
        let newTheme = ThemeGeneratedMock.mocked()

        let isOnMock = false
        let alignmentMock: SwitchAlignment = .right
        let intentMock: SwitchIntent = .support
        let isEnabledMock = false

        let stub = Stub(
            isOn: isOnMock,
            alignment: alignmentMock,
            intent: intentMock,
            isEnabled: isEnabledMock,
            isImages: true
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        stub.resetMockedData()

        // WHEN
        viewModel.set(theme: newTheme)

        // THEN
        XCTAssertIdentical(viewModel.theme as? ThemeGeneratedMock,
                           newTheme,
                           "Wrong theme value")

        // **
        // Published properties
        self.testIsOnChanged(on: stub, expectedValue: nil)
        self.testToggleState(on: stub)
        self.testColors(on: stub)
        self.testPosition(on: stub)
        self.testToggleDotImage(on: stub)
        self.testDisplayedText(on: stub)
        self.testTextFont(on: stub, givenNewTheme: newTheme)
        self.testShowToggleLeftSpace(on: stub, expectedValue: stub.isOnMock)

        self.testAllPublishedSinkCount(
            on: stub,
            expectedIsToggleInteractionEnabledPublishedSinkCount: 1,
            expectedToggleOpacityPublishedSinkCount: 1,
            expectedToggleBackgroundColorTokenPublishedSinkCount: 1,
            expectedToggleDotBackgroundColorTokenPublishedSinkCount: 1,
            expectedToggleDotForegroundColorTokenPublishedSinkCount: 1,
            expectedTextForegroundColorTokenPublishedSinkCount: 1,
            expectedIsToggleOnLeftPublishedSinkCount: 1,
            expectedHorizontalSpacingPublishedSinkCount: 1,
            expectedShowToggleLeftSpacePublishedSinkCount: 1,
            expectedToggleDotImagePublishedSinkCount: 1,
            expectedDisplayedTextPublishedSinkCount: 1,
            expectedTextFontTokenPublishedSinkCount: 1
        )
        // **

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenTheme: newTheme,
            givenIntent: intentMock
        )
        self.testGetImageUseCaseMock(
            on: stub,
            numberOfCalls: 1
        )
        self.testGetToggleColorUseCaseMock(
            on: stub,
            numberOfCalls: 2,
            givenIsOn: isOnMock
        )
        self.testGetPositionUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenTheme: newTheme,
            givenAlignment: alignmentMock
        )
        self.testGetToggleStateUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenTheme: newTheme,
            givenIsEnabled: isEnabledMock
        )
        // **
    }

    func test_set_alignment_with_different_new_value() {
        self.testSetAlignment(
            givenIsDifferentNewValue: true
        )
    }

    func test_set_alignment_with_same_new_value() {
        self.testSetAlignment(
            givenIsDifferentNewValue: false
        )
    }

    func testSetAlignment(
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let defaultValue: SwitchAlignment = .right
        let newValue: SwitchAlignment = givenIsDifferentNewValue ? .left : defaultValue

        let stub = Stub(
            alignment: defaultValue
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        stub.resetMockedData()

        // WHEN
        viewModel.set(alignment: newValue)

        // THEN
        XCTAssertEqual(viewModel.alignment,
                       newValue,
                       "Wrong alignment value")

        // **
        // Published properties
        self.testIsOnChanged(on: stub, expectedValue: nil)
        self.testToggleState(on: stub, expectedContainsValue: false)
        self.testColors(on: stub, expectedContainsValue: false)
        self.testPosition(on: stub, expectedContainsValue: givenIsDifferentNewValue)
        self.testToggleDotImage(on: stub, expectedContainsValue: false)
        self.testDisplayedText(on: stub, expectedContainsValue: false)
        self.testTextFont(on: stub, expectedContainsValue: false)
        self.testShowToggleLeftSpace(on: stub, expectedValue: nil)

        let publishedSinkCount = givenIsDifferentNewValue ? 1 : 0
        self.testAllPublishedSinkCount(
            on: stub,
            expectedIsToggleOnLeftPublishedSinkCount: publishedSinkCount,
            expectedHorizontalSpacingPublishedSinkCount: publishedSinkCount
        )
        // **

        // Use Cases
        self.testGetPositionUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenTheme: stub.themeMock,
            givenAlignment: newValue
        )
    }

    func test_set_intent_with_different_new_value() {
        self.testSetIntent(
            givenIsDifferentNewValue: true
        )
    }

    func test_set_intent_with_same_new_value() {
        self.testSetIntent(
            givenIsDifferentNewValue: false
        )
    }

    private func testSetIntent(
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let defaultValue: SwitchIntent = .main
        let newValue: SwitchIntent = givenIsDifferentNewValue ? .error : defaultValue

        let isOnMock = true

        let stub = Stub(
            isOn: isOnMock,
            intent: defaultValue
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        stub.resetMockedData()

        // WHEN
        viewModel.set(intent: newValue)

        // THEN
        XCTAssertEqual(viewModel.intent,
                       newValue,
                       "Wrong intent value")

        // **
        // Published properties
        self.testIsOnChanged(on: stub, expectedValue: nil)
        self.testToggleState(on: stub, expectedContainsValue: false)
        self.testColors(on: stub, expectedContainsValue: givenIsDifferentNewValue)
        self.testPosition(on: stub, expectedContainsValue: false)
        self.testToggleDotImage(on: stub, expectedContainsValue: false)
        self.testDisplayedText(on: stub, expectedContainsValue: false)
        self.testTextFont(on: stub, expectedContainsValue: false)
        self.testShowToggleLeftSpace(on: stub, expectedValue: nil)

        let publishedSinkCount = givenIsDifferentNewValue ? 1 : 0
        self.testAllPublishedSinkCount(
            on: stub,
            expectedToggleBackgroundColorTokenPublishedSinkCount: publishedSinkCount,
            expectedToggleDotBackgroundColorTokenPublishedSinkCount: publishedSinkCount,
            expectedToggleDotForegroundColorTokenPublishedSinkCount: publishedSinkCount,
            expectedTextForegroundColorTokenPublishedSinkCount: publishedSinkCount
        )
        // **

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenTheme: stub.themeMock,
            givenIntent: newValue
        )
        self.testGetToggleColorUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 2 : 0,
            givenIsOn: isOnMock
        )
        // **
    }

    func test_set_isEnabled_with_different_new_value() {
        self.testSetIsEnabled(
            givenIsDifferentNewValue: true
        )
    }

    func test_set_isEnabled_with_same_new_value() {
        self.testSetIsEnabled(
            givenIsDifferentNewValue: false
        )
    }

    func testSetIsEnabled(
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let defaultValue = true
        let newValue = givenIsDifferentNewValue ? false : defaultValue

        let intentMock: SwitchIntent = .neutral
        let isOnMock = true

        let stub = Stub(
            isOn: isOnMock,
            intent: intentMock,
            isEnabled: defaultValue
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        stub.resetMockedData()

        // WHEN
        viewModel.set(isEnabled: newValue)

        // THEN
        XCTAssertEqual(viewModel.isEnabled,
                       newValue,
                       "Wrong isEnabled value")

        // **
        // Published properties
        self.testIsOnChanged(on: stub, expectedValue: nil)
        self.testToggleState(on: stub, expectedContainsValue: givenIsDifferentNewValue)
        self.testColors(on: stub, expectedContainsValue: givenIsDifferentNewValue)
        self.testPosition(on: stub, expectedContainsValue: false)
        self.testToggleDotImage(on: stub, expectedContainsValue: false)
        self.testDisplayedText(on: stub, expectedContainsValue: false)
        self.testTextFont(on: stub, expectedContainsValue: false)
        self.testShowToggleLeftSpace(on: stub, expectedValue: nil)

        let publishedSinkCount = givenIsDifferentNewValue ? 1 : 0
        self.testAllPublishedSinkCount(
            on: stub,
            expectedIsToggleInteractionEnabledPublishedSinkCount: publishedSinkCount,
            expectedToggleOpacityPublishedSinkCount: publishedSinkCount,
            expectedToggleBackgroundColorTokenPublishedSinkCount: publishedSinkCount,
            expectedToggleDotBackgroundColorTokenPublishedSinkCount: publishedSinkCount,
            expectedToggleDotForegroundColorTokenPublishedSinkCount: publishedSinkCount,
            expectedTextForegroundColorTokenPublishedSinkCount: publishedSinkCount
        )
        // **

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            on: stub,
            numberOfCalls: 0
        )
        self.testGetToggleColorUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 2 : 0,
            givenIsOn: isOnMock
        )
        self.testGetToggleStateUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenTheme: stub.themeMock,
            givenIsEnabled: newValue
        )
        // **
    }

    func test_set_images_with_different_new_value() {
        self.testSetImages(
            givenIsDifferentNewValue: true
        )
    }

    func test_set_images_with_same_new_value() {
        self.testSetImages(
            givenIsDifferentNewValue: false
        )
    }

    func testSetImages(
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let newValue = SwitchUIImages(on: UIImage(), off: UIImage())

        let isOnMock = true

        let stub = Stub(
            isOn: isOnMock,
            isImages: false
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        stub.resetMockedData()

        // WHEN
        viewModel.set(images: givenIsDifferentNewValue ? .left(newValue) : nil)

        // THEN
        if givenIsDifferentNewValue {
            XCTAssertEqual(viewModel.images?.leftValue,
                           newValue,
                           "Wrong images value")
        } else {
            XCTAssertNil(viewModel.images?.leftValue,
                         "Wrong images value")
        }

        // **
        // Published properties
        self.testIsOnChanged(on: stub, expectedValue: nil)
        self.testToggleState(on: stub, expectedContainsValue: false)
        self.testColors(on: stub, expectedContainsValue: false)
        self.testPosition(on: stub, expectedContainsValue: false)
        self.testToggleDotImage(on: stub, expectedContainsValue: givenIsDifferentNewValue)
        self.testDisplayedText(on: stub, expectedContainsValue: false)
        self.testTextFont(on: stub, expectedContainsValue: false)
        self.testShowToggleLeftSpace(on: stub, expectedValue: nil)

        self.testAllPublishedSinkCount(
            on: stub,
            expectedToggleDotImagePublishedSinkCount: givenIsDifferentNewValue ? 1 : 0
        )
        // **

        // Use Cases
        self.testGetImageUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenIsOn: isOnMock,
            givenImages: givenIsDifferentNewValue ? newValue : nil
        )
    }

    func test_set_text_when_displayedTextViewModel_textChanged_return_true_and_new_value_is_NOT_nil() {
        self.testSetText(
            newValueIsNil: false,
            givenIsDifferentNewValue: true
        )
    }

    func test_set_text_when_displayedTextViewModel_textChanged_return_true_and_new_value_is_nil() {
        self.testSetText(
            newValueIsNil: true,
            givenIsDifferentNewValue: true
        )
    }

    func test_set_text_when_displayedTextViewModel_textChanged_return_false() {
        self.testSetText(
            givenIsDifferentNewValue: false
        )
    }

    private func testSetText(
        newValueIsNil: Bool = true,
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let newValue: String? = newValueIsNil ? nil : "My New Text"

        let stub = Stub(
            text: "Text"
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        stub.displayedTextViewModelMock.textChangedWithTextReturnValue = givenIsDifferentNewValue
        viewModel.set(text: newValue)

        // THEN

        // **
        // Published properties
        let publishedExpectedContainsValue = (givenIsDifferentNewValue && !newValueIsNil)
        self.testIsOnChanged(on: stub, expectedValue: nil)
        self.testToggleState(on: stub, expectedContainsValue: false)
        self.testColors(
            on: stub,
            expectedContainsValue: false,
            expectedTextForegroundColorContainsValue: publishedExpectedContainsValue
        )
        self.testPosition(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testToggleDotImage(on: stub, expectedContainsValue: false)
        self.testDisplayedText(on: stub, expectedContainsValue: givenIsDifferentNewValue)
        self.testTextFont(on: stub, expectedContainsValue: publishedExpectedContainsValue)
        self.testShowToggleLeftSpace(on: stub, expectedValue: nil)

        let publishedSinkCount = (givenIsDifferentNewValue && !newValueIsNil) ? 1 : 0
        self.testAllPublishedSinkCount(
            on: stub,
            expectedTextForegroundColorTokenPublishedSinkCount: publishedSinkCount,
            expectedIsToggleOnLeftPublishedSinkCount: publishedSinkCount,
            expectedHorizontalSpacingPublishedSinkCount: publishedSinkCount,
            expectedDisplayedTextPublishedSinkCount: givenIsDifferentNewValue ? 1 : 0,
            expectedTextFontTokenPublishedSinkCount: publishedSinkCount
        )
        // **

        // **
        // DisplayedText ViewModel
        XCTAssertEqual(
            stub.displayedTextViewModelMock.textChangedWithTextCallsCount,
            1,
            "Wrong call number on textChanged on displayedTextViewModel"
        )
        XCTAssertEqual(
            stub.displayedTextViewModelMock.textChangedWithTextReceivedText,
            newValue,
            "Wrong textChanged parameter on displayedTextViewModel"
        )
        // **
    }

    func test_set_attributedText_when_displayedTextViewModel_attributedTextChanged_return_true() {
        self.testSetAttributedText(
            givenIsDifferentNewValue: true
        )
    }

    func test_set_attributedText_when_displayedTextViewModel_attributedTextChanged_return_false() {
        self.testSetAttributedText(
            givenIsDifferentNewValue: false
        )
    }

    private func testSetAttributedText(
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let newValue = NSAttributedString(string: "My new AT Switch")

        let stub = Stub(
            attributedText: .init(string: "My AT Switch")
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        stub.displayedTextViewModelMock.attributedTextChangedWithAttributedTextReturnValue = givenIsDifferentNewValue
        viewModel.set(attributedText: .left(newValue))

        // THEN
        // **
        // Published properties
        self.testIsOnChanged(on: stub, expectedValue: nil)
        self.testToggleState(on: stub, expectedContainsValue: false)
        self.testColors(on: stub, expectedContainsValue: false)
        self.testPosition(on: stub, expectedContainsValue: givenIsDifferentNewValue)
        self.testToggleDotImage(on: stub, expectedContainsValue: false)
        self.testDisplayedText(on: stub, expectedContainsValue: givenIsDifferentNewValue)
        self.testTextFont(on: stub, expectedContainsValue: false)
        self.testShowToggleLeftSpace(on: stub, expectedValue: nil)

        let publishedSinkCount = (givenIsDifferentNewValue) ? 1 : 0
        self.testAllPublishedSinkCount(
            on: stub,
            expectedIsToggleOnLeftPublishedSinkCount: publishedSinkCount,
            expectedHorizontalSpacingPublishedSinkCount: publishedSinkCount,
            expectedDisplayedTextPublishedSinkCount: publishedSinkCount

        )
        // **

        // **
        // DisplayedText ViewModel
        XCTAssertEqual(
            stub.displayedTextViewModelMock.attributedTextChangedWithAttributedTextCallsCount,
            1,
            "Wrong call number on attributedText on displayedTextViewModel"
        )
        XCTAssertEqual(
            stub.displayedTextViewModelMock.attributedTextChangedWithAttributedTextReceivedAttributedText?.leftValue,
            newValue,
            "Wrong attributedText parameter on displayedTextViewModel"
        )
        // **
    }
}

// MARK: - Testing Dependencies

private extension SwitchViewModelTests {

    func testGetColorsUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenTheme: Theme? = nil,
        givenIntent: SwitchIntent? = nil
    ) {
        XCTAssertEqual(stub.getColorsUseCaseMock.executeWithIntentAndColorsAndDimsCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getColorsUseCase")

        if numberOfCalls > 0, let givenTheme, let givenIntent {
            let getColorsUseCaseArgs = stub.getColorsUseCaseMock.executeWithIntentAndColorsAndDimsReceivedArguments
            XCTAssertEqual(getColorsUseCaseArgs?.intent,
                           givenIntent,
                           "Wrong intent parameter on execute on getColorsUseCase")
            XCTAssertIdentical(try XCTUnwrap(getColorsUseCaseArgs?.colors as? ColorsGeneratedMock),
                               givenTheme.colors as? ColorsGeneratedMock,
                               "Wrong colors parameter on execute on getColorsUseCase")
            XCTAssertIdentical(try XCTUnwrap(getColorsUseCaseArgs?.dims as? DimsGeneratedMock),
                               givenTheme.dims as? DimsGeneratedMock,
                               "Wrong dims parameter on execute on getColorsUseCase")
        }
    }

    func testGetImageUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenIsOn: Bool? = nil,
        givenImages: SwitchUIImages? = nil
    ) {
        XCTAssertEqual(stub.getImagesStateUseCaseMock.executeWithIsOnAndImagesCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getImageUseCase")

        if numberOfCalls > 0, let givenIsOn {
            let getImageUseCaseArgs = stub.getImagesStateUseCaseMock.executeWithIsOnAndImagesReceivedArguments
            XCTAssertEqual(getImageUseCaseArgs?.isOn,
                           givenIsOn,
                           "Wrong isOn parameter on execute on getImageUseCase")

            if let givenImages {
                XCTAssertEqual(getImageUseCaseArgs?.images.leftValue,
                               givenImages,
                               "Wrong images parameter on execute on getImageUseCase")
            } else {
                XCTAssertNil(getImageUseCaseArgs?.images,
                             "images parameter should be nil on execute on getImageUseCase")
            }
        }
    }

    func testGetToggleColorUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenIsOn: Bool? = nil
    ) {
        let givenStatusAndStateColors =  [
            stub.colorsMock.toggleBackgroundColors,
            stub.colorsMock.toggleDotForegroundColors
        ]

        XCTAssertEqual(stub.getToggleColorUseCaseMock.executeWithIsOnAndStatusAndStateColorCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getToggleColorUseCase")

        if numberOfCalls > 0, let givenIsOn {
            let getToggleColorUseCaseInvocations = stub.getToggleColorUseCaseMock.executeWithIsOnAndStatusAndStateColorReceivedInvocations

            guard getToggleColorUseCaseInvocations.count == numberOfCalls else {
                XCTFail("Wrong invocation number on execute on getToggleColorUseCase")
                return
            }

            guard givenStatusAndStateColors.count == 2 else {
                XCTFail("Wrong number of item into givenStatusAndStateColors")
                return
            }

            for (index, args) in getToggleColorUseCaseInvocations.enumerated() {
                let givenStatusAndStateColorsIndex = (index % 2 == 0) ? 0 : 1

                XCTAssertEqual(args.isOn,
                               givenIsOn,
                               "Wrong isOn parameter on \(index) execute on getToggleColorUseCase")
                XCTAssertEqual(try XCTUnwrap(args.statusAndStateColor),
                               givenStatusAndStateColors[givenStatusAndStateColorsIndex],
                               "Wrong statusAndStateColor parameter on \(index) execute on getToggleColorUseCase")
            }
        }
    }

    func testGetPositionUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenTheme: Theme? = nil,
        givenAlignment: SwitchAlignment? = nil
    ) {
        XCTAssertEqual(stub.getPositionUseCaseMock.executeWithAlignmentAndSpacingAndContainsTextCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getPositionUseCase")

        if numberOfCalls > 0, let givenTheme, let givenAlignment {
            let getPositionUseCaseArgs = stub.getPositionUseCaseMock.executeWithAlignmentAndSpacingAndContainsTextReceivedArguments
            XCTAssertEqual(getPositionUseCaseArgs?.alignment,
                           givenAlignment,
                           "Wrong alignment parameter on execute on getPositionUseCase")
            XCTAssertIdentical(try XCTUnwrap(getPositionUseCaseArgs?.spacing as? LayoutSpacingGeneratedMock),
                               givenTheme.layout.spacing as? LayoutSpacingGeneratedMock,
                               "Wrong spacing parameter on execute on getPositionUseCase")
            XCTAssertEqual(getPositionUseCaseArgs?.containsText,
                           stub.displayedTextViewModelMock.containsText,
                           "Wrong containsText parameter on execute on getContentUseCase")
        }
    }

    func testGetToggleStateUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenTheme: Theme? = nil,
        givenIsEnabled: Bool? = nil
    ) {
        XCTAssertEqual(stub.getToggleStateUseCaseMock.executeWithIsEnabledAndDimsCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getToggleStateUseCase")

        if numberOfCalls > 0, let givenTheme, let givenIsEnabled {
            let getToggleStateUseCaseArgs = stub.getToggleStateUseCaseMock.executeWithIsEnabledAndDimsReceivedArguments
            XCTAssertEqual(getToggleStateUseCaseArgs?.isEnabled,
                           givenIsEnabled,
                           "Wrong isEnabled parameter on execute on getToggleStateUseCase")
            XCTAssertIdentical(try XCTUnwrap(getToggleStateUseCaseArgs?.dims as? DimsGeneratedMock),
                               givenTheme.dims as? DimsGeneratedMock,
                               "Wrong dims parameter on execute on getToggleStateUseCase")
        }
    }
}

// MARK: - Testing Publisher

private extension SwitchViewModelTests {

    func testAllPublishedSinkCount(
        on stub: Stub,
        expectedIsOnChangedPublishedSinkCount: Int = 0,
        expectedIsToggleInteractionEnabledPublishedSinkCount: Int = 0,
        expectedToggleOpacityPublishedSinkCount: Int = 0,
        expectedToggleBackgroundColorTokenPublishedSinkCount: Int = 0,
        expectedToggleDotBackgroundColorTokenPublishedSinkCount: Int = 0,
        expectedToggleDotForegroundColorTokenPublishedSinkCount: Int = 0,
        expectedTextForegroundColorTokenPublishedSinkCount: Int = 0,
        expectedIsToggleOnLeftPublishedSinkCount: Int = 0,
        expectedHorizontalSpacingPublishedSinkCount: Int = 0,
        expectedShowToggleLeftSpacePublishedSinkCount: Int = 0,
        expectedToggleDotImagePublishedSinkCount: Int = 0,
        expectedDisplayedTextPublishedSinkCount: Int = 0,
        expectedTextFontTokenPublishedSinkCount: Int = 0
    ) {
        XCTAssertPublisherSinkCountEqual(
            on: stub.isOnChangedPublisherMock,
            expectedIsOnChangedPublishedSinkCount
        )

        XCTAssertPublisherSinkCountEqual(
            on: stub.isToggleInteractionEnabledPublisherMock,
            expectedIsToggleInteractionEnabledPublishedSinkCount
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.toggleOpacityPublisherMock,
            expectedToggleOpacityPublishedSinkCount
        )

        XCTAssertPublisherSinkCountEqual(
            on: stub.toggleBackgroundColorTokenPublisherMock,
            expectedToggleBackgroundColorTokenPublishedSinkCount
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.toggleDotBackgroundColorTokenPublisherMock,
            expectedToggleDotBackgroundColorTokenPublishedSinkCount
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.toggleDotForegroundColorTokenPublisherMock,
            expectedToggleDotForegroundColorTokenPublishedSinkCount
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.textForegroundColorTokenPublisherMock,
            expectedTextForegroundColorTokenPublishedSinkCount
        )

        XCTAssertPublisherSinkCountEqual(
            on: stub.horizontalSpacingPublisherMock,
            expectedHorizontalSpacingPublishedSinkCount
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.showToggleLeftSpacePublisherMock,
            expectedShowToggleLeftSpacePublishedSinkCount
        )

        XCTAssertPublisherSinkCountEqual(
            on: stub.toggleDotImagesStatePublisherMock,
            expectedToggleDotImagePublishedSinkCount
        )

        XCTAssertPublisherSinkCountEqual(
            on: stub.displayedTextPublisherMock,
            expectedDisplayedTextPublishedSinkCount
        )

        XCTAssertPublisherSinkCountEqual(
            on: stub.textFontTokenPublisherMock,
            expectedTextFontTokenPublishedSinkCount
        )
    }

    func testIsOnChanged(
        on stub: Stub,
        expectedValue: Bool? = true
    ) {
        if let expectedValue {
            XCTAssertPublisherSinkValueEqual(
                on: stub.isOnChangedPublisherMock,
                expectedValue
            )
        } else {
            XCTAssertPublisherSinkValueNil(
                on: stub.isOnChangedPublisherMock
            )
        }
    }

    func testPosition(
        on stub: Stub,
        expectedContainsValue: Bool = true
    ) {
        if expectedContainsValue {
            XCTAssertPublisherSinkValueEqual(
                on: stub.isToggleOnLeftPublisherMock,
                stub.positionMock.isToggleOnLeft
            )
            XCTAssertPublisherSinkValueEqual(
                on: stub.horizontalSpacingPublisherMock,
                stub.positionMock.horizontalSpacing
            )
        } else {
            XCTAssertPublisherSinkValueNil(
                on: stub.isToggleOnLeftPublisherMock
            )
            XCTAssertPublisherSinkValueNil(
                on: stub.horizontalSpacingPublisherMock
            )
        }
    }

    func testColors(
        on stub: Stub,
        expectedContainsValue: Bool = true,
        expectedTextForegroundColorContainsValue: Bool = false
    ) {
        if expectedContainsValue {
            XCTAssertPublisherSinkValueIdentical(
                on: stub.toggleBackgroundColorTokenPublisherMock,
                stub.colorTokenMock
            )
            XCTAssertPublisherSinkValueIdentical(
                on: stub.toggleDotBackgroundColorTokenPublisherMock,
                stub.colorsMock.toggleDotBackgroundColor as? ColorTokenGeneratedMock
            )
            XCTAssertPublisherSinkValueIdentical(
                on: stub.toggleDotForegroundColorTokenPublisherMock,
                stub.colorTokenMock
            )
        } else {
            XCTAssertPublisherSinkValueNil(
                on: stub.toggleBackgroundColorTokenPublisherMock
            )
            XCTAssertPublisherSinkValueNil(
                on: stub.toggleDotBackgroundColorTokenPublisherMock
            )
            XCTAssertPublisherSinkValueNil(
                on: stub.toggleDotForegroundColorTokenPublisherMock
            )
        }

        if expectedContainsValue || expectedTextForegroundColorContainsValue {
            XCTAssertPublisherSinkValueIdentical(
                on: stub.textForegroundColorTokenPublisherMock,
                stub.colorsMock.textForegroundColor as? ColorTokenGeneratedMock
            )
        } else {
            XCTAssertPublisherSinkValueNil(
                on: stub.textForegroundColorTokenPublisherMock
            )
        }
    }

    func testToggleState(
        on stub: Stub,
        expectedContainsValue: Bool = true
    ) {
        if expectedContainsValue {
            XCTAssertPublisherSinkValueEqual(
                on: stub.isToggleInteractionEnabledPublisherMock,
                stub.toggleStateMock.interactionEnabled
            )
            XCTAssertPublisherSinkValueEqual(
                on: stub.toggleOpacityPublisherMock,
                stub.toggleStateMock.opacity
            )
        } else {
            XCTAssertPublisherSinkValueNil(
                on: stub.isToggleInteractionEnabledPublisherMock
            )
            XCTAssertPublisherSinkValueNil(
                on: stub.toggleOpacityPublisherMock
            )
        }
    }

    func testToggleDotImage(
        on stub: Stub,
        expectedContainsValue: Bool = true
    ) {
        if expectedContainsValue {
            XCTAssertPublisherSinkValueEqual(
                on: stub.toggleDotImagesStatePublisherMock,
                .mocked()
            )
        } else {
            XCTAssertPublisherSinkValueNil(
                on: stub.toggleDotImagesStatePublisherMock
            )
        }
    }

    func testDisplayedText(
        on stub: Stub,
        givenNewTheme: Theme? = nil,
        expectedContainsValue: Bool = true
    ) {
        if expectedContainsValue {
            XCTAssertPublisherSinkValueEqual(
                on: stub.displayedTextPublisherMock,
                .mocked()
            )
        } else {
            XCTAssertPublisherSinkValueNil(
                on: stub.displayedTextPublisherMock
            )
        }
    }

    func testTextFont(
        on stub: Stub,
        givenNewTheme: Theme? = nil,
        expectedContainsValue: Bool = true
    ) {
        if expectedContainsValue {
            let themeMock = givenNewTheme ?? stub.themeMock
            XCTAssertPublisherSinkValueIdentical(
                on: stub.textFontTokenPublisherMock,
                themeMock.typography.body1 as? TypographyFontTokenGeneratedMock
            )
        } else {
            XCTAssertPublisherSinkValueNil(
                on: stub.textFontTokenPublisherMock
            )
        }
    }

    func testShowToggleLeftSpace(
        on stub: Stub,
        expectedValue: Bool? = nil
    ) {
        if let expectedValue {
            XCTAssertPublisherSinkValueEqual(
                on: stub.showToggleLeftSpacePublisherMock,
                expectedValue
            )
        } else {
            XCTAssertPublisherSinkValueNil(
                on: stub.showToggleLeftSpacePublisherMock
            )
        }
    }
}

// MARK: - Stub

private final class Stub {

    // MARK: - Properties

    let viewModel: SwitchViewModel

    // MARK: - Data Properties

    let frameworkType: FrameworkType
    let isOnMock: Bool

    let themeMock = ThemeGeneratedMock.mocked()

    let colorsMock = SwitchColors.mocked()

    let imageMock = IconographyTests.shared.switchOn
    let imagesMock = SwitchUIImages(on: UIImage(), off: UIImage())

    let colorTokenMock = ColorTokenGeneratedMock.random()

    let positionMock = SwitchPosition.mocked()

    let toggleStateMock: SwitchToggleState

    // MARK: - Dependencies Properties

    let getColorsUseCaseMock: SwitchGetColorsUseCaseableGeneratedMock
    let getImagesStateUseCaseMock: SwitchGetImagesStateUseCaseableGeneratedMock
    let getToggleColorUseCaseMock: SwitchGetToggleColorUseCaseableGeneratedMock
    let getPositionUseCaseMock: SwitchGetPositionUseCaseableGeneratedMock
    let getToggleStateUseCaseMock: SwitchGetToggleStateUseCaseableGeneratedMock
    let displayedTextViewModelMock: DisplayedTextViewModelGeneratedMock

    let dependenciesMock: SwitchViewModelDependenciesProtocolGeneratedMock

    // MARK: - Publisher Properties

    let isOnChangedPublisherMock: PublisherMock<Published<Bool?>.Publisher>
    let isToggleInteractionEnabledPublisherMock: PublisherMock<Published<Bool?>.Publisher>
    let toggleOpacityPublisherMock: PublisherMock<Published<CGFloat?>.Publisher>
    let toggleBackgroundColorTokenPublisherMock: PublisherMock<Published<ColorToken?>.Publisher>
    let toggleDotBackgroundColorTokenPublisherMock: PublisherMock<Published<ColorToken?>.Publisher>
    let toggleDotForegroundColorTokenPublisherMock: PublisherMock<Published<ColorToken?>.Publisher>
    let textForegroundColorTokenPublisherMock: PublisherMock<Published<ColorToken?>.Publisher>
    let isToggleOnLeftPublisherMock: PublisherMock<Published<Bool?>.Publisher>
    let horizontalSpacingPublisherMock: PublisherMock<Published<CGFloat?>.Publisher>
    let showToggleLeftSpacePublisherMock: PublisherMock<Published<Bool?>.Publisher>
    let toggleDotImagesStatePublisherMock: PublisherMock<Published<SwitchImagesState?>.Publisher>
    let displayedTextPublisherMock: PublisherMock<Published<DisplayedText?>.Publisher>
    let textFontTokenPublisherMock: PublisherMock<Published<TypographyFontToken?>.Publisher>

    // MARK: - Initialization

    init(
        frameworkType: FrameworkType = .uiKit,
        isOn: Bool = true,
        alignment: SwitchAlignment = .left,
        intent: SwitchIntent = .alert,
        isEnabled: Bool = true,
        isImages: Bool = false,
        text: String? = nil,
        attributedText: NSAttributedString? = nil,
        userInteractionEnabled: Bool = true
    ) {
        // Data properties
        self.frameworkType = frameworkType
        self.isOnMock = isOn

        let toggleStateMock = SwitchToggleState.mocked(
            interactionEnabled: userInteractionEnabled
        )
        self.toggleStateMock = toggleStateMock

        // **
        // Dependencies
        let getColorsUseCaseMock = SwitchGetColorsUseCaseableGeneratedMock()
        getColorsUseCaseMock.executeWithIntentAndColorsAndDimsReturnValue = self.colorsMock
        self.getColorsUseCaseMock = getColorsUseCaseMock

        let getImagesStateUseCaseMock = SwitchGetImagesStateUseCaseableGeneratedMock()
        getImagesStateUseCaseMock.executeWithIsOnAndImagesReturnValue = .mocked()
        self.getImagesStateUseCaseMock = getImagesStateUseCaseMock

        let getToggleColorUseCaseMock = SwitchGetToggleColorUseCaseableGeneratedMock()
        getToggleColorUseCaseMock.executeWithIsOnAndStatusAndStateColorReturnValue = self.colorTokenMock
        self.getToggleColorUseCaseMock = getToggleColorUseCaseMock

        let getPositionUseCaseMock = SwitchGetPositionUseCaseableGeneratedMock()
        getPositionUseCaseMock.executeWithAlignmentAndSpacingAndContainsTextReturnValue = self.positionMock
        self.getPositionUseCaseMock = getPositionUseCaseMock

        let getToggleStateUseCaseMock = SwitchGetToggleStateUseCaseableGeneratedMock()
        getToggleStateUseCaseMock.executeWithIsEnabledAndDimsReturnValue = toggleStateMock
        self.getToggleStateUseCaseMock = getToggleStateUseCaseMock

        let displayedTextViewModelMock = DisplayedTextViewModelGeneratedMock()
        displayedTextViewModelMock.underlyingDisplayedTextType = .text
        displayedTextViewModelMock.displayedText = .mocked()
        self.displayedTextViewModelMock = displayedTextViewModelMock

        let dependenciesMock = SwitchViewModelDependenciesProtocolGeneratedMock()
        dependenciesMock.underlyingGetColorsUseCase = self.getColorsUseCaseMock
        dependenciesMock.underlyingGetImagesStateUseCase = self.getImagesStateUseCaseMock
        dependenciesMock.underlyingGetToggleColorUseCase = self.getToggleColorUseCaseMock
        dependenciesMock.underlyingGetPositionUseCase = self.getPositionUseCaseMock
        dependenciesMock.underlyingGetToggleStateUseCase = self.getToggleStateUseCaseMock
        dependenciesMock.makeDisplayedTextViewModelWithTextAndAttributedTextReturnValue = self.displayedTextViewModelMock
        self.dependenciesMock = dependenciesMock
        // **

        // **
        // View Model
        let imagesEither: SwitchImagesEither?
        if isImages {
            imagesEither = .left(self.imagesMock)
        } else {
            imagesEither = nil
        }

        let attributedTextEither: AttributedStringEither?
        if let attributedText {
            attributedTextEither = .left(attributedText)
        } else {
            attributedTextEither = nil
        }

        let viewModel = SwitchViewModel(
            for: frameworkType,
            theme: self.themeMock,
            isOn: isOn,
            alignment: alignment,
            intent: intent,
            isEnabled: isEnabled,
            images:  imagesEither,
            text: text,
            attributedText: attributedTextEither,
            dependencies: dependenciesMock
        )
        self.viewModel = viewModel
        // **

        // **
        // Publishers
        self.isOnChangedPublisherMock = .init(publisher: viewModel.$isOnChanged)
        self.isToggleInteractionEnabledPublisherMock = .init(publisher: viewModel.$isToggleInteractionEnabled)
        self.toggleOpacityPublisherMock = .init(publisher: viewModel.$toggleOpacity)
        self.toggleBackgroundColorTokenPublisherMock = .init(publisher: viewModel.$toggleBackgroundColorToken)
        self.toggleDotBackgroundColorTokenPublisherMock = .init(publisher: viewModel.$toggleDotBackgroundColorToken)
        self.toggleDotForegroundColorTokenPublisherMock = .init(publisher: viewModel.$toggleDotForegroundColorToken)
        self.textForegroundColorTokenPublisherMock = .init(publisher: viewModel.$textForegroundColorToken)
        self.isToggleOnLeftPublisherMock = .init(publisher: viewModel.$isToggleOnLeft)
        self.horizontalSpacingPublisherMock = .init(publisher: viewModel.$horizontalSpacing)
        self.showToggleLeftSpacePublisherMock = .init(publisher: viewModel.$showToggleLeftSpace)
        self.toggleDotImagesStatePublisherMock = .init(publisher: viewModel.$toggleDotImagesState)
        self.displayedTextPublisherMock = .init(publisher: viewModel.$displayedText)
        self.textFontTokenPublisherMock = .init(publisher: viewModel.$textFontToken)
        // **
    }

    func subscribePublishers(on subscriptions: inout Set<AnyCancellable>) {
        self.isOnChangedPublisherMock.loadTesting(on: &subscriptions)
        self.isToggleInteractionEnabledPublisherMock.loadTesting(on: &subscriptions)
        self.toggleOpacityPublisherMock.loadTesting(on: &subscriptions)
        self.toggleBackgroundColorTokenPublisherMock.loadTesting(on: &subscriptions)
        self.toggleDotBackgroundColorTokenPublisherMock.loadTesting(on: &subscriptions)
        self.toggleDotForegroundColorTokenPublisherMock.loadTesting(on: &subscriptions)
        self.textForegroundColorTokenPublisherMock.loadTesting(on: &subscriptions)
        self.isToggleOnLeftPublisherMock.loadTesting(on: &subscriptions)
        self.horizontalSpacingPublisherMock.loadTesting(on: &subscriptions)
        self.showToggleLeftSpacePublisherMock.loadTesting(on: &subscriptions)
        self.toggleDotImagesStatePublisherMock.loadTesting(on: &subscriptions)
        self.displayedTextPublisherMock.loadTesting(on: &subscriptions)
        self.textFontTokenPublisherMock.loadTesting(on: &subscriptions)
    }

    func resetMockedData() {
        // Clear UseCases Mock
        let useCases: [ResetGeneratedMock] = [
            self.getColorsUseCaseMock,
            self.getImagesStateUseCaseMock,
            self.getToggleColorUseCaseMock,
            self.getPositionUseCaseMock,
            self.getToggleStateUseCaseMock
        ]
        useCases.forEach { $0.reset() }

        // Reset published sink counter
        self.isOnChangedPublisherMock.reset()
        self.isToggleInteractionEnabledPublisherMock.reset()
        self.toggleOpacityPublisherMock.reset()
        self.toggleBackgroundColorTokenPublisherMock.reset()
        self.toggleDotBackgroundColorTokenPublisherMock.reset()
        self.toggleDotForegroundColorTokenPublisherMock.reset()
        self.textForegroundColorTokenPublisherMock.reset()
        self.isToggleOnLeftPublisherMock.reset()
        self.horizontalSpacingPublisherMock.reset()
        self.showToggleLeftSpacePublisherMock.reset()
        self.toggleDotImagesStatePublisherMock.reset()
        self.displayedTextPublisherMock.reset()
        self.textFontTokenPublisherMock.reset()
    }
}
