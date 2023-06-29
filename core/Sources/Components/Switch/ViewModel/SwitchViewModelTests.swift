//
//  SwitchViewModelTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import SparkCore
@testable import Spark

final class SwitchViewModelTests: XCTestCase {

    // MARK: - Properties

    private let themeMock = ThemeGeneratedMock.mocked()

    private let colorsMock: SwitchColorablesGeneratedMock = {
        let mock = SwitchColorablesGeneratedMock()
        mock.underlyingToggleBackgroundColors = SwitchStatusColorablesGeneratedMock()
        mock.underlyingToggleDotBackgroundColor = ColorTokenGeneratedMock()
        mock.underlyingToggleDotForegroundColors = SwitchStatusColorablesGeneratedMock()
        mock.underlyingTextForegroundColor = ColorTokenGeneratedMock()
        return mock
    }()

    private let imageMock = IconographyTests.shared.switchOn
    private let variantMock = SwitchVariantableGeneratedMock()
    private let textMock = "My Text"
    private let attributedTextMock = NSAttributedString(string: "My Attributed Text")

    private var colorTokenMock: ColorTokenGeneratedMock = {
        let mock = ColorTokenGeneratedMock()
        mock.underlyingColor = .orange
        mock.underlyingUiColor = .green
        return mock
    }()

    private lazy var textContentMock: SwitchTextContentableGeneratedMock = {
        let mock = SwitchTextContentableGeneratedMock()
        mock.text = self.textMock
        return mock
    }()

    private var positionMock: SwitchPositionableGeneratedMock = {
        let mock = SwitchPositionableGeneratedMock()
        mock.underlyingIsToggleOnLeft = true
        mock.underlyingHorizontalSpacing = 10
        return mock
    }()

    private var userInteractionEnabledMock = true

    private lazy var toggleStateMock: SwitchToggleStateableGeneratedMock = {
        let mock = SwitchToggleStateableGeneratedMock()
        mock.underlyingOpacity = 0.5
        mock.underlyingInteractionEnabled = self.userInteractionEnabledMock
        return mock
    }()

    private lazy var getColorsUseCaseMock: SwitchGetColorsUseCaseableGeneratedMock = {
        let mock = SwitchGetColorsUseCaseableGeneratedMock()
        mock.executeWithIntentColorAndColorsAndDimsReturnValue = self.colorsMock
        return mock

    }()
    private lazy var getImageUseCaseMock: SwitchGetImageUseCaseableGeneratedMock = {
        let mock = SwitchGetImageUseCaseableGeneratedMock()
        mock.executeWithIsOnAndVariantReturnValue = .left(self.imageMock)
        return mock

    }()
    private lazy var getTextContentUseCaseMock: SwitchGetTextContentUseCaseableGeneratedMock = {
        let mock = SwitchGetTextContentUseCaseableGeneratedMock()
        mock.executeWithTextAndAttributedTextReturnValue = self.textContentMock
        return mock

    }()
    private lazy var getToggleColorUseCaseMock: SwitchGetToggleColorUseCaseableGeneratedMock = {
        let mock = SwitchGetToggleColorUseCaseableGeneratedMock()
        mock.executeWithIsOnAndStatusAndStateColorReturnValue = self.colorTokenMock
        return mock

    }()
    private lazy var getPositionUseCaseMock: SwitchGetPositionUseCaseableGeneratedMock = {
        let mock = SwitchGetPositionUseCaseableGeneratedMock()
        mock.executeWithAlignmentAndSpacingReturnValue = self.positionMock
        return mock

    }()
    private lazy var getToggleStateUseCaseMock: SwitchGetToggleStateUseCaseableGeneratedMock = {
        let mock = SwitchGetToggleStateUseCaseableGeneratedMock()
        mock.executeWithIsEnabledReturnValue = self.toggleStateMock
        return mock
    }()

    // MARK: - Init Tests

