//
//  ButtonViewModelTests.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 25.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import SparkCore
@testable import Spark
import Combine

final class ButtonViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Setup

    override func tearDown() {
        super.tearDown()

        // Clear publishers
        self.subscriptions.removeAll()
    }

    // MARK: - Init Tests

    func test_properties_on_init() throws {
        // GIVEN
        let intentMock: ButtonIntent = .danger
        let variantMock: ButtonVariant = .filled
        let sizeMock: ButtonSize = .large
        let shapeMock: ButtonShape = .pill
        let alignmentMock: ButtonAlignment = .leadingIcon
        let textMock = "My Button"
        let attributedTextMock = NSAttributedString(string: "My AT Button")
        let isEnabledMock = true

        let stub = Stub(
            intent: intentMock,
            variant: variantMock,
            size: sizeMock,
            shape: shapeMock,
            alignment: alignmentMock,
            isIconImage: true,
            text: textMock,
            attributedText: attributedTextMock,
            isEnabled: isEnabledMock
        )

        // WHEN
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        // THEN
        XCTAssertIdentical(viewModel.theme as? ThemeGeneratedMock,
                           stub.themeMock,
                           "Wrong theme value")
        XCTAssertEqual(viewModel.intent,
                       intentMock,
                       "Wrong intent value")
        XCTAssertEqual(viewModel.variant,
                       variantMock,
                       "Wrong variant value")
        XCTAssertEqual(viewModel.size,
                       sizeMock,
                       "Wrong size value")
        XCTAssertEqual(viewModel.shape,
                       shapeMock,
                       "Wrong shape value")
        XCTAssertEqual(viewModel.alignment,
                       alignmentMock,
                       "Wrong alignment value")
        XCTAssertEqual(viewModel.iconImage?.leftValue,
                       stub.iconImageMock,
                       "Wrong images value")
        XCTAssertEqual(viewModel.isEnabled,
                       isEnabledMock,
                       "Wrong isEnabled value")
        // **
        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.statePublisherMock,
            1
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.currentColorsPublisherMock,
            1
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.sizesPublisherMock,
            1
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.borderPublisherMock,
            1
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.spacingsPublisherMock,
            1
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.contentPublisherMock,
            1
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.textFontTokenPublisherMock,
            1
        )
        // **

        // **
        // Use Cases
        self.testGetBorderUseCaseMock(
            on: stub,
            numberOfCalls: 0
        )
        self.testGetColorsUseCaseMock(
            on: stub,
            numberOfCalls: 0
        )
        self.testGetContentUseCaseMock(
            on: stub,
            numberOfCalls: 0
        )
        self.testGetCurrentColorsUseCaseMock(
            on: stub,
            numberOfCalls: 0
        )
        self.testGetIsIconOnlyUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenIconImage: stub.iconImageMock
        )
        self.testGetSizesUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenSize: sizeMock,
            givenIsOnlyIcon: stub.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            on: stub,
            numberOfCalls: 0
        )
        self.testGetStateUseCaseMock(
            on: stub,
            numberOfCalls: 0
        )
        // **
    }

    // MARK: - Load Tests

    func test_published_properties_on_load() throws {
        // GIVEN
        let intentMock: ButtonIntent = .support
        let variantMock: ButtonVariant = .outlined
        let sizeMock: ButtonSize = .medium
        let shapeMock: ButtonShape = .rounded
        let alignmentMock: ButtonAlignment = .trailingIcon
        let textMock = "My Button"
        let attributedTextMock = NSAttributedString(string: "My AT Button")
        let isEnabledMock = false

        let stub = Stub(
            intent: intentMock,
            variant: variantMock,
            size: sizeMock,
            shape: shapeMock,
            alignment: alignmentMock,
            isIconImage: true,
            text: textMock,
            attributedText: attributedTextMock,
            isEnabled: isEnabledMock
        )

        // WHEN
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load()

        // THEN
        // **
        // Published properties
        self.testState(on: stub)
        self.testCurrentColors(on: stub)
        self.testSizes(on: stub)
        self.testBorder(on: stub)
        self.testSpacings(on: stub)
        self.testContent(on: stub)
        self.testTextFontToken(on: stub)

        XCTAssertPublisherSinkCountEqual(
            on: stub.statePublisherMock,
            2
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.currentColorsPublisherMock,
            2
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.sizesPublisherMock,
            2
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.borderPublisherMock,
            2
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.spacingsPublisherMock,
            2
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.contentPublisherMock,
            2
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.textFontTokenPublisherMock,
            2
        )
        // **

        // **
        // Use Cases
        self.testGetBorderUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenShape: shapeMock,
            givenTheme: stub.themeMock,
            givenVariant: variantMock
        )
        self.testGetColorsUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenTheme: stub.themeMock,
            givenIntent: intentMock,
            givenVariant: variantMock
        )
        self.testGetContentUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenAlignment: alignmentMock,
            givenIconImage: stub.iconImageMock
        )
        self.testGetCurrentColorsUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenColors: stub.colorsMock,
            givenIsPressed: false
        )
        self.testGetIsIconOnlyUseCaseMock(
            on: stub,
            numberOfCalls: 3,
            givenIconImage: stub.iconImageMock
        )
        self.testGetSizesUseCaseMock(
            on: stub,
            numberOfCalls: 2,
            givenSize: sizeMock,
            givenIsOnlyIcon: stub.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenTheme: stub.themeMock,
            givenIsOnlyIcon: stub.isIconOnlyMock
        )
        self.testGetStateUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenTheme: stub.themeMock,
            givenIsEnabled: isEnabledMock
        )
        // **
    }

    // MARK: - Actions Tests

    func test_pressedAction_when_viewModel_is_not_already_pressed_state() {
        self.testPressedAction(
            isPressedAction: true,
            isAlreadyOnPressedState: false
        )
    }

    func test_pressedAction_when_viewModel_is_already_pressed_state() {
        self.testPressedAction(
            isPressedAction: true,
            isAlreadyOnPressedState: true
        )
    }

    func test_unpressedAction_when_viewModel_is_not_already_unpressed_state() {
        self.testPressedAction(
            isPressedAction: false,
            isAlreadyOnPressedState: false
        )
    }

    func test_unpressedAction_when_viewModel_is_already_unpressed_state() {
        self.testPressedAction(
            isPressedAction: false,
            isAlreadyOnPressedState: true
        )
    }

    private func testPressedAction(
        isPressedAction: Bool,
        isAlreadyOnPressedState: Bool
    ) {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load()// Needed to get colors from usecase one time

        // Simulate action to toggle the isPressed value on viewModel
        if isPressedAction {
            if isAlreadyOnPressedState {
                viewModel.pressedAction()
            }
        } else {
            if isAlreadyOnPressedState {
                viewModel.unpressedAction()
            } else {
                viewModel.pressedAction()
            }
        }

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        if isPressedAction {
            viewModel.pressedAction()
        } else {
            viewModel.unpressedAction()
        }

        // THEN
        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.currentColorsPublisherMock,
            !isAlreadyOnPressedState ? 1 : 0
        )

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            on: stub,
            numberOfCalls: 0
        )
        self.testGetCurrentColorsUseCaseMock(
            on: stub,
            numberOfCalls: !isAlreadyOnPressedState ? 1 : 0,
            givenColors: stub.colorsMock,
            givenIsPressed: isPressedAction
        )
        // **
    }

    // MARK: - Setter Tests

    func test_set_theme() {
        // GIVEN
        let intentMock: ButtonIntent = .support
        let variantMock: ButtonVariant = .outlined
        let sizeMock: ButtonSize = .medium
        let shapeMock: ButtonShape = .rounded
        let alignmentMock: ButtonAlignment = .trailingIcon
        let textMock = "My Button"
        let attributedTextMock = NSAttributedString(string: "My AT Button")
        let isEnabledMock = false

        let stub = Stub(
            intent: intentMock,
            variant: variantMock,
            size: sizeMock,
            shape: shapeMock,
            alignment: alignmentMock,
            isIconImage: true,
            text: textMock,
            attributedText: attributedTextMock,
            isEnabled: isEnabledMock
        )
        let viewModel = stub.viewModel

        let newThemeMock = stub.themeMock

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        viewModel.set(theme: newThemeMock)

        // THEN
        // **
        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.statePublisherMock,
            1
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.currentColorsPublisherMock,
            1
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.sizesPublisherMock,
            1
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.borderPublisherMock,
            1
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.spacingsPublisherMock,
            1
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.textFontTokenPublisherMock,
            1
        )
        // **

        // **
        // Use Cases
        self.testGetBorderUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenShape: shapeMock,
            givenTheme: newThemeMock,
            givenVariant: variantMock
        )
        self.testGetColorsUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenTheme: newThemeMock,
            givenIntent: intentMock,
            givenVariant: variantMock
        )
        self.testGetCurrentColorsUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenColors: stub.colorsMock,
            givenIsPressed: false
        )
        self.testGetSizesUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenSize: sizeMock,
            givenIsOnlyIcon: stub.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenTheme: newThemeMock,
            givenIsOnlyIcon: stub.isIconOnlyMock
        )
        self.testGetStateUseCaseMock(
            on: stub,
            numberOfCalls: 1,
            givenTheme: newThemeMock,
            givenIsEnabled: isEnabledMock
        )
        // **
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
        let defaultValue: ButtonIntent = .alert
        let newValue: ButtonIntent = givenIsDifferentNewValue ? .accent : defaultValue

        let variantMock: ButtonVariant = .outlined

        let stub = Stub(
            intent: defaultValue,
            variant: variantMock
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        viewModel.set(intent: newValue)

        // THEN
        XCTAssertEqual(viewModel.intent,
                       newValue,
                       "Wrong intent value")

        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.currentColorsPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenTheme: stub.themeMock,
            givenIntent: newValue,
            givenVariant: variantMock
        )
        self.testGetCurrentColorsUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenColors: stub.colorsMock,
            givenIsPressed: false
        )
        // **
    }

    func test_set_variant_with_different_new_value() {
        self.testSetVariant(
            givenIsDifferentNewValue: true
        )
    }

    func test_set_variant_with_same_new_value() {
        self.testSetVariant(
            givenIsDifferentNewValue: false
        )
    }

    private func testSetVariant(
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let defaultValue: ButtonVariant = .contrast
        let newValue: ButtonVariant = givenIsDifferentNewValue ? .outlined : defaultValue

        let intentMock: ButtonIntent = .success
        let shapeMock: ButtonShape = .square

        let stub = Stub(
            intent: intentMock,
            variant: defaultValue,
            shape: shapeMock
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        viewModel.set(variant: newValue)

        // THEN
        XCTAssertEqual(viewModel.variant,
                       newValue,
                       "Wrong variant value")

        // **
        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.currentColorsPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.borderPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )
        // **

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenTheme: stub.themeMock,
            givenIntent: intentMock,
            givenVariant: newValue
        )
        self.testGetCurrentColorsUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenColors: stub.colorsMock,
            givenIsPressed: false
        )
        self.testGetBorderUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenShape: shapeMock,
            givenTheme: stub.themeMock,
            givenVariant: newValue
        )
        // **
    }

    func test_set_size_with_different_new_value() {
        self.testSetSize(
            givenIsDifferentNewValue: true
        )
    }

    func test_set_size_with_same_new_value() {
        self.testSetSize(
            givenIsDifferentNewValue: false
        )
    }

    private func testSetSize(
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let defaultValue: ButtonSize = .large
        let newValue: ButtonSize = givenIsDifferentNewValue ? .small : defaultValue

        let stub = Stub(
            size: defaultValue
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        viewModel.set(size: newValue)

        // THEN
        XCTAssertEqual(viewModel.size,
                       newValue,
                       "Wrong size value")

        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.sizesPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )

        // **
        // Use Cases
        self.testGetSizesUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenSize: newValue,
            givenIsOnlyIcon: stub.isIconOnlyMock
        )
        // **
    }

    func test_set_shape_with_different_new_value() {
        self.testSetShape(
            givenIsDifferentNewValue: true
        )
    }

    func test_set_shape_with_same_new_value() {
        self.testSetShape(
            givenIsDifferentNewValue: false
        )
    }

    private func testSetShape(
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let defaultValue: ButtonShape = .pill
        let newValue: ButtonShape = givenIsDifferentNewValue ? .rounded : defaultValue

        let variantMock: ButtonVariant = .tinted

        let stub = Stub(
            variant: variantMock,
            shape: defaultValue
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        viewModel.set(shape: newValue)

        // THEN
        XCTAssertEqual(viewModel.shape,
                       newValue,
                       "Wrong shape value")

        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.borderPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )

        // **
        // Use Cases
        self.testGetBorderUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenShape: newValue,
            givenTheme: stub.themeMock,
            givenVariant: variantMock
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

    private func testSetAlignment(
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let defaultValue: ButtonAlignment = .leadingIcon
        let newValue: ButtonAlignment = givenIsDifferentNewValue ? .trailingIcon : defaultValue

        let sizeMock: ButtonSize = .medium

        let stub = Stub(
            size: sizeMock,
            alignment: defaultValue
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        viewModel.set(alignment: newValue)

        // THEN
        XCTAssertEqual(viewModel.alignment,
                       newValue,
                       "Wrong alignment value")

        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.contentPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )

        // **
        // Use Cases
        self.testGetContentUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenAlignment: newValue
        )
        // **
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

        let sizeMock: ButtonSize = .medium
        let alignmentMock: ButtonAlignment = .trailingIcon

        let stub = Stub(
            size: sizeMock,
            alignment: alignmentMock,
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
        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.contentPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.sizesPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.spacingsPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.currentColorsPublisherMock,
            givenIsDifferentNewValue && !newValueIsNil ? 1 : 0
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.textFontTokenPublisherMock,
            givenIsDifferentNewValue && !newValueIsNil ? 1 : 0
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

        // **
        // Use Cases
        self.testGetIsIconOnlyUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 2 : 0,
            givenIconImage: nil
        )
        self.testGetContentUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenAlignment: alignmentMock,
            givenIconImage: nil
        )
        self.testGetSizesUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenSize: sizeMock,
            givenIsOnlyIcon: stub.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenTheme: stub.themeMock,
            givenIsOnlyIcon: stub.isIconOnlyMock
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
        let newValue = NSAttributedString(string: "My new AT Button")

        let sizeMock: ButtonSize = .medium
        let alignmentMock: ButtonAlignment = .trailingIcon

        let stub = Stub(
            size: sizeMock,
            alignment: alignmentMock,
            attributedText: .init(string: "My AT Button")
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
        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.contentPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.sizesPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.spacingsPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
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

        // **
        // Use Cases
        self.testGetIsIconOnlyUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 2 : 0,
            givenIconImage: nil
        )
        self.testGetContentUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenAlignment: alignmentMock,
            givenIconImage: nil
        )
        self.testGetSizesUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenSize: sizeMock,
            givenIsOnlyIcon: stub.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenTheme: stub.themeMock,
            givenIsOnlyIcon: stub.isIconOnlyMock
        )
        // **
    }

    func test_set_iconImage_with_different_new_value() {
        // GIVEN
        self.testSetIconImage(
            givenIsDifferentNewValue: true
        )
    }

    func test_set_iconImage_with_same_new_value() {
        self.testSetIconImage(
            givenIsDifferentNewValue: false
        )
    }

    private func testSetIconImage(
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let sizeMock: ButtonSize = .medium
        let alignmentMock: ButtonAlignment = .trailingIcon

        let stub = Stub(
            size: sizeMock,
            alignment: alignmentMock,
            isIconImage: true
        )
        let viewModel = stub.viewModel

        let newValue = givenIsDifferentNewValue ? IconographyTests.shared.checkmark : stub.iconImageMock

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        viewModel.set(iconImage: .left(newValue))

        // THEN
        XCTAssertEqual(viewModel.iconImage?.leftValue,
                       newValue,
                       "Wrong iconImage value")

        // **
        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.contentPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.sizesPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )
        XCTAssertPublisherSinkCountEqual(
            on: stub.spacingsPublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )
        // **

        // **
        // Use Cases
        self.testGetIsIconOnlyUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 2 : 0,
            givenIconImage: newValue
        )
        self.testGetContentUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenAlignment: alignmentMock,
            givenIconImage: newValue
        )
        self.testGetSizesUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenSize: sizeMock,
            givenIsOnlyIcon: stub.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenTheme: stub.themeMock,
            givenIsOnlyIcon: stub.isIconOnlyMock
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

    private func testSetIsEnabled(
        givenIsDifferentNewValue: Bool
    ) {
        // GIVEN
        let defaultValue: Bool = true
        let newValue: Bool = givenIsDifferentNewValue ? false : defaultValue

        let stub = Stub(
            isEnabled: defaultValue
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        viewModel.set(isEnabled: newValue)

        // THEN
        XCTAssertEqual(viewModel.isEnabled,
                       newValue,
                       "Wrong isEnabled value")

        // Published count
        XCTAssertPublisherSinkCountEqual(
            on: stub.statePublisherMock,
            givenIsDifferentNewValue ? 1 : 0
        )

        // **
        // Use Cases
        self.testGetStateUseCaseMock(
            on: stub,
            numberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenTheme: stub.themeMock,
            givenIsEnabled: newValue
        )
        // **
    }
}

