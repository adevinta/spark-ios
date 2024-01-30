//
//  ButtonMainViewModelTests.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 25.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore
import Combine

final class ButtonMainViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Setup

    override func tearDown() {
        super.tearDown()

        // Clear publishers
        self.subscriptions.removeAll()
    }

    // MARK: - Init Tests

    func test_init_when_frameworkType_is_UIKit() {
        self.testAllData(for: .initForUIKit)
    }

    func test_init_when_frameworkType_is_SwiftUI() {
        self.testAllData(for: .initForSwiftUI)
    }

    // MARK: - Load Tests

    func test_load() {
        self.testAllData(for: .load)
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
                viewModel.pressedAction(true)
            }
        } else {
            viewModel.pressedAction(!isAlreadyOnPressedState)
        }

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        viewModel.pressedAction(isPressedAction)

        // THEN
        // **
        // Published properties
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            state: stub.statePublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTAssert(
            currentColors: stub.currentColorsPublisherMock,
            expectedNumberOfSinks: !isAlreadyOnPressedState ? 1 : 0,
            expectedValue: stub.currentColorsMock
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            sizes: stub.sizesPublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            border: stub.borderPublisherMock,
            expectedNumberOfSinks: 0
        )
        // **

        // **
        // Use Cases
        ButtonGetBorderUseCaseableMockTest.XCTCallsCount(
            stub.getBorderUseCaseMock,
            executeWithShapeAndBorderAndVariantNumberOfCalls: 0
        )
        ButtonGetColorsUseCaseableMockTest.XCTCallsCount(
            stub.getColorsUseCaseMock,
            executeWithThemeAndIntentAndVariantNumberOfCalls: 0
        )
        ButtonGetCurrentColorsUseCaseableMockTest.XCTAssert(
            stub.getCurrentColorsUseCaseMock,
            expectedNumberOfCalls: !isAlreadyOnPressedState ? 1 : 0,
            givenColors: stub.colorsMock,
            givenIsPressed: isPressedAction,
            expectedReturnValue: stub.currentColorsMock
        )
        ButtonGetSizesUseCaseableMockTest.XCTCallsCount(
            stub.getSizesUseCaseMock,
            executeWithSizeAndTypeNumberOfCalls: 0
        )
        ButtonGetStateUseCaseableMockTest.XCTCallsCount(
            stub.getStateUseCaseMock,
            executeWithIsEnabledAndDimsNumberOfCalls: 0
        )
        // **
    }

    // MARK: - Update All

    func test_updateAll() {
        self.testAllData(for: .updateAll)
    }

    // MARK: - Setter Tests

    func test_set_theme() {
        self.testAllData(for: .setTheme)
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
        viewModel.intent = newValue

        // THEN
        XCTAssertEqual(
            viewModel.intent,
            newValue,
            "Wrong intent value"
        )

        // **
        // Published properties
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            state: stub.statePublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTAssert(
            currentColors: stub.currentColorsPublisherMock,
            expectedNumberOfSinks: givenIsDifferentNewValue ? 1 : 0,
            expectedValue: stub.currentColorsMock
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            sizes: stub.sizesPublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            border: stub.borderPublisherMock,
            expectedNumberOfSinks: 0
        )
        // **

        // **
        // Use Cases
        ButtonGetBorderUseCaseableMockTest.XCTCallsCount(
            stub.getBorderUseCaseMock,
            executeWithShapeAndBorderAndVariantNumberOfCalls: 0
        )
        ButtonGetColorsUseCaseableMockTest.XCTAssert(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenTheme: stub.themeMock,
            givenIntent: newValue,
            givenVariant: variantMock,
            expectedReturnValue: stub.colorsMock
        )
        ButtonGetCurrentColorsUseCaseableMockTest.XCTAssert(
            stub.getCurrentColorsUseCaseMock,
            expectedNumberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenColors: stub.colorsMock,
            givenIsPressed: false,
            expectedReturnValue: stub.currentColorsMock
        )
        ButtonGetSizesUseCaseableMockTest.XCTCallsCount(
            stub.getSizesUseCaseMock,
            executeWithSizeAndTypeNumberOfCalls: 0
        )
        ButtonGetStateUseCaseableMockTest.XCTCallsCount(
            stub.getStateUseCaseMock,
            executeWithIsEnabledAndDimsNumberOfCalls: 0
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
        viewModel.variant = newValue

        // THEN
        XCTAssertEqual(
            viewModel.variant,
            newValue,
            "Wrong variant value"
        )

        // **
        // Published properties
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            state: stub.statePublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTAssert(
            currentColors: stub.currentColorsPublisherMock,
            expectedNumberOfSinks: givenIsDifferentNewValue ? 1 : 0,
            expectedValue: stub.currentColorsMock
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            sizes: stub.sizesPublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTAssert(
            border: stub.borderPublisherMock,
            expectedNumberOfSinks: givenIsDifferentNewValue ? 1 : 0,
            expectedValue: stub.borderMock
        )
        // **

        // **
        // Use Cases
        ButtonGetBorderUseCaseableMockTest.XCTAssert(
            stub.getBorderUseCaseMock,
            expectedNumberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenShape: shapeMock,
            givenBorder: stub.themeMock.border as? BorderGeneratedMock,
            givenVariant: newValue,
            expectedReturnValue: stub.borderMock
        )
        ButtonGetColorsUseCaseableMockTest.XCTAssert(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenTheme: stub.themeMock,
            givenIntent: intentMock,
            givenVariant: newValue,
            expectedReturnValue: stub.colorsMock
        )
        ButtonGetCurrentColorsUseCaseableMockTest.XCTAssert(
            stub.getCurrentColorsUseCaseMock,
            expectedNumberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenColors: stub.colorsMock,
            givenIsPressed: false,
            expectedReturnValue: stub.currentColorsMock
        )
        ButtonGetSizesUseCaseableMockTest.XCTCallsCount(
            stub.getSizesUseCaseMock,
            executeWithSizeAndTypeNumberOfCalls: 0
        )
        ButtonGetStateUseCaseableMockTest.XCTCallsCount(
            stub.getStateUseCaseMock,
            executeWithIsEnabledAndDimsNumberOfCalls: 0
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

        let typeMock: ButtonType = .button

        let stub = Stub(
            type: typeMock,
            size: defaultValue
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        viewModel.size = newValue

        // THEN
        XCTAssertEqual(
            viewModel.size,
            newValue,
            "Wrong size value"
        )

        // **
        // Published properties
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            state: stub.statePublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            currentColors: stub.currentColorsPublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTAssert(
            sizes: stub.sizesPublisherMock,
            expectedNumberOfSinks: givenIsDifferentNewValue ? 1 : 0,
            expectedValue: stub.sizesMock
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            border: stub.borderPublisherMock,
            expectedNumberOfSinks: 0
        )
        // **

        // **
        // Use Cases
        ButtonGetBorderUseCaseableMockTest.XCTCallsCount(
            stub.getBorderUseCaseMock,
            executeWithShapeAndBorderAndVariantNumberOfCalls: 0
        )
        ButtonGetColorsUseCaseableMockTest.XCTCallsCount(
            stub.getColorsUseCaseMock,
            executeWithThemeAndIntentAndVariantNumberOfCalls: 0
        )
        ButtonGetCurrentColorsUseCaseableMockTest.XCTCallsCount(
            stub.getCurrentColorsUseCaseMock,
            executeWithColorsAndIsPressedNumberOfCalls: 0
        )
        ButtonGetSizesUseCaseableMockTest.XCTAssert(
            stub.getSizesUseCaseMock,
            expectedNumberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenSize: newValue,
            givenType: typeMock,
            expectedReturnValue: stub.sizesMock
        )
        ButtonGetStateUseCaseableMockTest.XCTCallsCount(
            stub.getStateUseCaseMock,
            executeWithIsEnabledAndDimsNumberOfCalls: 0
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
        viewModel.shape = newValue

        // THEN
        XCTAssertEqual(
            viewModel.shape,
            newValue,
            "Wrong shape value"
        )

        // **
        // Published properties
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            state: stub.statePublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            currentColors: stub.currentColorsPublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            sizes: stub.sizesPublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTAssert(
            border: stub.borderPublisherMock,
            expectedNumberOfSinks: givenIsDifferentNewValue ? 1 : 0,
            expectedValue: stub.borderMock
        )
        // **

        // **
        // Use Cases
        ButtonGetBorderUseCaseableMockTest.XCTAssert(
            stub.getBorderUseCaseMock,
            expectedNumberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenShape: newValue,
            givenBorder: stub.themeMock.border as? BorderGeneratedMock,
            givenVariant: variantMock,
            expectedReturnValue: stub.borderMock
        )
        ButtonGetColorsUseCaseableMockTest.XCTCallsCount(
            stub.getColorsUseCaseMock,
            executeWithThemeAndIntentAndVariantNumberOfCalls: 0
        )
        ButtonGetCurrentColorsUseCaseableMockTest.XCTCallsCount(
            stub.getCurrentColorsUseCaseMock,
            executeWithColorsAndIsPressedNumberOfCalls: 0
        )
        ButtonGetSizesUseCaseableMockTest.XCTCallsCount(
            stub.getSizesUseCaseMock,
            executeWithSizeAndTypeNumberOfCalls: 0
        )
        ButtonGetStateUseCaseableMockTest.XCTCallsCount(
            stub.getStateUseCaseMock,
            executeWithIsEnabledAndDimsNumberOfCalls: 0
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

        let stub = Stub()
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all dependencies mocked data
        stub.resetMockedData()

        // WHEN
        viewModel.isEnabled = newValue

        // THEN
        XCTAssertEqual(
            viewModel.isEnabled,
            newValue,
            "Wrong isEnabled value"
        )

        // **
        // Published properties
        ButtonMainViewModelPublisherTest.XCTAssert(
            state: stub.statePublisherMock,
            expectedNumberOfSinks: givenIsDifferentNewValue ? 1 : 0,
            expectedValue: stub.stateMock
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            currentColors: stub.currentColorsPublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            sizes: stub.sizesPublisherMock,
            expectedNumberOfSinks: 0
        )
        ButtonMainViewModelPublisherTest.XCTSinksCount(
            border: stub.borderPublisherMock,
            expectedNumberOfSinks: 0
        )
        // **

        // **
        // Use Cases
        ButtonGetBorderUseCaseableMockTest.XCTCallsCount(
            stub.getBorderUseCaseMock,
            executeWithShapeAndBorderAndVariantNumberOfCalls: 0
        )
        ButtonGetColorsUseCaseableMockTest.XCTCallsCount(
            stub.getColorsUseCaseMock,
            executeWithThemeAndIntentAndVariantNumberOfCalls: 0
        )
        ButtonGetCurrentColorsUseCaseableMockTest.XCTCallsCount(
            stub.getCurrentColorsUseCaseMock,
            executeWithColorsAndIsPressedNumberOfCalls: 0
        )
        ButtonGetSizesUseCaseableMockTest.XCTCallsCount(
            stub.getSizesUseCaseMock,
            executeWithSizeAndTypeNumberOfCalls: 0
        )
        ButtonGetStateUseCaseableMockTest.XCTAssert(
            stub.getStateUseCaseMock,
            expectedNumberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenIsEnabled: newValue,
            givenDims: stub.themeMock.dims as? DimsGeneratedMock,
            expectedReturnValue: stub.stateMock
        )
        // **
    }

    // MARK: - All Data

    private func testAllData(for testAllDataType: TestAllDataType) {
        // GIVEN
        let typeMock: ButtonType = .button
        let intentMock: ButtonIntent = .success
        let variantMock: ButtonVariant = .outlined
        let sizeMock: ButtonSize = .large
        let shapeMock: ButtonShape = .square

        let stub = Stub(
            for: testAllDataType.frameworkType,
            type: typeMock,
            intent: intentMock,
            variant: variantMock,
            size: sizeMock,
            shape: shapeMock
        )
        let viewModel = stub.viewModel

        let themeMock = (testAllDataType == .setTheme) ? ThemeGeneratedMock.mocked() : stub.themeMock

        stub.subscribePublishers(on: &self.subscriptions)

        // WHEN
        if testAllDataType.callResetMockedDataBeforeLoad {
            stub.resetMockedData()
        }

        if testAllDataType.callLoad {
            viewModel.load()
        }

        if testAllDataType.callResetMockedDataAfterLoad {
            stub.resetMockedData()
        }

        switch testAllDataType {
        case .updateAll:
            viewModel.updateAll()
        case .setTheme:
            viewModel.theme = themeMock
        default:
            break
        }

        // THEN
        XCTAssertIdentical(
            viewModel.theme as? ThemeGeneratedMock,
            themeMock,
            "Wrong theme value"
        )
        XCTAssertEqual(
            viewModel.intent,
            intentMock,
            "Wrong intent value"
        )
        XCTAssertEqual(
            viewModel.variant,
            variantMock,
            "Wrong variant value"
        )
        XCTAssertEqual(
            viewModel.size,
            sizeMock,
            "Wrong size value"
        )
        XCTAssertEqual(
            viewModel.shape,
            shapeMock,
            "Wrong shape value"
        )
        XCTAssertEqual(
            viewModel.isEnabled,
            true,
            "Wrong default isEnabled value"
        )

        // **
        // Published properties
        ButtonMainViewModelPublisherTest.XCTAssert(
            state: stub.statePublisherMock,
            expectedNumberOfSinks: testAllDataType.expectedCalledPropertiesAndUseCases ? 1 : 0,
            expectedValue: stub.stateMock
        )
        ButtonMainViewModelPublisherTest.XCTAssert(
            currentColors: stub.currentColorsPublisherMock,
            expectedNumberOfSinks: testAllDataType.expectedCalledPropertiesAndUseCases ? 1 : 0,
            expectedValue: stub.currentColorsMock
        )
        ButtonMainViewModelPublisherTest.XCTAssert(
            sizes: stub.sizesPublisherMock,
            expectedNumberOfSinks: testAllDataType.expectedCalledPropertiesAndUseCases ? 1 : 0,
            expectedValue: stub.sizesMock
        )
        ButtonMainViewModelPublisherTest.XCTAssert(
            border: stub.borderPublisherMock,
            expectedNumberOfSinks: testAllDataType.expectedCalledPropertiesAndUseCases ? 1 : 0,
            expectedValue: stub.borderMock
        )
        // **

        // **
        // Use Cases
        ButtonGetBorderUseCaseableMockTest.XCTAssert(
            stub.getBorderUseCaseMock,
            expectedNumberOfCalls: testAllDataType.expectedCalledPropertiesAndUseCases ? 1 : 0,
            givenShape: shapeMock,
            givenBorder: themeMock.border as? BorderGeneratedMock,
            givenVariant: variantMock,
            expectedReturnValue: stub.borderMock
        )
        ButtonGetColorsUseCaseableMockTest.XCTAssert(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: testAllDataType.expectedCalledPropertiesAndUseCases ? 1 : 0,
            givenTheme: themeMock,
            givenIntent: intentMock,
            givenVariant: variantMock,
            expectedReturnValue: stub.colorsMock
        )
        ButtonGetCurrentColorsUseCaseableMockTest.XCTAssert(
            stub.getCurrentColorsUseCaseMock,
            expectedNumberOfCalls: testAllDataType.expectedCalledPropertiesAndUseCases ? 1 : 0,
            givenColors: stub.colorsMock,
            givenIsPressed: false,
            expectedReturnValue: stub.currentColorsMock
        )
        ButtonGetSizesUseCaseableMockTest.XCTAssert(
            stub.getSizesUseCaseMock,
            expectedNumberOfCalls: testAllDataType.expectedCalledPropertiesAndUseCases ? 1 : 0,
            givenSize: sizeMock,
            givenType: typeMock,
            expectedReturnValue: stub.sizesMock
        )
        ButtonGetStateUseCaseableMockTest.XCTAssert(
            stub.getStateUseCaseMock,
            expectedNumberOfCalls: testAllDataType.expectedCalledPropertiesAndUseCases ? 1 : 0,
            givenIsEnabled: true,
            givenDims: themeMock.dims as? DimsGeneratedMock,
            expectedReturnValue: stub.stateMock
        )
        // **
    }
}

// MARK: - Stub

private final class Stub: ButtonMainViewModelStub {

    // MARK: - Data Properties

    let themeMock = ThemeGeneratedMock.mocked()

    let borderMock = ButtonBorder.mocked()
    let colorsMock = ButtonColors.mocked()
    let currentColorsMock = ButtonCurrentColors.mocked()
    let sizesMock = ButtonSizes.mocked()
    let stateMock = ButtonState.mocked()

    // MARK: - Initialization

    init(
        for frameworkType: FrameworkType = .uiKit,
        type: ButtonType = .button,
        intent: ButtonIntent = .main,
        variant: ButtonVariant  = .tinted,
        size: ButtonSize  = .medium,
        shape: ButtonShape  = .rounded
    ) {
        // **
        // Use Cases
        let getBorderUseCaseMock = ButtonGetBorderUseCaseableGeneratedMock()
        getBorderUseCaseMock.executeWithShapeAndBorderAndVariantReturnValue = self.borderMock

        let getColorsUseCaseMock = ButtonGetColorsUseCaseableGeneratedMock()
        getColorsUseCaseMock.executeWithThemeAndIntentAndVariantReturnValue = self.colorsMock

        let getCurrentColorsUseCaseMock = ButtonGetCurrentColorsUseCaseableGeneratedMock()
        getCurrentColorsUseCaseMock.executeWithColorsAndIsPressedReturnValue = self.currentColorsMock

        let getSizesUseCaseMock = ButtonGetSizesUseCaseableGeneratedMock()
        getSizesUseCaseMock.executeWithSizeAndTypeReturnValue = self.sizesMock

        let getStateUseCaseMock = ButtonGetStateUseCaseableGeneratedMock()
        getStateUseCaseMock.executeWithIsEnabledAndDimsReturnValue = self.stateMock
        // **

        let viewModel = ButtonMainViewModel(
            for: frameworkType,
            type: .button,
            theme: self.themeMock,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape,
            getBorderUseCase: getBorderUseCaseMock,
            getColorsUseCase: getColorsUseCaseMock,
            getCurrentColorsUseCase: getCurrentColorsUseCaseMock,
            getSizesUseCase: getSizesUseCaseMock,
            getStateUseCase: getStateUseCaseMock
        )

        super.init(
            viewModel: viewModel,
            getBorderUseCaseMock: getBorderUseCaseMock,
            getColorsUseCaseMock: getColorsUseCaseMock,
            getCurrentColorsUseCaseMock: getCurrentColorsUseCaseMock,
            getSizesUseCaseMock: getSizesUseCaseMock,
            getStateUseCaseMock: getStateUseCaseMock
        )
    }
}

// MARK: - Enum

private enum TestAllDataType {
    case initForSwiftUI
    case initForUIKit
    case load
    case updateAll
    case setTheme

    // MARK: - Properties

    var frameworkType: FrameworkType {
        switch self {
        case .initForSwiftUI:
            return .swiftUI
        default:
            return .uiKit
        }
    }

    var callLoad: Bool {
        switch self {
        case .initForUIKit, .load:
            return true
        default:
            return false
        }
    }

    var callResetMockedDataBeforeLoad: Bool {
        switch self {
        case .load:
            return true
        default:
            return false
        }
    }

    var callResetMockedDataAfterLoad: Bool {
        switch self {
        case .initForSwiftUI, .load:
            return false
        default:
            return true
        }
    }

    var expectedCalledPropertiesAndUseCases: Bool {
        switch self {
        case .initForUIKit:
            return false
        default:
            return true
        }
    }
}