    func test_properties_on_init() throws {
        // GIVEN
        let isOnMock = true
        let alignmentMock: SwitchAlignment = .left
        let intentColorMock: SwitchIntentColor = .alert
        let isEnabledMock = true

        // WHEN
        let viewModel = self.classToTest(
            isOn: isOnMock,
            alignment: alignmentMock,
            intentColor: intentColorMock,
            isEnabled: isEnabledMock,
            variant: self.variantMock
        )

        // THEN
        XCTAssertEqual(viewModel.isOn,
                       isOnMock,
                       "Wrong isOn value")
        XCTAssertIdentical(viewModel.theme as? ThemeGeneratedMock,
                           self.themeMock,
                           "Wrong theme value")
        XCTAssertEqual(viewModel.alignment,
                       alignmentMock,
                       "Wrong alignment value")
        XCTAssertEqual(viewModel.intentColor,
                       intentColorMock,
                       "Wrong intentColor value")
        XCTAssertEqual(viewModel.isEnabled,
                       isEnabledMock,
                       "Wrong isEnabled value")
        XCTAssertIdentical(viewModel.variant as? SwitchVariantableGeneratedMock,
                           self.variantMock,
                           "Wrong variant value")
        XCTAssertEqual(viewModel.text,
                       self.textMock,
                       "Wrong variant value")
        XCTAssertEqual(viewModel.attributedText?.leftValue,
                       self.attributedTextMock,
                       "Wrong variant value")

        XCTAssertNil(viewModel.isOnChanged,
                     "Wrong isOnChanged value")

        // **
        // Published properties
        self.testToggleState(on: viewModel)
        self.testColors(on: viewModel)
        self.testPosition(on: viewModel)
        self.testTextContent(on: viewModel)
        self.testToggleDotImage(on: viewModel)
        self.testTextFont(on: viewModel, theme: self.themeMock)
        XCTAssertTrue(viewModel.showToggleLeftSpace == true,
                      "Wrong isToggleOnLeft value")
        // **

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            givenTheme: self.themeMock,
            givenIntentColor: intentColorMock
        )
        self.testGetImageUseCaseMock(
            givenIsOn: isOnMock,
            givenVariant: self.variantMock
        )
        self.testGetTextContentUseCaseMock(
            givenText: self.textMock,
            givenAttributedText: self.attributedTextMock
        )
        self.testGetToggleColorUseCaseMock(
            givenIsOn: isOnMock
        )
        self.testGetPositionUseCaseMock(
            givenTheme: self.themeMock,
            givenAlignment: alignmentMock
        )
        self.testGetToggleStateUseCaseMock(
            givenTheme: self.themeMock,
            givenIsEnabled: isEnabledMock
        )
        // **
    }

    // MARK: - Toggle Tests

    func test_toggle_when_isToggleInteractionEnabled_is_true_should_update_switch() {
        // GIVEN
        self.userInteractionEnabledMock = true

        let expectedIsOn = true

        let alignmentMock: SwitchAlignment = .right
        let intentColorMock: SwitchIntentColor = .secondary
        let isEnabledMock = false
        let variantMock: SwitchVariantableGeneratedMock? = nil

        let viewModel = self.classToTest(
            isOn: false,
            alignment: alignmentMock,
            intentColor: intentColorMock,
            isEnabled: isEnabledMock,
            variant: variantMock
        )

        // Reset all UseCase mock
        self.resetUseCasesMockAfterInitViewModel()

        // WHEN
        viewModel.toggle()

        // THEN
        XCTAssertEqual(viewModel.isOn,
                       expectedIsOn,
                       "Wrong isOn value")

        XCTAssertEqual(viewModel.isOnChanged,
                       expectedIsOn,
                     "Wrong isOnChanged value")

        // **
        // Published properties
        self.testToggleState(on: viewModel)
        self.testColors(on: viewModel)
        self.testPosition(on: viewModel)
        self.testToggleDotImage(on: viewModel)
        self.testTextFont(on: viewModel, theme: self.themeMock)
        XCTAssertTrue(viewModel.showToggleLeftSpace == true,
                      "Wrong isToggleOnLeft value")
        // **

        // **
        // Use Cases
        self.testGetImageUseCaseMock(
            givenIsOn: expectedIsOn,
            givenVariant: variantMock
        )
        self.testGetToggleColorUseCaseMock(
            givenIsOn: expectedIsOn
        )
        self.testGetToggleStateUseCaseMock(
            givenTheme: self.themeMock,
            givenIsEnabled: isEnabledMock
        )
        // **
    }

    func test_toggle_when_isToggleInteractionEnabled_is_false_should_do_nothing() {
        // GIVEN
        self.userInteractionEnabledMock = false

        let isOnMock = false
        let alignmentMock: SwitchAlignment = .right
        let intentColorMock: SwitchIntentColor = .secondary
        let isEnabledMock = false
        let variantMock: SwitchVariantableGeneratedMock? = nil

        let viewModel = self.classToTest(
            isOn: isOnMock,
            alignment: alignmentMock,
            intentColor: intentColorMock,
            isEnabled: isEnabledMock,
            variant: variantMock
        )

        // Reset all UseCase mock
        self.resetUseCasesMockAfterInitViewModel()

        // WHEN
        viewModel.toggle()

        // THEN
        XCTAssertEqual(viewModel.isOn,
                       isOnMock,
                       "Wrong isOn value")

        XCTAssertNil(viewModel.isOnChanged,
                     "Wrong isOnChanged value")

        // **
        // Use Cases
        self.testGetImageUseCaseMock(
            numberOfCalls: 0,
            givenIsOn: isOnMock,
            givenVariant: variantMock
        )
        self.testGetToggleColorUseCaseMock(
            numberOfCalls: 0,
            givenIsOn: isOnMock
        )
        self.testGetToggleStateUseCaseMock(
            numberOfCalls: 0,
            givenTheme: self.themeMock,
            givenIsEnabled: isEnabledMock
        )
        // **
    }

    // MARK: - Setter Tests

    func test_set_theme() {
        // GIVEN
        let newTheme = ThemeGeneratedMock.mocked()

        let isOnMock = false
        let alignmentMock: SwitchAlignment = .right
        let intentColorMock: SwitchIntentColor = .secondary
        let isEnabledMock = false
        let variantMock: SwitchVariantableGeneratedMock? = nil

        let viewModel = self.classToTest(
            isOn: isOnMock,
            alignment: alignmentMock,
            intentColor: intentColorMock,
            isEnabled: isEnabledMock,
            variant: variantMock
        )

        // Reset all UseCase mock
        self.resetUseCasesMockAfterInitViewModel()

        // WHEN
        viewModel.set(theme: newTheme)

        // THEN
        XCTAssertIdentical(viewModel.theme as? ThemeGeneratedMock,
                           newTheme,
                           "Wrong theme value")

        // **
        // Published properties
        self.testToggleState(on: viewModel)
        self.testColors(on: viewModel)
        self.testPosition(on: viewModel)
        self.testToggleDotImage(on: viewModel)
        self.testTextFont(on: viewModel, theme: newTheme)
        XCTAssertTrue(viewModel.showToggleLeftSpace == false,
                      "Wrong isToggleOnLeft value")
        // **

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            givenTheme: newTheme,
            givenIntentColor: intentColorMock
        )
        self.testGetImageUseCaseMock(
            givenIsOn: isOnMock,
            givenVariant: variantMock
        )
        self.testGetToggleColorUseCaseMock(
            givenIsOn: isOnMock
        )
        self.testGetPositionUseCaseMock(
            givenTheme: newTheme,
            givenAlignment: alignmentMock
        )
        self.testGetToggleStateUseCaseMock(
            givenTheme: newTheme,
            givenIsEnabled: isEnabledMock
        )
        // **
    }

    func test_set_alignment() {
        // GIVEN
        let newAlignmentMock: SwitchAlignment = .right

        let viewModel = self.classToTest(
            alignment: .left
        )

        // Reset all UseCase mock
        self.resetUseCasesMockAfterInitViewModel()

        // WHEN
        viewModel.set(alignment: newAlignmentMock)

        // THEN
        XCTAssertEqual(viewModel.alignment,
                       newAlignmentMock,
                       "Wrong alignment value")

        // Published properties
        self.testPosition(on: viewModel)

        // Use Cases
        self.testGetPositionUseCaseMock(
            givenTheme: self.themeMock,
            givenAlignment: newAlignmentMock
        )
    }

    func test_set_intentColor() {
        // GIVEN
        let newIntentColor: SwitchIntentColor = .primary

        let isOnMock = true

        let viewModel = self.classToTest(
            isOn: isOnMock,
            intentColor: .neutral
        )

        // Reset all UseCase mock
        self.resetUseCasesMockAfterInitViewModel()

        // WHEN
        viewModel.set(intentColor: newIntentColor)

        // THEN
        XCTAssertEqual(viewModel.intentColor,
                       newIntentColor,
                       "Wrong intentColor value")

        // Published properties
        self.testColors(on: viewModel)

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            givenTheme: self.themeMock,
            givenIntentColor: newIntentColor
        )
        self.testGetToggleColorUseCaseMock(
            givenIsOn: isOnMock
        )
        // **
    }

    func test_set_text() {// GIVEN
        let newText = "New Text"

        let viewModel = self.classToTest()

        // Reset all UseCase mock
        self.resetUseCasesMockAfterInitViewModel()

        // WHEN
        viewModel.set(text: newText)

        // THEN
        XCTAssertEqual(viewModel.text,
                       newText,
                       "Wrong text value")
        XCTAssertNil(viewModel.attributedText,
                     "Wrong attributedText value")

        // Published properties
        self.testTextContent(on: viewModel)

        // **
        // Use Cases
        self.testGetTextContentUseCaseMock(
            givenText: newText,
            givenAttributedText: nil
        )
        // **
    }

    func test_set_attributedText() {
        // GIVEN
        let newAttributedText = NSAttributedString(string: "New Text")

        let viewModel = self.classToTest()

        // Reset all UseCase mock
        self.resetUseCasesMockAfterInitViewModel()

        // WHEN
        viewModel.set(attributedText: .left(newAttributedText))

        // THEN
        XCTAssertEqual(viewModel.attributedText?.leftValue,
                       newAttributedText,
                       "Wrong attributedText value")
        XCTAssertNil(viewModel.text,
                     "Wrong text value")

        // Published properties
        self.testTextContent(on: viewModel)

        // **
        // Use Cases
        self.testGetTextContentUseCaseMock(
            givenText: nil,
            givenAttributedText: newAttributedText
        )
        // **
    }

    func test_set_isEnabled() {
        // GIVEN
        let newIsEnabledMock = false

        let intentColorMock: SwitchIntentColor = .neutral
        let isOnMock = true

        let viewModel = self.classToTest(
            isOn: isOnMock,
            intentColor: intentColorMock,
            isEnabled: true
        )

        // Reset all UseCase mock
        self.resetUseCasesMockAfterInitViewModel()

        // WHEN
        viewModel.set(isEnabled: newIsEnabledMock)

        // THEN
        XCTAssertEqual(viewModel.isEnabled,
                       newIsEnabledMock,
                       "Wrong isEnabled value")

        // **
        // Published properties
        self.testColors(on: viewModel)
        self.testToggleState(on: viewModel)
        // **

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            numberOfCalls: 0,
            givenTheme: self.themeMock,
            givenIntentColor: intentColorMock
        )
        self.testGetToggleColorUseCaseMock(
            givenIsOn: isOnMock
        )
        self.testGetToggleStateUseCaseMock(
            givenTheme: self.themeMock,
            givenIsEnabled: newIsEnabledMock
        )
        // **
    }

    func test_set_variant() {
        // GIVEN
        let newVariantMock = SwitchVariantableGeneratedMock()

        let isOnMock = true

        let viewModel = self.classToTest(
            isOn: isOnMock,
            variant: nil
        )

        // Reset all UseCase mock
        self.resetUseCasesMockAfterInitViewModel()

        // WHEN
        viewModel.set(variant: newVariantMock)

        // THEN
        XCTAssertIdentical(viewModel.variant as? SwitchVariantableGeneratedMock,
                           newVariantMock,
                           "Wrong variant value")

        // Published properties
        self.testToggleDotImage(on: viewModel)

        // Use Cases
        self.testGetImageUseCaseMock(
            givenIsOn: isOnMock,
            givenVariant: newVariantMock
        )
    }
}