// MARK: - Testing Published Data

private extension ButtonViewModelTests {

    private func testState(on stub: Stub) {
        XCTAssertPublisherSinkValueEqual(
            on: stub.statePublisherMock,
            stub.stateMock
        )
    }

    private func testCurrentColors(on stub: Stub) {
        XCTAssertPublisherSinkValueEqual(
            on: stub.currentColorsPublisherMock,
            stub.currentColorsMock
        )
    }

    private func testSizes(on stub: Stub) {
        XCTAssertPublisherSinkValueEqual(
            on: stub.sizesPublisherMock,
            stub.sizesMock
        )
    }

    private func testBorder(on stub: Stub) {
        XCTAssertPublisherSinkValueEqual(
            on: stub.borderPublisherMock,
            stub.borderMock
        )
    }

    private func testSpacings(on stub: Stub) {
        XCTAssertPublisherSinkValueEqual(
            on: stub.spacingsPublisherMock,
            stub.spacingsMock
        )
    }

    private func testContent(on stub: Stub) {
        XCTAssertPublisherSinkValueEqual(
            on: stub.contentPublisherMock,
            stub.contentMock
        )
    }

    private func testTextFontToken(on stub: Stub) {
        XCTAssertPublisherSinkValueIdentical(
            on: stub.textFontTokenPublisherMock,
            stub.themeMock.typography.callout as? TypographyFontTokenGeneratedMock
        )
    }
}

