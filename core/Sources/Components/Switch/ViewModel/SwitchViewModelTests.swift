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
import Combine

final class SwitchViewModelTests: XCTestCase {

    // MARK: - Properties

    private let themeMock = ThemeGeneratedMock.mocked()

    private let colorsMock = SwitchColors.mocked()

    private let imageMock = IconographyTests.shared.switchOn
    private let imagesMock = SwitchUIImages(on: UIImage(), off: UIImage())

    private var colorTokenMock: ColorTokenGeneratedMock = {
        let mock = ColorTokenGeneratedMock()
        mock.underlyingColor = .orange
        mock.underlyingUiColor = .green
        return mock
    }()

    private var positionMock = SwitchPosition.mocked()

    private var userInteractionEnabledMock = true

    private lazy var toggleStateMock: SwitchToggleState = {
        return .mocked(
            interactionEnabled: self.userInteractionEnabledMock
        )
    }()

    private lazy var getColorsUseCaseMock: SwitchGetColorsUseCaseableGeneratedMock = {
        let mock = SwitchGetColorsUseCaseableGeneratedMock()
        mock.executeWithIntentAndColorsAndDimsReturnValue = self.colorsMock
        return mock
    }()
    private lazy var getImageUseCaseMock: SwitchGetImageUseCaseableGeneratedMock = {
        let mock = SwitchGetImageUseCaseableGeneratedMock()
        mock.executeWithIsOnAndImagesReturnValue = .left(self.imageMock)
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
        mock.executeWithIsEnabledAndDimsReturnValue = self.toggleStateMock
        return mock
    }()

    private lazy var dependenciesMock: SwitchViewModelDependenciesProtocolGeneratedMock = {
        let mock = SwitchViewModelDependenciesProtocolGeneratedMock()
        mock.underlyingGetColorsUseCase = self.getColorsUseCaseMock
        mock.underlyingGetImageUseCase = self.getImageUseCaseMock
        mock.underlyingGetToggleColorUseCase = self.getToggleColorUseCaseMock
        mock.underlyingGetPositionUseCase = self.getPositionUseCaseMock
        mock.underlyingGetToggleStateUseCase = self.getToggleStateUseCaseMock
        return mock
    }()

    private var isOnChangedPublishedSinkCount = 0
    private var isToggleInteractionEnabledPublishedSinkCount = 0
    private var toggleOpacityPublishedSinkCount = 0
    private var toggleBackgroundColorTokenPublishedSinkCount = 0
    private var toggleDotBackgroundColorTokenPublishedSinkCount = 0
    private var toggleDotForegroundColorTokenPublishedSinkCount = 0
    private var textForegroundColorTokenPublishedSinkCount = 0
    private var isToggleOnLeftPublishedSinkCount = 0
    private var horizontalSpacingPublishedSinkCount = 0
    private var showToggleLeftSpacePublishedSinkCount = 0
    private var toggleDotImagePublishedSinkCount = 0
    private var textFontTokenPublishedSinkCount = 0

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init Tests

    func test_properties_on_init() throws {
        // GIVEN
        let isOnMock = true
        let alignmentMock: SwitchAlignment = .left
        let intentMock: SwitchIntent = .alert
        let isEnabledMock = true

        // WHEN
        let viewModel = self.classToTest(
            isOn: isOnMock,
            alignment: alignmentMock,
            intent: intentMock,
            isEnabled: isEnabledMock,
            images: self.imagesMock
        )

        self.subscribeAllPublishedValues(on: viewModel)

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
        XCTAssertEqual(viewModel.intent,
                       intentMock,
                       "Wrong intent value")
        XCTAssertEqual(viewModel.isEnabled,
                       isEnabledMock,
                       "Wrong isEnabled value")
        XCTAssertEqual(viewModel.images?.leftValue,
                       self.imagesMock,
                       "Wrong images value")

        XCTAssertNil(viewModel.isOnChanged,
                     "Wrong isOnChanged value")

        // Published count
        self.testAllPublishedSinkCount(
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
            expectedTextFontTokenPublishedSinkCount: 1
        )

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetImageUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetToggleColorUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetPositionUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetToggleStateUseCaseMock(
            numberOfCalls: 0
        )
        // **
    }