// MARK: - Class to test

private extension SwitchViewModelTests {

    func classToTest(
        isOn: Bool = true,
        alignment: SwitchAlignment = .left,
        intentColor: SwitchIntentColor = .alert,
        isEnabled: Bool = true,
        variant: SwitchVariantable? = nil
    ) -> SwitchViewModel {
        return .init(
            theme: self.themeMock,
            isOn: isOn,
            alignment: alignment,
            intentColor: intentColor,
            isEnabled: isEnabled,
            variant: variant,
            text: self.textMock,
            attributedText: .init(left: self.attributedTextMock),
            getColorsUseCase: self.getColorsUseCaseMock,
            getImageUseCase: self.getImageUseCaseMock,
            getTextContentUseCase: self.getTextContentUseCaseMock,
            getToggleColorUseCase: self.getToggleColorUseCaseMock,
            getPositionUseCase: self.getPositionUseCaseMock,
            getToggleStateUseCase: self.getToggleStateUseCaseMock
        )
    }
}

// MARK: - Testing Data

private extension SwitchViewModelTests {

    func testPosition(on viewModel: SwitchViewModel) {
        XCTAssertEqual(viewModel.isToggleOnLeft,
                       self.positionMock.isToggleOnLeft,
                       "Wrong isToggleOnLeft value")
        XCTAssertEqual(viewModel.horizontalSpacing,
                       self.positionMock.horizontalSpacing,
                       "Wrong horizontalSpacing value")
    }