// MARK: - Testing Dependencies

private extension ButtonViewModelTests {

    private func testGetBorderUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenShape: ButtonShape? = nil,
        givenTheme: ThemeGeneratedMock? = nil,
        givenVariant: ButtonVariant? = nil
    ) {
        XCTAssertEqual(stub.getBorderUseCaseMock.executeWithShapeAndBorderAndVariantCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getBorderUseCase")

        if numberOfCalls > 0, let givenShape, let givenTheme, let givenVariant {
            let getBorderUseCaseArgs = stub.getBorderUseCaseMock.executeWithShapeAndBorderAndVariantReceivedArguments
            XCTAssertEqual(getBorderUseCaseArgs?.shape,
                           givenShape,
                           "Wrong shape parameter on execute on getBorderUseCase")
            XCTAssertIdentical(try XCTUnwrap(getBorderUseCaseArgs?.border as? BorderGeneratedMock),
                               givenTheme.border as? BorderGeneratedMock,
                               "Wrong border parameter on execute on getBorderUseCase")
            XCTAssertEqual(getBorderUseCaseArgs?.variant,
                           givenVariant,
                           "Wrong variant parameter on execute on getBorderUseCase")
        }
    }

    private func testGetColorsUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenTheme: ThemeGeneratedMock? = nil,
        givenIntent: ButtonIntent? = nil,
        givenVariant: ButtonVariant? = nil
    ) {
        XCTAssertEqual(stub.getColorsUseCaseMock.executeWithThemeAndIntentAndVariantCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getColorsUseCase")

        if numberOfCalls > 0, let givenTheme, let givenIntent, let givenVariant {
            let getColorsUseCaseArgs = stub.getColorsUseCaseMock.executeWithThemeAndIntentAndVariantReceivedArguments
            XCTAssertIdentical(try XCTUnwrap(getColorsUseCaseArgs?.theme as? ThemeGeneratedMock),
                               givenTheme,
                               "Wrong theme parameter on execute on getColorsUseCase")
            XCTAssertEqual(getColorsUseCaseArgs?.intent,
                           givenIntent,
                           "Wrong intent parameter on execute on getColorsUseCase")
            XCTAssertEqual(getColorsUseCaseArgs?.variant,
                           givenVariant,
                           "Wrong variant parameter on execute on getColorsUseCase")
        }
    }

    private func testGetContentUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenAlignment: ButtonAlignment? = nil,
        givenIconImage: UIImage? = nil
    ) {
        XCTAssertEqual(stub.getContentUseCaseMock.executeWithAlignmentAndIconImageAndTextAndAttributedTextCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getContentUseCase")

        if numberOfCalls > 0, let givenAlignment {
            let getContentUseCaseArgs = stub.getContentUseCaseMock.executeWithAlignmentAndIconImageAndTextAndAttributedTextReceivedArguments
            XCTAssertEqual(getContentUseCaseArgs?.alignment,
                           givenAlignment,
                           "Wrong alignment parameter on execute on getContentUseCase")
            XCTAssertEqual(getContentUseCaseArgs?.iconImage?.leftValue,
                           givenIconImage,
                           "Wrong iconImage parameter on execute on getContentUseCase")
            XCTAssertEqual(getContentUseCaseArgs?.text,
                           stub.displayedTextViewModelMock.text,
                           "Wrong text parameter on execute on getContentUseCase")
            XCTAssertEqual(getContentUseCaseArgs?.attributedText,
                           stub.displayedTextViewModelMock.attributedText,
                           "Wrong attributedText parameter on execute on getContentUseCase")
        }
    }

    private func testGetCurrentColorsUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenColors: ButtonColors? = nil,
        givenIsPressed: Bool? = nil
    ) {
        XCTAssertEqual(stub.getCurrentColorsUseCaseMock.executeWithColorsAndIsPressedAndDisplayedTextTypeCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getCurrentColorsUseCase")

        if numberOfCalls > 0, let givenColors, let givenIsPressed {
            let getCurrentColorsUseCaseArgs = stub.getCurrentColorsUseCaseMock.executeWithColorsAndIsPressedAndDisplayedTextTypeReceivedArguments
            XCTAssertEqual(try XCTUnwrap(getCurrentColorsUseCaseArgs?.colors),
                           givenColors,
                           "Wrong colors parameter on execute on getCurrentColorsUseCase")
            XCTAssertEqual(getCurrentColorsUseCaseArgs?.isPressed,
                           givenIsPressed,
                           "Wrong isPressed parameter on execute on getCurrentColorsUseCase")
        }
    }

    private func testGetIsIconOnlyUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenIconImage: UIImage? = nil
    ) {
        XCTAssertEqual(stub.getIsIconOnlyUseCaseMock.executeWithIconImageAndTextAndAttributedTextCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getIsIconOnlyUseCase")

        if numberOfCalls > 0 {
            let getIsIconOnlyUseCaseArgs = stub.getIsIconOnlyUseCaseMock.executeWithIconImageAndTextAndAttributedTextReceivedArguments
            XCTAssertEqual(getIsIconOnlyUseCaseArgs?.iconImage?.leftValue,
                           givenIconImage,
                           "Wrong iconImage parameter on execute on getIsIconOnlyUseCase")
            XCTAssertEqual(getIsIconOnlyUseCaseArgs?.text,
                           stub.displayedTextViewModelMock.text,
                           "Wrong text parameter on execute on getIsIconOnlyUseCase")
            XCTAssertEqual(getIsIconOnlyUseCaseArgs?.attributedText,
                           stub.displayedTextViewModelMock.attributedText,
                           "Wrong attributedText parameter on execute on getIsIconOnlyUseCase")
        }
    }

    private func testGetSizesUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenSize: ButtonSize? = nil,
        givenIsOnlyIcon: Bool? = nil
    ) {
        XCTAssertEqual(stub.getSizesUseCaseMock.executeWithSizeAndIsOnlyIconCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getSizesUseCase")

        if numberOfCalls > 0, let givenSize, let givenIsOnlyIcon {
            let getSizesUseCaseArgs = stub.getSizesUseCaseMock.executeWithSizeAndIsOnlyIconReceivedArguments
            XCTAssertEqual(getSizesUseCaseArgs?.size,
                           givenSize,
                           "Wrong size parameter on execute on getSizesUseCase")
            XCTAssertEqual(getSizesUseCaseArgs?.isOnlyIcon,
                           givenIsOnlyIcon,
                           "Wrong isOnlyIcon parameter on execute on getSizesUseCase")
        }
    }

    private func testGetSpacingsUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenTheme: ThemeGeneratedMock? = nil,
        givenIsOnlyIcon: Bool? = nil
    ) {
        XCTAssertEqual(stub.getSpacingsUseCaseMock.executeWithSpacingAndIsOnlyIconCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getSpacingsUseCase")

        if numberOfCalls > 0, let givenTheme, let givenIsOnlyIcon {
            let getSpacingsUseCaseArgs = stub.getSpacingsUseCaseMock.executeWithSpacingAndIsOnlyIconReceivedArguments
            XCTAssertEqual(getSpacingsUseCaseArgs?.isOnlyIcon,
                           givenIsOnlyIcon,
                           "Wrong isOnlyIcon parameter on execute on getSpacingsUseCase")
            XCTAssertIdentical(try XCTUnwrap(getSpacingsUseCaseArgs?.spacing as? LayoutSpacingGeneratedMock),
                               givenTheme.layout.spacing as? LayoutSpacingGeneratedMock,
                               "Wrong spacing parameter on execute on getSpacingsUseCase")
        }
    }

    private func testGetStateUseCaseMock(
        on stub: Stub,
        numberOfCalls: Int,
        givenTheme: ThemeGeneratedMock? = nil,
        givenIsEnabled: Bool? = nil
    ) {
        XCTAssertEqual(stub.getStateUseCaseMock.executeWithIsEnabledAndDimsCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getStateUseCase")

        if numberOfCalls > 0, let givenTheme, let givenIsEnabled {
            let getStateUseCaseArgs = stub.getStateUseCaseMock.executeWithIsEnabledAndDimsReceivedArguments
            XCTAssertEqual(getStateUseCaseArgs?.isEnabled,
                           givenIsEnabled,
                           "Wrong isEnabled parameter on execute on getStateUseCase")
            XCTAssertIdentical(try XCTUnwrap(getStateUseCaseArgs?.dims as? DimsGeneratedMock),
                               givenTheme.dims as? DimsGeneratedMock,
                               "Wrong dims parameter on execute on getStateUseCase")
        }
    }
}

// MARK: - Stub

private final class Stub {

    // MARK: - Properties

    let viewModel: ButtonViewModel

    // MARK: - Data Properties

    let iconImageMock = IconographyTests.shared.arrow
    let themeMock = ThemeGeneratedMock.mocked()

    let borderMock = ButtonBorder.mocked()
    let colorsMock = ButtonColors.mocked()
    let contentMock = ButtonContent.mocked()
    let currentColorsMock = ButtonCurrentColors.mocked()
    let isIconOnlyMock = false
    let sizesMock = ButtonSizes.mocked()
    let spacingsMock = ButtonSpacings.mocked()
    let stateMock = ButtonState.mocked()

    // MARK: - Dependencies Properties

    let displayedTextViewModelMock: DisplayedTextViewModelGeneratedMock
    let getBorderUseCaseMock: ButtonGetBorderUseCaseableGeneratedMock
    let getColorsUseCaseMock: ButtonGetColorsUseCaseableGeneratedMock
    let getContentUseCaseMock: ButtonGetContentUseCaseableGeneratedMock
    let getCurrentColorsUseCaseMock: ButtonGetCurrentColorsUseCaseableGeneratedMock
    let getIsIconOnlyUseCaseMock: ButtonGetIsOnlyIconUseCaseableGeneratedMock
    let getSizesUseCaseMock: ButtonGetSizesUseCaseableGeneratedMock
    let getSpacingsUseCaseMock: ButtonGetSpacingsUseCaseableGeneratedMock
    let getStateUseCaseMock: ButtonGetStateUseCaseableGeneratedMock

    private let dependenciesMock: ButtonViewModelDependenciesProtocolGeneratedMock

    // MARK: - Publisher Properties

    let statePublisherMock: PublisherMock<Published<ButtonState?>.Publisher>
    let currentColorsPublisherMock: PublisherMock<Published<ButtonCurrentColors?>.Publisher>
    let sizesPublisherMock: PublisherMock<Published<ButtonSizes?>.Publisher>
    let borderPublisherMock: PublisherMock<Published<ButtonBorder?>.Publisher>
    let spacingsPublisherMock: PublisherMock<Published<ButtonSpacings?>.Publisher>
    let contentPublisherMock: PublisherMock<Published<ButtonContent?>.Publisher>
    let textFontTokenPublisherMock: PublisherMock<Published<(any TypographyFontToken)?>.Publisher>

    // MARK: - Initialization

    init(
        intent: ButtonIntent = .main,
        variant: ButtonVariant = .tinted,
        size: ButtonSize = .medium,
        shape: ButtonShape = .rounded,
        alignment: ButtonAlignment = .leadingIcon,
        isIconImage: Bool = false,
        text: String? = nil,
        attributedText: NSAttributedString? = nil,
        isEnabled: Bool = true
    ) {
        // **
        // Dependencies
        let displayedTextViewModelMock = DisplayedTextViewModelGeneratedMock()
        displayedTextViewModelMock.text = "Text"
        displayedTextViewModelMock.attributedText = .left(.init(string: "AText"))
        displayedTextViewModelMock.underlyingDisplayedTextType = .text
        self.displayedTextViewModelMock = displayedTextViewModelMock

        let getBorderUseCaseMock = ButtonGetBorderUseCaseableGeneratedMock()
        getBorderUseCaseMock.executeWithShapeAndBorderAndVariantReturnValue = self.borderMock
        self.getBorderUseCaseMock = getBorderUseCaseMock

        let getColorsUseCaseMock = ButtonGetColorsUseCaseableGeneratedMock()
        getColorsUseCaseMock.executeWithThemeAndIntentAndVariantReturnValue = self.colorsMock
        self.getColorsUseCaseMock = getColorsUseCaseMock

        let getContentUseCaseMock = ButtonGetContentUseCaseableGeneratedMock()
        getContentUseCaseMock.executeWithAlignmentAndIconImageAndTextAndAttributedTextReturnValue = self.contentMock
        self.getContentUseCaseMock = getContentUseCaseMock

        let getCurrentColorsUseCaseMock = ButtonGetCurrentColorsUseCaseableGeneratedMock()
        getCurrentColorsUseCaseMock.executeWithColorsAndIsPressedAndDisplayedTextTypeReturnValue = self.currentColorsMock
        self.getCurrentColorsUseCaseMock = getCurrentColorsUseCaseMock

        let getIsIconOnlyUseCaseMock = ButtonGetIsOnlyIconUseCaseableGeneratedMock()
        getIsIconOnlyUseCaseMock.executeWithIconImageAndTextAndAttributedTextReturnValue = self.isIconOnlyMock
        self.getIsIconOnlyUseCaseMock = getIsIconOnlyUseCaseMock

        let getSizesUseCaseMock = ButtonGetSizesUseCaseableGeneratedMock()
        getSizesUseCaseMock.executeWithSizeAndIsOnlyIconReturnValue = self.sizesMock
        self.getSizesUseCaseMock = getSizesUseCaseMock

        let getSpacingsUseCaseMock = ButtonGetSpacingsUseCaseableGeneratedMock()
        getSpacingsUseCaseMock.executeWithSpacingAndIsOnlyIconReturnValue = self.spacingsMock
        self.getSpacingsUseCaseMock = getSpacingsUseCaseMock

        let getStateUseCaseMock = ButtonGetStateUseCaseableGeneratedMock()
        getStateUseCaseMock.executeWithIsEnabledAndDimsReturnValue = self.stateMock
        self.getStateUseCaseMock = getStateUseCaseMock

        let dependenciesMock = ButtonViewModelDependenciesProtocolGeneratedMock()
        dependenciesMock.underlyingGetBorderUseCase = getBorderUseCaseMock
        dependenciesMock.underlyingGetColorsUseCase = getColorsUseCaseMock
        dependenciesMock.underlyingGetContentUseCase = getContentUseCaseMock
        dependenciesMock.underlyingGetCurrentColorsUseCase = getCurrentColorsUseCaseMock
        dependenciesMock.underlyingGetIsIconOnlyUseCase = getIsIconOnlyUseCaseMock
        dependenciesMock.underlyingGetSizesUseCase = getSizesUseCaseMock
        dependenciesMock.underlyingGetSpacingsUseCase = getSpacingsUseCaseMock
        dependenciesMock.underlyingGetStateUseCase = getStateUseCaseMock
        dependenciesMock.makeDisplayedTextViewModelWithTextAndAttributedTextReturnValue = displayedTextViewModelMock
        self.dependenciesMock = dependenciesMock
        // **

        // **
        // View Model
        let iconImageEither: ImageEither?
        if isIconImage {
            iconImageEither = .left(self.iconImageMock)
        } else {
            iconImageEither = nil
        }

        let attributedTextEither: AttributedStringEither?
        if let attributedText {
            attributedTextEither = .left(attributedText)
        } else {
            attributedTextEither = nil
        }

        let viewModel = ButtonViewModel(
            theme: self.themeMock,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape,
            alignment: alignment,
            iconImage: iconImageEither,
            text: text,
            attributedText: attributedTextEither,
            isEnabled: isEnabled,
            dependencies: dependenciesMock
        )
        self.viewModel = viewModel
        // **

        // **
        // Publishers
        self.statePublisherMock = .init(publisher: viewModel.$state)
        self.currentColorsPublisherMock = .init(publisher: viewModel.$currentColors)
        self.sizesPublisherMock = .init(publisher: viewModel.$sizes)
        self.borderPublisherMock = .init(publisher: viewModel.$border)
        self.spacingsPublisherMock = .init(publisher: viewModel.$spacings)
        self.contentPublisherMock = .init(publisher: viewModel.$content)
        self.textFontTokenPublisherMock = .init(publisher: viewModel.$textFontToken)
        //
    }

    // MARK: - Method

    func subscribePublishers(on subscriptions: inout Set<AnyCancellable>) {
        self.statePublisherMock.loadTesting(on: &subscriptions)
        self.currentColorsPublisherMock.loadTesting(on: &subscriptions)
        self.sizesPublisherMock.loadTesting(on: &subscriptions)
        self.borderPublisherMock.loadTesting(on: &subscriptions)
        self.spacingsPublisherMock.loadTesting(on: &subscriptions)
        self.contentPublisherMock.loadTesting(on: &subscriptions)
        self.textFontTokenPublisherMock.loadTesting(on: &subscriptions)
    }

    func resetMockedData() {
        // Clear UseCases Mock
        let useCases: [ResetGeneratedMock] = [
            self.getBorderUseCaseMock,
            self.getColorsUseCaseMock,
            self.getContentUseCaseMock,
            self.getCurrentColorsUseCaseMock,
            self.getIsIconOnlyUseCaseMock,
            self.getSizesUseCaseMock,
            self.getSpacingsUseCaseMock,
            self.getStateUseCaseMock
        ]
        useCases.forEach { $0.reset() }

        // Reset published sink counter
        self.statePublisherMock.reset()
        self.currentColorsPublisherMock.reset()
        self.sizesPublisherMock.reset()
        self.borderPublisherMock.reset()
        self.spacingsPublisherMock.reset()
        self.contentPublisherMock.reset()
        self.textFontTokenPublisherMock.reset()
    }
}