    // MARK: - Load Tests

    func test_published_properties_on_load() throws {
        // GIVEN
        let isOnMock = true
        let alignmentMock: SwitchAlignment = .left
        let intentMock: SwitchIntent = .alert
        let isEnabledMock = true

        // WHEN
        let viewModel = self.classToTest(
            isOn: isOnMock,
            alignment: alignmentMock,
            intent: intentMock,
            isEnabled: isEnabledMock,
            images: self.imagesMock
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load()

        // THEN
        // **
        // Published properties
        XCTAssertNil(viewModel.isOnChanged,
                     "Wrong isOnChanged value")
        self.testToggleState(on: viewModel)
        self.testColors(on: viewModel)
        self.testPosition(on: viewModel)
        self.testToggleDotImage(on: viewModel, shouldContainsImages: true)
        self.testTextFont(on: viewModel, theme: self.themeMock)
        XCTAssertTrue(viewModel.showToggleLeftSpace == true,
                      "Wrong isToggleOnLeft value")

        self.testAllPublishedSinkCount(
            expectedIsOnChangedPublishedSinkCount: 1,
            expectedIsToggleInteractionEnabledPublishedSinkCount: 2,
            expectedToggleOpacityPublishedSinkCount: 2,
            expectedToggleBackgroundColorTokenPublishedSinkCount: 2,
            expectedToggleDotBackgroundColorTokenPublishedSinkCount: 2,
            expectedToggleDotForegroundColorTokenPublishedSinkCount: 2,
            expectedTextForegroundColorTokenPublishedSinkCount: 2,
            expectedIsToggleOnLeftPublishedSinkCount: 2,
            expectedHorizontalSpacingPublishedSinkCount: 2,
            expectedShowToggleLeftSpacePublishedSinkCount: 2,
            expectedToggleDotImagePublishedSinkCount: 2,
            expectedTextFontTokenPublishedSinkCount: 2
        )
        // **

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            givenTheme: self.themeMock,
            givenIntent: intentMock
        )
        self.testGetImageUseCaseMock(
            givenIsOn: isOnMock,
            givenImages: self.imagesMock
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
        let intentMock: SwitchIntent = .support
        let isEnabledMock = false
        let imagesMock: SwitchUIImages? = nil

        let viewModel = self.classToTest(
            isOn: false,
            alignment: alignmentMock,
            intent: intentMock,
            isEnabled: isEnabledMock,
            images: imagesMock
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load()

        // Reset all UseCase mock
        self.resetDependenciesMockAfterInitViewModel()

        // WHEN
        viewModel.toggle()

        // THEN
        XCTAssertEqual(viewModel.isOn,
                       expectedIsOn,
                       "Wrong isOn value")

        // **
        // Published properties
        XCTAssertEqual(viewModel.isOnChanged,
                       expectedIsOn,
                       "Wrong isOnChanged value")
        XCTAssertTrue(viewModel.showToggleLeftSpace == true,
                      "Wrong isToggleOnLeft value")

        self.testAllPublishedSinkCount(
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
            numberOfCalls: 0
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
        let intentMock: SwitchIntent = .support
        let isEnabledMock = false
        let imagesMock: SwitchUIImages? = nil

        let viewModel = self.classToTest(
            isOn: isOnMock,
            alignment: alignmentMock,
            intent: intentMock,
            isEnabled: isEnabledMock,
            images: imagesMock
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load()

        // Reset all UseCase mock
        self.resetDependenciesMockAfterInitViewModel()

        // WHEN
        viewModel.toggle()

        // THEN
        XCTAssertEqual(viewModel.isOn,
                       isOnMock,
                       "Wrong isOn value")

        // Published count
        self.testAllPublishedSinkCount()

        // **
        // Use Cases
        self.testGetImageUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetToggleColorUseCaseMock(
            numberOfCalls: 0
        )
        self.testGetToggleStateUseCaseMock(
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
        let imagesMock: SwitchUIImages? = nil

        let viewModel = self.classToTest(
            isOn: isOnMock,
            alignment: alignmentMock,
            intent: intentMock,
            isEnabled: isEnabledMock,
            images: imagesMock
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        self.resetDependenciesMockAfterInitViewModel()

        // WHEN
        viewModel.set(theme: newTheme)

        // THEN
        XCTAssertIdentical(viewModel.theme as? ThemeGeneratedMock,
                           newTheme,
                           "Wrong theme value")

        // **
        // Published count
        self.testAllPublishedSinkCount(
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
            expectedTextFontTokenPublishedSinkCount: 1
        )
        // **

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            givenTheme: newTheme,
            givenIntent: intentMock
        )
        self.testGetImageUseCaseMock(
            numberOfCalls: 0
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

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        self.resetDependenciesMockAfterInitViewModel()

        // WHEN
        viewModel.set(alignment: newAlignmentMock)

        // THEN
        XCTAssertEqual(viewModel.alignment,
                       newAlignmentMock,
                       "Wrong alignment value")

        // Published properties
        self.testPosition(on: viewModel)

        // Published count
        self.testAllPublishedSinkCount(
            expectedIsToggleOnLeftPublishedSinkCount: 1,
            expectedHorizontalSpacingPublishedSinkCount: 1
        )

        // Use Cases
        self.testGetPositionUseCaseMock(
            givenTheme: self.themeMock,
            givenAlignment: newAlignmentMock
        )
    }

    func test_set_intent() {
        // GIVEN
        let newIntent: SwitchIntent = .main

        let isOnMock = true

        let viewModel = self.classToTest(
            isOn: isOnMock,
            intent: .neutral
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        self.resetDependenciesMockAfterInitViewModel()

        // WHEN
        viewModel.set(intent: newIntent)

        // THEN
        XCTAssertEqual(viewModel.intent,
                       newIntent,
                       "Wrong intent value")

        // Published count
        self.testAllPublishedSinkCount(
            expectedToggleBackgroundColorTokenPublishedSinkCount: 1,
            expectedToggleDotBackgroundColorTokenPublishedSinkCount: 1,
            expectedToggleDotForegroundColorTokenPublishedSinkCount: 1,
            expectedTextForegroundColorTokenPublishedSinkCount: 1
        )

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            givenTheme: self.themeMock,
            givenIntent: newIntent
        )
        self.testGetToggleColorUseCaseMock(
            givenIsOn: isOnMock
        )
        // **
    }

    func test_set_isEnabled() {
        // GIVEN
        let newIsEnabledMock = false

        let intentMock: SwitchIntent = .neutral
        let isOnMock = true

        let viewModel = self.classToTest(
            isOn: isOnMock,
            intent: intentMock,
            isEnabled: true
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        self.resetDependenciesMockAfterInitViewModel()

        // WHEN
        viewModel.set(isEnabled: newIsEnabledMock)

        // THEN
        XCTAssertEqual(viewModel.isEnabled,
                       newIsEnabledMock,
                       "Wrong isEnabled value")

        // Published count
        self.testAllPublishedSinkCount(
            expectedIsToggleInteractionEnabledPublishedSinkCount: 1,
            expectedToggleOpacityPublishedSinkCount: 1,
            expectedToggleBackgroundColorTokenPublishedSinkCount: 1,
            expectedToggleDotBackgroundColorTokenPublishedSinkCount: 1,
            expectedToggleDotForegroundColorTokenPublishedSinkCount: 1,
            expectedTextForegroundColorTokenPublishedSinkCount: 1
        )

        // **
        // Use Cases
        self.testGetColorsUseCaseMock(
            numberOfCalls: 0
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

    func test_set_images_with_value() {
        // GIVEN
        let newVariantMock = SwitchUIImages(on: UIImage(), off: UIImage())

        let isOnMock = true

        let viewModel = self.classToTest(
            isOn: isOnMock,
            images: nil
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        self.resetDependenciesMockAfterInitViewModel()

        // WHEN
        viewModel.set(images: .left(newVariantMock))

        // THEN
        XCTAssertEqual(viewModel.images?.leftValue,
                       newVariantMock,
                       "Wrong images value")

        // **
        // Published properties
        self.testToggleDotImage(
            on: viewModel,
            shouldContainsImages: true
        )

        self.testAllPublishedSinkCount(
            expectedToggleDotImagePublishedSinkCount: 1
        )
        // **

        // Use Cases
        self.testGetImageUseCaseMock(
            givenIsOn: isOnMock,
            givenImages: newVariantMock
        )
    }

    func test_set_images_without_value() {
        // GIVEN
        let isOnMock = true

        let viewModel = self.classToTest(
            isOn: isOnMock,
            images: nil
        )

        self.subscribeAllPublishedValues(on: viewModel)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        self.resetDependenciesMockAfterInitViewModel()

        // WHEN
        viewModel.set(images: nil)

        // THEN
        XCTAssertNil(viewModel.images?.leftValue,
                     "Wrong images value")

        // **
        // Published properties
        self.testToggleDotImage(on: viewModel, shouldContainsImages: false)

        self.testAllPublishedSinkCount(
            expectedToggleDotImagePublishedSinkCount: 0
        )
        // **

        // Use Cases
        self.testGetImageUseCaseMock(
            numberOfCalls: 0
        )
    }

    // TODO: tester textChanged
}

// MARK: - Class to test

private extension SwitchViewModelTests {

    func classToTest(
        isOn: Bool = true,
        alignment: SwitchAlignment = .left,
        intent: SwitchIntent = .alert,
        isEnabled: Bool = true,
        images: SwitchUIImages? = nil,
        text: String? = nil,
        attributedText: NSAttributedString? = nil
    ) -> SwitchViewModel {
        let imagesEither: SwitchImagesEither?
        if let images {
            imagesEither = .left(images)
        } else {
            imagesEither = nil
        }

        let attributedTextEither: AttributedStringEither?
        if let attributedText {
            attributedTextEither = .left(attributedText)
        } else {
            attributedTextEither = nil
        }

        return .init(
            theme: self.themeMock,
            isOn: isOn,
            alignment: alignment,
            intent: intent,
            isEnabled: isEnabled,
            images:  imagesEither,
            text: text,
            attributedText: attributedTextEither,
            dependencies: self.dependenciesMock
        )
    }
}

// MARK: - Testing Published

private extension SwitchViewModelTests {

    private func subscribeAllPublishedValues(on viewModel: SwitchViewModel) {
        viewModel.$isOnChanged.count().sink { value in
            print("LOGROB count \(value)")
        }.store(in: &self.subscriptions)

        viewModel.$isOnChanged.sink { _ in
            self.isOnChangedPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$isToggleInteractionEnabled.sink { _ in
            self.isToggleInteractionEnabledPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$toggleOpacity.sink { _ in
            self.toggleOpacityPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$toggleBackgroundColorToken.sink { _ in
            self.toggleBackgroundColorTokenPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$toggleDotBackgroundColorToken.sink { _ in
            self.toggleDotBackgroundColorTokenPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$toggleDotForegroundColorToken.sink { _ in
            self.toggleDotForegroundColorTokenPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$textForegroundColorToken.sink { _ in
            self.textForegroundColorTokenPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$isToggleOnLeft.sink { _ in
            self.isToggleOnLeftPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$horizontalSpacing.sink { _ in
            self.horizontalSpacingPublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$showToggleLeftSpace.sink { _ in
            self.showToggleLeftSpacePublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$toggleDotImage.sink { _ in
            self.toggleDotImagePublishedSinkCount += 1
        }.store(in: &self.subscriptions)

        viewModel.$textFontToken.sink { _ in
            self.textFontTokenPublishedSinkCount += 1
        }.store(in: &self.subscriptions)
    }

    func testAllPublishedSinkCount(
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
        expectedTextFontTokenPublishedSinkCount: Int = 0
    ) {
        XCTAssertEqual(self.isOnChangedPublishedSinkCount,
                       expectedIsOnChangedPublishedSinkCount,
                       "Wrong isOnChangedPublishedSinkCount value")

        XCTAssertEqual(self.isToggleInteractionEnabledPublishedSinkCount,
                       expectedIsToggleInteractionEnabledPublishedSinkCount,
                       "Wrong isToggleInteractionEnabledPublishedSinkCount value")
        XCTAssertEqual(self.toggleOpacityPublishedSinkCount,
                       expectedToggleOpacityPublishedSinkCount,
                       "Wrong toggleOpacityPublishedSinkCount value")

        XCTAssertEqual(self.toggleBackgroundColorTokenPublishedSinkCount,
                       expectedToggleBackgroundColorTokenPublishedSinkCount,
                       "Wrong toggleBackgroundColorTokenPublishedSinkCount value")
        XCTAssertEqual(self.toggleDotBackgroundColorTokenPublishedSinkCount,
                       expectedToggleDotBackgroundColorTokenPublishedSinkCount,
                       "Wrong toggleDotBackgroundColorTokenPublishedSinkCount value")
        XCTAssertEqual(self.toggleDotForegroundColorTokenPublishedSinkCount,
                       expectedToggleDotForegroundColorTokenPublishedSinkCount,
                       "Wrong toggleDotForegroundColorTokenPublishedSinkCount value")
        XCTAssertEqual(self.textForegroundColorTokenPublishedSinkCount,
                       expectedTextForegroundColorTokenPublishedSinkCount,
                       "Wrong textForegroundColorTokenPublishedSinkCount value")

        XCTAssertEqual(self.horizontalSpacingPublishedSinkCount,
                       expectedHorizontalSpacingPublishedSinkCount,
                       "Wrong horizontalSpacingPublishedSinkCount value")
        XCTAssertEqual(self.showToggleLeftSpacePublishedSinkCount,
                       expectedShowToggleLeftSpacePublishedSinkCount,
                       "Wrong showToggleLeftSpacePublishedSinkCount value")

        XCTAssertEqual(self.toggleDotImagePublishedSinkCount,
                       expectedToggleDotImagePublishedSinkCount,
                       "Wrong toggleDotImagePublishedSinkCount value")

        XCTAssertEqual(self.textFontTokenPublishedSinkCount,
                       expectedTextFontTokenPublishedSinkCount,
                       "Wrong textFontTokenPublishedSinkCount value")
    }

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

    func testToggleDotImage(on viewModel: SwitchViewModel, shouldContainsImages: Bool) {
        if shouldContainsImages {
            XCTAssertEqual(viewModel.toggleDotImage?.leftValue,
                           self.imageMock,
                           "Wrong toggleDotImage value")
        } else {
            XCTAssertNil(viewModel.toggleDotImage,
                         "Wrong toggleDotImage value")
        }
    }

    func testTextFont(on viewModel: SwitchViewModel, theme: Theme) {
        XCTAssertIdentical(try XCTUnwrap(viewModel.textFontToken as? TypographyFontTokenGeneratedMock),
                           theme.typography.body1 as? TypographyFontTokenGeneratedMock,
                           "Wrong textFontToken value")
    }
}

// MARK: - Testing Dependencies

private extension SwitchViewModelTests {

    func testGetColorsUseCaseMock(
        numberOfCalls: Int = 1,
        givenTheme: Theme? = nil,
        givenIntent: SwitchIntent? = nil
    ) {
        XCTAssertEqual(self.getColorsUseCaseMock.executeWithIntentAndColorsAndDimsCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getColorsUseCase")

        if numberOfCalls > 0, let givenTheme, let givenIntent {
            let getColorsUseCaseArgs = self.getColorsUseCaseMock.executeWithIntentAndColorsAndDimsReceivedArguments
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
        numberOfCalls: Int = 1,
        givenIsOn: Bool? = nil,
        givenImages: SwitchUIImages? = nil
    ) {
        XCTAssertEqual(self.getImageUseCaseMock.executeWithIsOnAndImagesCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getImageUseCase")

        if numberOfCalls > 0, let givenIsOn {
            let getImageUseCaseArgs = self.getImageUseCaseMock.executeWithIsOnAndImagesReceivedArguments
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
        numberOfCalls: Int = 2,
        givenIsOn: Bool? = nil
    ) {
        let givenStatusAndStateColors =  [
            self.colorsMock.toggleBackgroundColors,
            self.colorsMock.toggleDotForegroundColors
        ]

        XCTAssertEqual(self.getToggleColorUseCaseMock.executeWithIsOnAndStatusAndStateColorCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getToggleColorUseCase")

        if numberOfCalls > 0, let givenIsOn {
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
                XCTAssertEqual(try XCTUnwrap(args.statusAndStateColor),
                               givenStatusAndStateColors[givenStatusAndStateColorsIndex],
                               "Wrong statusAndStateColor parameter on \(index) execute on getToggleColorUseCase")
            }
        }
    }

    func testGetPositionUseCaseMock(
        numberOfCalls: Int = 1,
        givenTheme: Theme? = nil,
        givenAlignment: SwitchAlignment? = nil
    ) {
        XCTAssertEqual(self.getPositionUseCaseMock.executeWithAlignmentAndSpacingCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getPositionUseCase")

        if numberOfCalls > 0, let givenTheme, let givenAlignment {
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
        givenTheme: Theme? = nil,
        givenIsEnabled: Bool? = nil
    ) {
        XCTAssertEqual(self.getToggleStateUseCaseMock.executeWithIsEnabledAndDimsCallsCount,
                       numberOfCalls,
                       "Wrong call number on execute on getToggleStateUseCase")

        if numberOfCalls > 0, let givenTheme, let givenIsEnabled {
            let getToggleStateUseCaseArgs = self.getToggleStateUseCaseMock.executeWithIsEnabledAndDimsReceivedArguments
            XCTAssertEqual(getToggleStateUseCaseArgs?.isEnabled,
                           givenIsEnabled,
                           "Wrong isEnabled parameter on execute on getToggleStateUseCase")
            XCTAssertIdentical(try XCTUnwrap(getToggleStateUseCaseArgs?.dims as? DimsGeneratedMock),
                               givenTheme.dims as? DimsGeneratedMock,
                               "Wrong dims parameter on execute on getToggleStateUseCase")
        }
    }

    func resetDependenciesMockAfterInitViewModel() {
        // Clear UseCases Mock
        let useCases: [ResetGeneratedMock] = [
            self.getColorsUseCaseMock,
            self.getImageUseCaseMock,
            self.getToggleColorUseCaseMock,
            self.getPositionUseCaseMock
        ]
        useCases.forEach { $0.reset() }

        // Reset published sink counter
        self.isOnChangedPublishedSinkCount = 0
        self.isToggleInteractionEnabledPublishedSinkCount = 0
        self.toggleOpacityPublishedSinkCount = 0
        self.toggleBackgroundColorTokenPublishedSinkCount = 0
        self.toggleDotBackgroundColorTokenPublishedSinkCount = 0
        self.toggleDotForegroundColorTokenPublishedSinkCount = 0
        self.textForegroundColorTokenPublishedSinkCount = 0
        self.isToggleOnLeftPublishedSinkCount = 0
        self.horizontalSpacingPublishedSinkCount = 0
        self.showToggleLeftSpacePublishedSinkCount = 0
        self.toggleDotImagePublishedSinkCount = 0
        self.textFontTokenPublishedSinkCount = 0

    }
}

extension Publisher {

    func azd() {
        self.count()
    }





}
