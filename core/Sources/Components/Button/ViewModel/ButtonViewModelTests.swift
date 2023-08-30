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

    private let iconImageMock = IconographyTests.shared.arrow

    private let themeMock = ThemeGeneratedMock.mocked()

    private let borderMock = ButtonBorder.mocked()

    private let colorsMock = ButtonColors.mocked()

    private let contentMock = ButtonContent.mocked()
    private let currentColorsMock = ButtonCurrentColors.mocked()
    private let isIconOnlyMock = false
    private let sizesMock = ButtonSizes.mocked()
    private let spacingsMock = ButtonSpacings.mocked()
    private let stateMock = ButtonState.mocked()

    private let displayedTextViewModelMock: DisplayedTextViewModelGeneratedMock = {
        let mock = DisplayedTextViewModelGeneratedMock()
        mock.text = "Text"
        mock.attributedText = .left(.init(string: "AText"))
        mock.underlyingDisplayedTextType = .text
        return mock
    }()

    private lazy var getBorderUseCaseMock: ButtonGetBorderUseCaseableGeneratedMock = {
        let mock = ButtonGetBorderUseCaseableGeneratedMock()
        mock.executeWithShapeAndBorderAndVariantReturnValue = self.borderMock
        return mock
    }()
    private lazy var getColorsUseCaseMock: ButtonGetColorsUseCaseableGeneratedMock = {
        let mock = ButtonGetColorsUseCaseableGeneratedMock()
        mock.executeWithThemeAndIntentAndVariantReturnValue = self.colorsMock
        return mock
    }()
    private lazy var getContentUseCaseMock: ButtonGetContentUseCaseableGeneratedMock = {
        let mock = ButtonGetContentUseCaseableGeneratedMock()
        mock.executeWithAlignmentAndIconImageAndTextAndAttributedTextReturnValue = self.contentMock
        return mock
    }()
    private lazy var getCurrentColorsUseCaseMock: ButtonGetCurrentColorsUseCaseableGeneratedMock = {
        let mock = ButtonGetCurrentColorsUseCaseableGeneratedMock()
        mock.executeWithColorsAndIsPressedAndDisplayedTextTypeReturnValue = self.currentColorsMock
        return mock
    }()
    private lazy var getIsIconOnlyUseCaseMock: ButtonGetIsOnlyIconUseCaseableGeneratedMock = {
        let mock = ButtonGetIsOnlyIconUseCaseableGeneratedMock()
        mock.executeWithIconImageAndTextAndAttributedTextReturnValue = self.isIconOnlyMock
        return mock
    }()
    private lazy var getSizesUseCaseMock: ButtonGetSizesUseCaseableGeneratedMock = {
        let mock = ButtonGetSizesUseCaseableGeneratedMock()
        mock.executeWithSizeAndIsOnlyIconReturnValue = self.sizesMock
        return mock
    }()
    private lazy var getSpacingsUseCaseMock: ButtonGetSpacingsUseCaseableGeneratedMock = {
        let mock = ButtonGetSpacingsUseCaseableGeneratedMock()
        mock.executeWithSpacingAndIsOnlyIconReturnValue = self.spacingsMock
        return mock
    }()
    private lazy var getStateUseCaseMock: ButtonGetStateUseCaseableGeneratedMock = {
        let mock = ButtonGetStateUseCaseableGeneratedMock()
        mock.executeWithIsEnabledAndDimsReturnValue = self.stateMock
        return mock
    }()

    private lazy var dependenciesMock: ButtonViewModelDependenciesProtocolGeneratedMock = {
        let mock = ButtonViewModelDependenciesProtocolGeneratedMock()
        mock.underlyingGetBorderUseCase = self.getBorderUseCaseMock
        mock.underlyingGetColorsUseCase = self.getColorsUseCaseMock
        mock.underlyingGetContentUseCase = self.getContentUseCaseMock
        mock.underlyingGetCurrentColorsUseCase = self.getCurrentColorsUseCaseMock
        mock.underlyingGetIsIconOnlyUseCase = self.getIsIconOnlyUseCaseMock
        mock.underlyingGetSizesUseCase = self.getSizesUseCaseMock
        mock.underlyingGetSpacingsUseCase = self.getSpacingsUseCaseMock
        mock.underlyingGetStateUseCase = self.getStateUseCaseMock
        mock.makeDisplayedTextViewModelWithTextAndAttributedTextReturnValue = self.displayedTextViewModelMock
        return mock
    }()

    private var statePublishedSinkCount = 0
    private var currentColorsPublishedSinkCount = 0
    private var sizesPublishedSinkCount = 0
    private var borderPublishedSinkCount = 0
    private var spacingsPublishedSinkCount = 0
    private var contentPublishedSinkCount = 0
    private var textFontTokenPublishedSinkCount = 0

    private var subscriptions = Set<AnyCancellable>()

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

        // WHEN
        let viewModel = self.classToTest(
            intent: intentMock,
            variant: variantMock,
            size: sizeMock,
            shape: shapeMock,
            alignment: alignmentMock,
            iconImage: self.iconImageMock,
            text: textMock,
            attributedText: attributedTextMock,
            isEnabled: isEnabledMock
        )

        self.subscribeAllPublishedValues(on: viewModel)

        // THEN
        XCTAssertIdentical(viewModel.theme as? ThemeGeneratedMock,
                           self.themeMock,
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
                       self.iconImageMock,
                       "Wrong images value")
        XCTAssertEqual(viewModel.isEnabled,
                       isEnabledMock,
                       "Wrong isEnabled value")
        // **
        // Published count
        XCTAssertEqual(self.statePublishedSinkCount,
                       1,
                       "Wrong statePublishedSinkCount value")
        XCTAssertEqual(self.currentColorsPublishedSinkCount,
                       1,
                       "Wrong currentColorsPublishedSinkCount value")
        XCTAssertEqual(self.sizesPublishedSinkCount,
                       1,
                       "Wrong sizesPublishedSinkCount value")
        XCTAssertEqual(self.borderPublishedSinkCount,
                       1,
                       "Wrong borderPublishedSinkCount value")
        XCTAssertEqual(self.spacingsPublishedSinkCount,
                       1,
                       "Wrong spacingsPublishedSinkCount value")
        XCTAssertEqual(self.contentPublishedSinkCount,
                       1,
                       "Wrong contentPublishedSinkCount value")
        XCTAssertEqual(self.textFontTokenPublishedSinkCount,
                       1,
                       "Wrong textFontTokenPublishedSinkCount value")
        // **

        // **
        // Use Cases
        self.testGetBorderUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetColorsUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetContentUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetCurrentColorsUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetIsIconOnlyUseCaseMock(
            numberOfCalls: 1,
            givenIconImage: self.iconImageMock
        )
        self.testGetSizesUseCaseMock(
            numberOfCalls: 1,
            givenSize: sizeMock,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetStateUseCaseMock(
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

        // WHEN
        let viewModel = self.classToTest(
            intent: intentMock,
            variant: variantMock,
            size: sizeMock,
            shape: shapeMock,
            alignment: alignmentMock,
            iconImage: self.iconImageMock,
            text: textMock,
            attributedText: attributedTextMock,
            isEnabled: isEnabledMock
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load()

        // THEN
        // **
        // Published properties
        self.testState(on: viewModel)
        self.testCurrentColors(on: viewModel)
        self.testSizes(on: viewModel)
        self.testBorder(on: viewModel)
        self.testSpacings(on: viewModel)
        self.testContent(on: viewModel)
        self.testTextFontToken(on: viewModel, theme: self.themeMock)

        XCTAssertEqual(self.statePublishedSinkCount,
                       2,
                       "Wrong statePublishedSinkCount value")
        XCTAssertEqual(self.currentColorsPublishedSinkCount,
                       2,
                       "Wrong currentColorsPublishedSinkCount value")
        XCTAssertEqual(self.sizesPublishedSinkCount,
                       2,
                       "Wrong sizesPublishedSinkCount value")
        XCTAssertEqual(self.borderPublishedSinkCount,
                       2,
                       "Wrong borderPublishedSinkCount value")
        XCTAssertEqual(self.spacingsPublishedSinkCount,
                       2,
                       "Wrong spacingsPublishedSinkCount value")
        XCTAssertEqual(self.contentPublishedSinkCount,
                       2,
                       "Wrong contentPublishedSinkCount value")
        XCTAssertEqual(self.textFontTokenPublishedSinkCount,
                       2,
                       "Wrong textFontTokenPublishedSinkCount value")
        // **

        // **
        // Use Cases
        self.testGetBorderUseCaseMock(
            givenShape: shapeMock,
            givenTheme: self.themeMock,
            givenVariant: variantMock
        )
        self.testGetColorsUseCaseMock(
            givenTheme: self.themeMock,
            givenIntent: intentMock,
            givenVariant: variantMock
        )
        self.testGetContentUseCaseMock(
            givenAlignment: alignmentMock,
            givenIconImage: self.iconImageMock
        )
        self.testGetCurrentColorsUseCaseMock(
            givenColors: self.colorsMock,
            givenIsPressed: false
        )
        self.testGetIsIconOnlyUseCaseMock(
            givenIconImage: self.iconImageMock
        )
        self.testGetSizesUseCaseMock(
            numberOfCalls: 2,
            givenSize: sizeMock,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            givenTheme: self.themeMock,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        self.testGetStateUseCaseMock(
            givenTheme: self.themeMock,
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
        let viewModel = self.classToTest()

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

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
        self.resetMockedData()

        // WHEN
        if isPressedAction {
            viewModel.pressedAction()
        } else {
            viewModel.unpressedAction()
        }

        // THEN
        // Published count
        XCTAssertEqual(self.currentColorsPublishedSinkCount,
                       !isAlreadyOnPressedState ? 1 : 0,
                       "Wrong currentColorsPublishedSinkCount value")

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetCurrentColorsUseCaseMock(
            numberOfCalls: !isAlreadyOnPressedState ? 1 : 0,
            givenColors: self.colorsMock,
            givenIsPressed: isPressedAction
        )
        // **
    }

    // MARK: - Setter Tests

    func test_set_theme_with_new_value() {
        // GIVEN
        let newThemeMock = themeMock

        let intentMock: ButtonIntent = .support
        let variantMock: ButtonVariant = .outlined
        let sizeMock: ButtonSize = .medium
        let shapeMock: ButtonShape = .rounded
        let alignmentMock: ButtonAlignment = .trailingIcon
        let textMock = "My Button"
        let attributedTextMock = NSAttributedString(string: "My AT Button")
        let isEnabledMock = false

        let viewModel = self.classToTest(
            intent: intentMock,
            variant: variantMock,
            size: sizeMock,
            shape: shapeMock,
            alignment: alignmentMock,
            iconImage: self.iconImageMock,
            text: textMock,
            attributedText: attributedTextMock,
            isEnabled: isEnabledMock
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        self.resetMockedData()

        // WHEN
        viewModel.set(theme: newThemeMock)

        // THEN
        // **
        // Published count
        XCTAssertEqual(self.statePublishedSinkCount,
                       1,
                       "Wrong statePublishedSinkCount value")
        XCTAssertEqual(self.currentColorsPublishedSinkCount,
                       1,
                       "Wrong currentColorsPublishedSinkCount value")
        XCTAssertEqual(self.sizesPublishedSinkCount,
                       1,
                       "Wrong sizesPublishedSinkCount value")
        XCTAssertEqual(self.borderPublishedSinkCount,
                       1,
                       "Wrong borderPublishedSinkCount value")
        XCTAssertEqual(self.spacingsPublishedSinkCount,
                       1,
                       "Wrong spacingsPublishedSinkCount value")
        XCTAssertEqual(self.textFontTokenPublishedSinkCount,
                       1,
                       "Wrong textFontTokenPublishedSinkCount value")
        // **

        // **
        // Use Cases
        self.testGetBorderUseCaseMock(
            givenShape: shapeMock,
            givenTheme: newThemeMock,
            givenVariant: variantMock
        )
        self.testGetColorsUseCaseMock(
            givenTheme: newThemeMock,
            givenIntent: intentMock,
            givenVariant: variantMock
        )
        self.testGetCurrentColorsUseCaseMock(
            givenColors: self.colorsMock,
            givenIsPressed: false
        )
        self.testGetSizesUseCaseMock(
            givenSize: sizeMock,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            givenTheme: newThemeMock,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        self.testGetStateUseCaseMock(
            givenTheme: newThemeMock,
            givenIsEnabled: isEnabledMock
        )
        // **
    }

    func test_set_intent_with_new_value() {
        self.testSetIntent(
            givenValue: .danger,
            givenNewValue: .main
        )
    }
    
    func test_set_intent_without_new_value() {
        let valueMock: ButtonIntent = .main
        self.testSetIntent(
            givenValue: valueMock,
            givenNewValue: valueMock
        )
    }

    private func testSetIntent(
        givenValue: ButtonIntent,
        givenNewValue: ButtonIntent
    ) {
        // GIVEN
        let isNewValue = givenValue != givenNewValue

        let variantMock: ButtonVariant = .outlined

        let viewModel = self.classToTest(
            intent: givenValue,
            variant: variantMock
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        self.resetMockedData()

        // WHEN
        viewModel.set(intent: givenNewValue)

        // THEN

        // Published count
        XCTAssertEqual(self.currentColorsPublishedSinkCount,
                       isNewValue ? 1 : 0,
                       "Wrong currentColorsPublishedSinkCount value")

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenTheme: self.themeMock,
            givenIntent: givenNewValue,
            givenVariant: variantMock
        )
        self.testGetCurrentColorsUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenColors: self.colorsMock,
            givenIsPressed: false
        )
        // **
    }

    func test_set_variant_with_new_value() {
        self.testSetVariant(
            givenValue: .contrast,
            givenNewValue: .outlined
        )
    }

    func test_set_variant_without_new_value() {
        let valueMock: ButtonVariant = .filled
        self.testSetVariant(
            givenValue: valueMock,
            givenNewValue: valueMock
        )
    }

    private func testSetVariant(
        givenValue: ButtonVariant,
        givenNewValue: ButtonVariant
    ) {
        // GIVEN
        let isNewValue = givenValue != givenNewValue

        let intentMock: ButtonIntent = .success
        let shapeMock: ButtonShape = .square

        let viewModel = self.classToTest(
            intent: intentMock,
            variant: givenValue,
            shape: shapeMock
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        self.resetMockedData()

        // WHEN
        viewModel.set(variant: givenNewValue)

        // THEN
        // **
        // Published count
        XCTAssertEqual(self.currentColorsPublishedSinkCount,
                       isNewValue ? 1 : 0,
                       "Wrong currentColorsPublishedSinkCount value")
        XCTAssertEqual(self.borderPublishedSinkCount,
                       isNewValue ? 1 : 0,
                       "Wrong borderPublishedSinkCount value")
        // **

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenTheme: self.themeMock,
            givenIntent: intentMock,
            givenVariant: givenNewValue
        )
        self.testGetCurrentColorsUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenColors: self.colorsMock,
            givenIsPressed: false
        )
        self.testGetBorderUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenShape: shapeMock,
            givenTheme: self.themeMock,
            givenVariant: givenNewValue
        )
        // **
    }

    func test_set_size_with_new_value() {
        self.testSetSize(
            givenValue: .large,
            givenNewValue: .small
        )
    }

    func test_set_size_without_new_value() {
        let mockValue: ButtonSize = .medium
        self.testSetSize(
            givenValue: mockValue,
            givenNewValue: mockValue
        )
    }

    private func testSetSize(
        givenValue: ButtonSize,
        givenNewValue: ButtonSize
    ) {
        // GIVEN
        let isNewValue = givenValue != givenNewValue

        let viewModel = self.classToTest(
            size: givenValue
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        self.resetMockedData()

        // WHEN
        viewModel.set(size: givenNewValue)

        // THEN

        // Published count
        XCTAssertEqual(self.sizesPublishedSinkCount,
                       isNewValue ? 1 : 0,
                       "Wrong sizesPublishedSinkCount value")

        // **
        // Use Cases
        self.testGetSizesUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenSize: givenNewValue,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        // **
    }

    func test_set_shape_with_new_value() {
        self.testSetShape(
            givenValue: .pill,
            givenNewValue: .rounded
        )
    }

    func test_set_shape_without_new_value() {
        let valueMock: ButtonShape = .pill
        self.testSetShape(
            givenValue: valueMock,
            givenNewValue: valueMock
        )
    }

    private func testSetShape(
        givenValue: ButtonShape,
        givenNewValue: ButtonShape
    ) {
        // GIVEN
        let isNewValue = givenValue != givenNewValue

        let variantMock: ButtonVariant = .tinted

        let viewModel = self.classToTest(
            variant: variantMock,
            shape: givenValue
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        self.resetMockedData()

        // WHEN
        viewModel.set(shape: givenNewValue)

        // THEN

        // Published count
        XCTAssertEqual(self.borderPublishedSinkCount,
                       isNewValue ? 1 : 0,
                       "Wrong borderPublishedSinkCount value")

        // **
        // Use Cases
        self.testGetBorderUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenShape: givenNewValue,
            givenTheme: self.themeMock,
            givenVariant: variantMock
        )
        // **
    }

    func test_set_alignment_with_new_value() {
        self.testSetAlignment(
            givenValue: .leadingIcon,
            givenNewValue: .trailingIcon
        )
    }
    
    func test_set_alignment_without_new_value() {
        let valueMock: ButtonAlignment = .leadingIcon
        self.testSetAlignment(
            givenValue: valueMock,
            givenNewValue: valueMock
        )
    }

    private func testSetAlignment(
        givenValue: ButtonAlignment,
        givenNewValue: ButtonAlignment
    ) {
        // GIVEN
        let isNewValue = givenValue != givenNewValue

        let sizeMock: ButtonSize = .medium

        let viewModel = self.classToTest(
            size: sizeMock,
            alignment: givenValue
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        self.resetMockedData()

        // WHEN
        viewModel.set(alignment: givenNewValue)

        // THEN
        // Published count
        XCTAssertEqual(self.contentPublishedSinkCount,
                       isNewValue ? 1 : 0,
                       "Wrong contentPublishedSinkCount value")

        // **
        // Use Cases
        self.testGetContentUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenAlignment: givenNewValue
        )
        // **
    }

    func test_set_text_when_displayedTextViewModel_textChanged_return_true_and_new_value_is_NOT_nil() {
        self.testSetText(
            givenNewValueIsNil: false,
            givenTextChanged: true
        )
    }

    func test_set_text_when_displayedTextViewModel_textChanged_return_true_and_new_value_is_nil() {
        self.testSetText(
            givenNewValueIsNil: true,
            givenTextChanged: true
        )
    }

    func test_set_text_when_displayedTextViewModel_textChanged_return_false() {
        self.testSetText(
            givenTextChanged: false
        )
    }

    private func testSetText(
        givenNewValueIsNil: Bool = true,
        givenTextChanged: Bool
    ) {
        // GIVEN
        let givenNewValue: String? = givenNewValueIsNil ? nil : "My New Text"

        let sizeMock: ButtonSize = .medium
        let alignmentMock: ButtonAlignment = .trailingIcon

        let viewModel = self.classToTest(
            size: sizeMock,
            alignment: alignmentMock,
            text: "Text"
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        self.resetMockedData()

        // WHEN
        self.displayedTextViewModelMock.textChangedWithTextReturnValue = givenTextChanged
        viewModel.set(text: givenNewValue)

        // THEN
        // **
        // Published count
        XCTAssertEqual(self.contentPublishedSinkCount,
                       givenTextChanged ? 1 : 0,
                       "Wrong contentPublishedSinkCount value")
        XCTAssertEqual(self.sizesPublishedSinkCount,
                       givenTextChanged ? 1 : 0,
                       "Wrong sizesPublishedSinkCount value")
        XCTAssertEqual(self.spacingsPublishedSinkCount,
                       givenTextChanged ? 1 : 0,
                       "Wrong spacingsPublishedSinkCount value")
        XCTAssertEqual(self.currentColorsPublishedSinkCount,
                       givenTextChanged && !givenNewValueIsNil ? 1 : 0,
                       "Wrong currentColorsPublishedSinkCount value")
        XCTAssertEqual(self.textFontTokenPublishedSinkCount,
                       givenTextChanged && !givenNewValueIsNil ? 1 : 0,
                       "Wrong textFontTokenPublishedSinkCount value")
        // **

        // **
        // DisplayedText ViewModel
        XCTAssertEqual(self.displayedTextViewModelMock.textChangedWithTextCallsCount,
                       1,
                       "Wrong call number on textChanged on displayedTextViewModel")
        XCTAssertEqual(self.displayedTextViewModelMock.textChangedWithTextReceivedText,
                       givenNewValue,
                       "Wrong textChanged parameter on displayedTextViewModel")
        // **

        // **
        // Use Cases
        self.testGetIsIconOnlyUseCaseMock(
            numberOfCalls: givenTextChanged ? 2 : 0,
            givenIconImage: nil
        )
        self.testGetContentUseCaseMock(
            numberOfCalls: givenTextChanged ? 1 : 0,
            givenAlignment: alignmentMock,
            givenIconImage: nil
        )
        self.testGetSizesUseCaseMock(
            numberOfCalls: givenTextChanged ? 1 : 0,
            givenSize: sizeMock,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            numberOfCalls: givenTextChanged ? 1 : 0,
            givenTheme: self.themeMock,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        // **
    }

    func test_set_attributedText_when_displayedTextViewModel_attributedTextChanged_return_true() {
        self.testSetAttributedText(
            givenAttributedTextChanged: true
        )
    }

    func test_set_attributedText_when_displayedTextViewModel_attributedTextChanged_return_false() {
        self.testSetAttributedText(
            givenAttributedTextChanged: false
        )
    }

    private func testSetAttributedText(
        givenAttributedTextChanged: Bool
    ) {
        // GIVEN
        let givenNewValue = NSAttributedString(string: "My new AT Button")

        let sizeMock: ButtonSize = .medium
        let alignmentMock: ButtonAlignment = .trailingIcon

        let viewModel = self.classToTest(
            size: sizeMock,
            alignment: alignmentMock,
            attributedText: .init(string: "My AT Button")
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        self.resetMockedData()

        // WHEN
        self.displayedTextViewModelMock.attributedTextChangedWithAttributedTextReturnValue = givenAttributedTextChanged
        viewModel.set(attributedText: .left(givenNewValue))

        // THEN
        // **
        // Published count
        XCTAssertEqual(self.contentPublishedSinkCount,
                       givenAttributedTextChanged ? 1 : 0,
                       "Wrong contentPublishedSinkCount value")
        XCTAssertEqual(self.sizesPublishedSinkCount,
                       givenAttributedTextChanged ? 1 : 0,
                       "Wrong sizesPublishedSinkCount value")
        XCTAssertEqual(self.spacingsPublishedSinkCount,
                       givenAttributedTextChanged ? 1 : 0,
                       "Wrong spacingsPublishedSinkCount value")
        // **

        // **
        // DisplayedText ViewModel
        XCTAssertEqual(self.displayedTextViewModelMock.attributedTextChangedWithAttributedTextCallsCount,
                       1,
                       "Wrong call number on attributedText on displayedTextViewModel")
        XCTAssertEqual(self.displayedTextViewModelMock.attributedTextChangedWithAttributedTextReceivedAttributedText?.leftValue,
                       givenNewValue,
                       "Wrong attributedText parameter on displayedTextViewModel")
        // **

        // **
        // Use Cases
        self.testGetIsIconOnlyUseCaseMock(
            numberOfCalls: givenAttributedTextChanged ? 2 : 0,
            givenIconImage: nil
        )
        self.testGetContentUseCaseMock(
            numberOfCalls: givenAttributedTextChanged ? 1 : 0,
            givenAlignment: alignmentMock,
            givenIconImage: nil
        )
        self.testGetSizesUseCaseMock(
            numberOfCalls: givenAttributedTextChanged ? 1 : 0,
            givenSize: sizeMock,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            numberOfCalls: givenAttributedTextChanged ? 1 : 0,
            givenTheme: self.themeMock,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        // **
    }

    func test_set_iconImage_with_new_value() {
        // GIVEN
        self.testSetIconImage(
            givenValue: self.iconImageMock,
            givenNewValue: IconographyTests.shared.checkmark
        )
    }

    func test_set_iconImage_without_new_value() {
        self.testSetIconImage(
            givenValue: self.iconImageMock,
            givenNewValue: self.iconImageMock
        )
    }

    private func testSetIconImage(
        givenValue: UIImage,
        givenNewValue: UIImage
    ) {
        // GIVEN
        let isNewValue = givenValue != givenNewValue

        let sizeMock: ButtonSize = .medium
        let alignmentMock: ButtonAlignment = .trailingIcon

        let viewModel = self.classToTest(
            size: sizeMock,
            alignment: alignmentMock,
            iconImage: givenValue
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        self.resetMockedData()

        // WHEN
        viewModel.set(iconImage: .left(givenNewValue))

        // THEN
        XCTAssertEqual(viewModel.iconImage?.leftValue,
                       givenNewValue,
                       "Wrong iconImage value")

        // **
        // Published count
        XCTAssertEqual(self.contentPublishedSinkCount,
                       isNewValue ? 1 : 0,
                       "Wrong contentPublishedSinkCount value")
        XCTAssertEqual(self.sizesPublishedSinkCount,
                       isNewValue ? 1 : 0,
                       "Wrong sizesPublishedSinkCount value")
        XCTAssertEqual(self.spacingsPublishedSinkCount,
                       isNewValue ? 1 : 0,
                       "Wrong spacingsPublishedSinkCount value")
        // **

        // **
        // Use Cases
        self.testGetIsIconOnlyUseCaseMock(
            numberOfCalls: isNewValue ? 2 : 0,
            givenIconImage: givenNewValue
        )
        self.testGetContentUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenAlignment: alignmentMock,
            givenIconImage: givenNewValue
        )
        self.testGetSizesUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenSize: sizeMock,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        self.testGetSpacingsUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenTheme: self.themeMock,
            givenIsOnlyIcon: self.isIconOnlyMock
        )
        // **
    }

    func test_set_isEnabled_with_new_value() {
        self.testSetIsEnabled(
            givenValue: true,
            givenNewValue: false
        )
    }

    func test_set_isEnabled_without_new_value() {
        let valueMock = true
        self.testSetIsEnabled(
            givenValue: valueMock,
            givenNewValue: valueMock
        )
    }

    private func testSetIsEnabled(
        givenValue: Bool,
        givenNewValue: Bool
    ) {
        // GIVEN
        let isNewValue = givenValue != givenNewValue

        let viewModel = self.classToTest(
            isEnabled: givenValue
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        self.resetMockedData()

        // WHEN
        viewModel.set(isEnabled: givenNewValue)

        // THEN
        XCTAssertEqual(viewModel.isEnabled,
                       givenNewValue,
                       "Wrong isEnabled value")

        // Published count
        XCTAssertEqual(self.statePublishedSinkCount,
                       isNewValue ? 1 : 0,
                       "Wrong statePublishedSinkCount value")

        // **
        // Use Cases
        self.testGetStateUseCaseMock(
            numberOfCalls: isNewValue ? 1 : 0,
            givenTheme: self.themeMock,
            givenIsEnabled: givenNewValue
        )
        // **
    }
}

// MARK: - Class to test

private extension ButtonViewModelTests {

    private func classToTest(
        intent: ButtonIntent = .main,
        variant: ButtonVariant = .tinted,
        size: ButtonSize = .medium,
        shape: ButtonShape = .rounded,
        alignment: ButtonAlignment = .leadingIcon,
        iconImage: UIImage? = nil,
        text: String? = nil,
        attributedText: NSAttributedString? = nil,
        isEnabled: Bool = true
    ) -> ButtonViewModel {
        let iconImageEither: ImageEither?
        if let iconImage {
            iconImageEither = .left(iconImage)
        } else {
            iconImageEither = nil
        }

        let attributedTextEither: AttributedStringEither?
        if let attributedText {
            attributedTextEither = .left(attributedText)
        } else {
            attributedTextEither = nil
        }

        return .init(
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
            dependencies: self.dependenciesMock
        )
    }
}

// MARK: - Testing Published Data

private extension ButtonViewModelTests {

    private func subscribeAllPublishedValues(on viewModel: ButtonViewModel) {
        viewModel.$state.sink { _ in
            self.statePublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$currentColors.sink { _ in
            self.currentColorsPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$sizes.sink { _ in
            self.sizesPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$border.sink { _ in
            self.borderPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$spacings.sink { _ in
            self.spacingsPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$content.sink { _ in
            self.contentPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$textFontToken.sink { _ in
            self.textFontTokenPublishedSinkCount += 1
        }.store(in: &self.subscriptions)
    }

    private func testState(on viewModel: ButtonViewModel) {
        XCTAssertEqual(viewModel.state,
                           self.stateMock,
                           "Wrong state value")
    }

    private func testCurrentColors(on viewModel: ButtonViewModel) {
        XCTAssertEqual(viewModel.currentColors,
                           self.currentColorsMock,
                           "Wrong currentColors value")
    }

    private func testSizes(on viewModel: ButtonViewModel) {
        XCTAssertEqual(viewModel.sizes,
                           self.sizesMock,
                           "Wrong sizes value")
    }

    private func testBorder(on viewModel: ButtonViewModel) {
        XCTAssertEqual(viewModel.border,
                           self.borderMock,
                           "Wrong border value")
    }

    private func testSpacings(on viewModel: ButtonViewModel) {
        XCTAssertEqual(viewModel.spacings,
                           self.spacingsMock,
                           "Wrong spacings value")
    }

    private func testContent(on viewModel: ButtonViewModel) {
        XCTAssertEqual(viewModel.content,
                           self.contentMock,
                           "Wrong content value")
    }

    private func testTextFontToken(on viewModel: ButtonViewModel, theme: Theme) {
        XCTAssertIdentical(viewModel.textFontToken as? TypographyFontTokenGeneratedMock,
                           theme.typography.callout as? TypographyFontTokenGeneratedMock,
                           "Wrong textFontToken value")
    }
}

// MARK: - Testing Dependencies

private extension ButtonViewModelTests {

    private func testGetBorderUseCaseMock(
        numberOfCalls: Int = 1,
        givenShape: ButtonShape? = nil,
        givenTheme: ThemeGeneratedMock? = nil,
        givenVariant: ButtonVariant? = nil
    ) {
        XCTAssertEqual(self.getBorderUseCaseMock.executeWithShapeAndBorderAndVariantCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getBorderUseCase")

        if numberOfCalls > 0, let givenShape, let givenTheme, let givenVariant {
            let getBorderUseCaseArgs = self.getBorderUseCaseMock.executeWithShapeAndBorderAndVariantReceivedArguments
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
        numberOfCalls: Int = 1,
        givenTheme: ThemeGeneratedMock? = nil,
        givenIntent: ButtonIntent? = nil,
        givenVariant: ButtonVariant? = nil
    ) {
        XCTAssertEqual(self.getColorsUseCaseMock.executeWithThemeAndIntentAndVariantCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getColorsUseCase")

        if numberOfCalls > 0, let givenTheme, let givenIntent, let givenVariant {
            let getColorsUseCaseArgs = self.getColorsUseCaseMock.executeWithThemeAndIntentAndVariantReceivedArguments
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
        numberOfCalls: Int = 1,
        givenAlignment: ButtonAlignment? = nil,
        givenIconImage: UIImage? = nil
    ) {
        XCTAssertEqual(self.getContentUseCaseMock.executeWithAlignmentAndIconImageAndTextAndAttributedTextCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getContentUseCase")

        if numberOfCalls > 0, let givenAlignment {
            let getContentUseCaseArgs = self.getContentUseCaseMock.executeWithAlignmentAndIconImageAndTextAndAttributedTextReceivedArguments
            XCTAssertEqual(getContentUseCaseArgs?.alignment,
                           givenAlignment,
                           "Wrong alignment parameter on execute on getContentUseCase")
            XCTAssertEqual(getContentUseCaseArgs?.iconImage?.leftValue,
                           givenIconImage,
                           "Wrong iconImage parameter on execute on getContentUseCase")
            XCTAssertEqual(getContentUseCaseArgs?.text,
                           self.displayedTextViewModelMock.text,
                           "Wrong text parameter on execute on getContentUseCase")
            XCTAssertEqual(getContentUseCaseArgs?.attributedText,
                           self.displayedTextViewModelMock.attributedText,
                           "Wrong attributedText parameter on execute on getContentUseCase")
        }
    }

    private func testGetCurrentColorsUseCaseMock(
        numberOfCalls: Int = 1,
        givenColors: ButtonColors? = nil,
        givenIsPressed: Bool? = nil
    ) {
        XCTAssertEqual(self.getCurrentColorsUseCaseMock.executeWithColorsAndIsPressedAndDisplayedTextTypeCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getCurrentColorsUseCase")

        if numberOfCalls > 0, let givenColors, let givenIsPressed {
            let getCurrentColorsUseCaseArgs = self.getCurrentColorsUseCaseMock.executeWithColorsAndIsPressedAndDisplayedTextTypeReceivedArguments
            XCTAssertEqual(try XCTUnwrap(getCurrentColorsUseCaseArgs?.colors),
                               givenColors,
                               "Wrong colors parameter on execute on getCurrentColorsUseCase")
            XCTAssertEqual(getCurrentColorsUseCaseArgs?.isPressed,
                           givenIsPressed,
                           "Wrong isPressed parameter on execute on getCurrentColorsUseCase")
        }
    }

    private func testGetIsIconOnlyUseCaseMock(
        numberOfCalls: Int = 3,
        givenIconImage: UIImage? = nil
    ) {
        XCTAssertEqual(self.getIsIconOnlyUseCaseMock.executeWithIconImageAndTextAndAttributedTextCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getIsIconOnlyUseCase")

        if numberOfCalls > 0 {
            let getIsIconOnlyUseCaseArgs = self.getIsIconOnlyUseCaseMock.executeWithIconImageAndTextAndAttributedTextReceivedArguments
            XCTAssertEqual(getIsIconOnlyUseCaseArgs?.iconImage?.leftValue,
                           givenIconImage,
                           "Wrong iconImage parameter on execute on getIsIconOnlyUseCase")
            XCTAssertEqual(getIsIconOnlyUseCaseArgs?.text,
                           self.displayedTextViewModelMock.text,
                           "Wrong text parameter on execute on getIsIconOnlyUseCase")
            XCTAssertEqual(getIsIconOnlyUseCaseArgs?.attributedText,
                           self.displayedTextViewModelMock.attributedText,
                           "Wrong attributedText parameter on execute on getIsIconOnlyUseCase")
        }
    }

    private func testGetSizesUseCaseMock(
        numberOfCalls: Int = 1,
        givenSize: ButtonSize? = nil,
        givenIsOnlyIcon: Bool? = nil
    ) {
        XCTAssertEqual(self.getSizesUseCaseMock.executeWithSizeAndIsOnlyIconCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getSizesUseCase")

        if numberOfCalls > 0, let givenSize, let givenIsOnlyIcon {
            let getSizesUseCaseArgs = self.getSizesUseCaseMock.executeWithSizeAndIsOnlyIconReceivedArguments
            XCTAssertEqual(getSizesUseCaseArgs?.size,
                           givenSize,
                           "Wrong size parameter on execute on getSizesUseCase")
            XCTAssertEqual(getSizesUseCaseArgs?.isOnlyIcon,
                           givenIsOnlyIcon,
                           "Wrong isOnlyIcon parameter on execute on getSizesUseCase")
        }
    }

    private func testGetSpacingsUseCaseMock(
        numberOfCalls: Int = 1,
        givenTheme: ThemeGeneratedMock? = nil,
        givenIsOnlyIcon: Bool? = nil
    ) {
        XCTAssertEqual(self.getSpacingsUseCaseMock.executeWithSpacingAndIsOnlyIconCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getSpacingsUseCase")

        if numberOfCalls > 0, let givenTheme, let givenIsOnlyIcon {
            let getSpacingsUseCaseArgs = self.getSpacingsUseCaseMock.executeWithSpacingAndIsOnlyIconReceivedArguments
            XCTAssertEqual(getSpacingsUseCaseArgs?.isOnlyIcon,
                           givenIsOnlyIcon,
                           "Wrong isOnlyIcon parameter on execute on getSpacingsUseCase")
            XCTAssertIdentical(try XCTUnwrap(getSpacingsUseCaseArgs?.spacing as? LayoutSpacingGeneratedMock),
                               givenTheme.layout.spacing as? LayoutSpacingGeneratedMock,
                               "Wrong spacing parameter on execute on getSpacingsUseCase")
        }
    }

    private func testGetStateUseCaseMock(
        numberOfCalls: Int = 1,
        givenTheme: ThemeGeneratedMock? = nil,
        givenIsEnabled: Bool? = nil
    ) {
        XCTAssertEqual(self.getStateUseCaseMock.executeWithIsEnabledAndDimsCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getStateUseCase")

        if numberOfCalls > 0, let givenTheme, let givenIsEnabled {
            let getStateUseCaseArgs = self.getStateUseCaseMock.executeWithIsEnabledAndDimsReceivedArguments
            XCTAssertEqual(getStateUseCaseArgs?.isEnabled,
                           givenIsEnabled,
                           "Wrong isEnabled parameter on execute on getStateUseCase")
            XCTAssertIdentical(try XCTUnwrap(getStateUseCaseArgs?.dims as? DimsGeneratedMock),
                               givenTheme.dims as? DimsGeneratedMock,
                               "Wrong dims parameter on execute on getStateUseCase")
        }
    }

    private func resetMockedData() {
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
        self.statePublishedSinkCount = 0
        self.currentColorsPublishedSinkCount = 0
        self.sizesPublishedSinkCount = 0
        self.borderPublishedSinkCount = 0
        self.spacingsPublishedSinkCount = 0
        self.contentPublishedSinkCount = 0
        self.textFontTokenPublishedSinkCount = 0
    }
}