    func testColors(on viewModel: SwitchViewModel) {
        XCTAssertIdentical(viewModel.toggleBackgroundColorToken as? ColorTokenGeneratedMock,
                           self.colorTokenMock,
                           "Wrong toggleBackgroundColorToken value")
        XCTAssertIdentical(try XCTUnwrap(viewModel.toggleDotBackgroundColorToken as? ColorTokenGeneratedMock),
                           self.colorsMock.toggleDotBackgroundColor as? ColorTokenGeneratedMock,
                           "Wrong toggleDotBackgroundColorToken value")
        XCTAssertIdentical(viewModel.toggleDotForegroundColorToken as? ColorTokenGeneratedMock,
                           self.colorTokenMock,
                           "Wrong toggleDotForegroundColorToken value")
        XCTAssertIdentical(try XCTUnwrap(viewModel.textForegroundColorToken as? ColorTokenGeneratedMock),
                           self.colorsMock.textForegroundColor as? ColorTokenGeneratedMock,
                           "Wrong textForegroundColorToken value")
    }

    func testToggleState(on viewModel: SwitchViewModel) {
        XCTAssertEqual(viewModel.isToggleInteractionEnabled,
                       self.toggleStateMock.interactionEnabled,
                       "Wrong isToggleInteractionEnabled value")
        XCTAssertEqual(viewModel.toggleOpacity,
                       self.toggleStateMock.opacity,
                       "Wrong toggleOpacity value")
    }

    func testTextContent(on viewModel: SwitchViewModel) {
        XCTAssertIdentical(viewModel.textContent as? SwitchTextContentableGeneratedMock,
                           self.textContentMock,
                           "Wrong textContent value")
    }

    func testToggleDotImage(on viewModel: SwitchViewModel) {
        XCTAssertEqual(viewModel.toggleDotImage?.leftValue,
                       self.imageMock,
                       "Wrong toggleDotImage value")
    }

    func testTextFont(on viewModel: SwitchViewModel, theme: Theme) {
        XCTAssertIdentical(try XCTUnwrap(viewModel.textFontToken as? TypographyFontTokenGeneratedMock),
                           theme.typography.body1 as? TypographyFontTokenGeneratedMock,
                           "Wrong textFontToken value")
    }
}

// MARK: - Testing UseCase

private extension SwitchViewModelTests {

    func testGetColorsUseCaseMock(
        numberOfCalls: Int = 1,
        givenTheme: Theme,
        givenIntentColor: SwitchIntentColor
    ) {
        XCTAssertEqual(self.getColorsUseCaseMock.executeWithIntentColorAndColorsAndDimsCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getColorsUseCase")

        if numberOfCalls > 0 {
            let getColorsUseCaseArgs = self.getColorsUseCaseMock.executeWithIntentColorAndColorsAndDimsReceivedArguments
            XCTAssertEqual(getColorsUseCaseArgs?.intentColor,
                           givenIntentColor,
                           "Wrong intentColor parameter on execute on getColorsUseCase")
            XCTAssertIdentical(try XCTUnwrap(getColorsUseCaseArgs?.colors as? ColorsGeneratedMock),
                               givenTheme.colors as? ColorsGeneratedMock,
                               "Wrong colors parameter on execute on getColorsUseCase")
            XCTAssertIdentical(try XCTUnwrap(getColorsUseCaseArgs?.dims as? DimsGeneratedMock),
                               givenTheme.dims as? DimsGeneratedMock,
                               "Wrong dims parameter on execute on getColorsUseCase")
        }
    }

    func testGetImageUseCaseMock(
        numberOfCalls: Int = 1,
        givenIsOn: Bool,
        givenVariant: SwitchVariantableGeneratedMock?
    ) {
        XCTAssertEqual(self.getImageUseCaseMock.executeWithIsOnAndVariantCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getImageUseCase")

        if numberOfCalls > 0 {
            let getImageUseCaseArgs = self.getImageUseCaseMock.executeWithIsOnAndVariantReceivedArguments
            XCTAssertEqual(getImageUseCaseArgs?.isOn,
                           givenIsOn,
                           "Wrong isOn parameter on execute on getImageUseCase")

            if let givenVariant {
                XCTAssertIdentical(getImageUseCaseArgs?.variant as? SwitchVariantableGeneratedMock,
                                   givenVariant,
                                   "Wrong variant parameter on execute on getImageUseCase")
            } else {
                XCTAssertNil(getImageUseCaseArgs?.variant,
                             "variant parameter should be nil on execute on getImageUseCase")
            }
        }
    }

    func testGetTextContentUseCaseMock(
        numberOfCalls: Int = 1,
        givenText: String?,
        givenAttributedText: NSAttributedString?
    ) {
        XCTAssertEqual(self.getTextContentUseCaseMock.executeWithTextAndAttributedTextCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getTextContentUseCase")

        if numberOfCalls > 0 {
            let getTextContentUseCaseArgs = self.getTextContentUseCaseMock.executeWithTextAndAttributedTextReceivedArguments
            if let givenText {
                XCTAssertEqual(getTextContentUseCaseArgs?.text,
                               givenText,
                               "Wrong text parameter on execute on getTextContentUseCase")
            } else {
                XCTAssertNil(getTextContentUseCaseArgs?.text,
                             "text parameter should be nil on execute on getTextContentUseCase")
            }

            if let givenAttributedText {
                XCTAssertEqual(getTextContentUseCaseArgs?.attributedText?.leftValue,
                               givenAttributedText,
                               "Wrong attributedText parameter on execute on getTextContentUseCase")
            } else {
                XCTAssertNil(getTextContentUseCaseArgs?.attributedText,
                             "attributedText parameter should be nil on execute on getTextContentUseCase")
            }
        }
    }

    func testGetToggleColorUseCaseMock(
        numberOfCalls: Int = 2,
        givenIsOn: Bool
    ) {
        let givenStatusAndStateColors =  [
            self.colorsMock.toggleBackgroundColors,
            self.colorsMock.toggleDotForegroundColors
        ]

        XCTAssertEqual(self.getToggleColorUseCaseMock.executeWithIsOnAndStatusAndStateColorCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getToggleColorUseCase")

        if numberOfCalls > 0 {
            let getToggleColorUseCaseInvocations = self.getToggleColorUseCaseMock.executeWithIsOnAndStatusAndStateColorReceivedInvocations

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
                XCTAssertIdentical(try XCTUnwrap(args.statusAndStateColor as? SwitchStatusColorablesGeneratedMock),
                                   givenStatusAndStateColors[givenStatusAndStateColorsIndex] as? SwitchStatusColorablesGeneratedMock,
                                   "Wrong statusAndStateColor parameter on \(index) execute on getToggleColorUseCase")
            }
        }
    }

    func testGetPositionUseCaseMock(
        numberOfCalls: Int = 1,
        givenTheme: Theme,
        givenAlignment: SwitchAlignment
    ) {
        XCTAssertEqual(self.getPositionUseCaseMock.executeWithAlignmentAndSpacingCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getPositionUseCase")

        if numberOfCalls > 0 {
            let getPositionUseCaseArgs = self.getPositionUseCaseMock.executeWithAlignmentAndSpacingReceivedArguments
            XCTAssertEqual(getPositionUseCaseArgs?.alignment,
                           givenAlignment,
                           "Wrong alignment parameter on execute on getPositionUseCase")
            XCTAssertIdentical(try XCTUnwrap(getPositionUseCaseArgs?.spacing as? LayoutSpacingGeneratedMock),
                               givenTheme.layout.spacing as? LayoutSpacingGeneratedMock,
                               "Wrong spacing parameter on execute on getPositionUseCase")
        }
    }

    func testGetToggleStateUseCaseMock(
        numberOfCalls: Int = 1,
        givenTheme: Theme,
        givenIsEnabled: Bool
    ) {
        XCTAssertEqual(self.getToggleStateUseCaseMock.executeWithIsEnabledCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getToggleStateUseCase")

        if numberOfCalls > 0 {
            XCTAssertEqual(self.getToggleStateUseCaseMock.executeWithIsEnabledReceivedIsEnabled,
                           givenIsEnabled,
                           "Wrong isEnabled parameter on execute on getToggleStateUseCase")
        }
    }

    func resetUseCasesMockAfterInitViewModel() {
        // Clear UseCases Mock
        self.getColorsUseCaseMock.executeWithIntentColorAndColorsAndDimsCallsCount = 0
        self.getColorsUseCaseMock.executeWithIntentColorAndColorsAndDimsReceivedArguments = nil
        self.getColorsUseCaseMock.executeWithIntentColorAndColorsAndDimsReceivedInvocations = []

        self.getImageUseCaseMock.executeWithIsOnAndVariantCallsCount = 0
        self.getImageUseCaseMock.executeWithIsOnAndVariantReceivedArguments = nil
        self.getImageUseCaseMock.executeWithIsOnAndVariantReceivedInvocations = []

        self.getTextContentUseCaseMock.executeWithTextAndAttributedTextCallsCount = 0
        self.getTextContentUseCaseMock.executeWithTextAndAttributedTextReceivedArguments = nil
        self.getTextContentUseCaseMock.executeWithTextAndAttributedTextReceivedInvocations = []

        self.getToggleColorUseCaseMock.executeWithIsOnAndStatusAndStateColorCallsCount = 0
        self.getToggleColorUseCaseMock.executeWithIsOnAndStatusAndStateColorReceivedArguments = nil
        self.getToggleColorUseCaseMock.executeWithIsOnAndStatusAndStateColorReceivedInvocations = []

        self.getPositionUseCaseMock.executeWithAlignmentAndSpacingCallsCount = 0
        self.getPositionUseCaseMock.executeWithAlignmentAndSpacingReceivedArguments = nil
        self.getPositionUseCaseMock.executeWithAlignmentAndSpacingReceivedInvocations = []

        self.getToggleStateUseCaseMock.executeWithIsEnabledCallsCount = 0
        self.getToggleStateUseCaseMock.executeWithIsEnabledReceivedIsEnabled = nil
        self.getToggleStateUseCaseMock.executeWithIsEnabledReceivedInvocations = []
    }
}
