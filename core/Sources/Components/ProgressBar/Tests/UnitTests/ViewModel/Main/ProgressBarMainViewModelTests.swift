//
// ProgressBarMainViewModelTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore
import Combine

final class ProgressBarMainViewModelTests: XCTestCase {

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
        let intentMock: Stub.Intent = .init()
        let shapeMock: ProgressBarShape = .square

        let isUIKit = givenFrameworkType == .uiKit

        // WHEN
        let stub = Stub(
            frameworkType: givenFrameworkType,
            intent: intentMock,
            shape: shapeMock
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        // THEN
        XCTAssertIdentical(
            viewModel.theme as? ThemeGeneratedMock,
            stub.themeMock,
            "Wrong theme value"
        )
        XCTAssertEqual(
            viewModel.intent,
            intentMock,
            "Wrong intent value"
        )
        XCTAssertEqual(
            viewModel.shape,
            shapeMock,
            "Wrong shape value"
        )

        // **
        // Published properties
        ProgressBarMainViewModelPublisherTest.XCTAssert(
            colors: stub.colorsPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: !isUIKit ? stub.colorsMock : nil
        )
        ProgressBarMainViewModelPublisherTest.XCTAssert(
            cornerRadius: stub.cornerRadiusPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: !isUIKit ? stub.cornerRadiusMock : nil
        )
        // **

        // Use Cases
        ProgressBarMainGetColorsUseCaseableMockTest.XCTAssert(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: (isUIKit ? 0 : 1),
            givenIntent: intentMock,
            givenColors: stub.themeMock.colors as? ColorsGeneratedMock,
            givenDims: stub.themeMock.dims as? DimsGeneratedMock,
            expectedReturnValue: stub.colorsMock
        )
        ProgressBarGetCornerRadiusUseCaseableMockTest.XCTAssert(
            stub.getCornerRadiusUseCaseMock,
            expectedNumberOfCalls: (isUIKit ? 0 : 1),
            givenShape: shapeMock,
            givenBorder: stub.themeMock.border as? BorderGeneratedMock,
            expectedReturnValue: stub.cornerRadiusMock
        )
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
        let intentMock: Stub.Intent = .init()
        let shapeMock: ProgressBarShape = .square

        let isUIKit = givenFrameworkType == .uiKit

        // WHEN
        let stub = Stub(
            frameworkType: givenFrameworkType,
            intent: intentMock,
            shape: shapeMock
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        // Reset all UseCase mock
        stub.resetMockedData()

        viewModel.load()

        // THEN
        // **
        // Published properties
        ProgressBarMainViewModelPublisherTest.XCTAssert(
            colors: stub.colorsPublisherMock,
            expectedNumberOfSinks: isUIKit ? 1 : 0,
            expectedValue: isUIKit ? stub.colorsMock : nil
        )
        ProgressBarMainViewModelPublisherTest.XCTAssert(
            cornerRadius: stub.cornerRadiusPublisherMock,
            expectedNumberOfSinks: isUIKit ? 1 : 0,
            expectedValue: isUIKit ? stub.cornerRadiusMock : nil
        )
        // **

        // Use Cases
        ProgressBarMainGetColorsUseCaseableMockTest.XCTAssert(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: (isUIKit ? 1 : 0),
            givenIntent: intentMock,
            givenColors: stub.themeMock.colors as? ColorsGeneratedMock,
            givenDims: stub.themeMock.dims as? DimsGeneratedMock,
            expectedReturnValue: stub.colorsMock
        )
        ProgressBarGetCornerRadiusUseCaseableMockTest.XCTAssert(
            stub.getCornerRadiusUseCaseMock,
            expectedNumberOfCalls: (isUIKit ? 1 : 0),
            givenShape: shapeMock,
            givenBorder: stub.themeMock.border as? BorderGeneratedMock,
            expectedReturnValue: stub.cornerRadiusMock
        )
    }

    // MARK: - Setter Tests

    func test_set_theme() {
        // GIVEN
        let newTheme = ThemeGeneratedMock.mocked()

        let intentMock: Stub.Intent = .init()
        let shapeMock: ProgressBarShape = .square

        let stub = Stub(
            intent: intentMock,
            shape: shapeMock
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
        ProgressBarMainViewModelPublisherTest.XCTAssert(
            colors: stub.colorsPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: stub.colorsMock
        )
        ProgressBarMainViewModelPublisherTest.XCTAssert(
            cornerRadius: stub.cornerRadiusPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: stub.cornerRadiusMock
        )
        // **

        // Use Cases
        ProgressBarMainGetColorsUseCaseableMockTest.XCTAssert(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: 1,
            givenIntent: intentMock,
            givenColors: newTheme.colors as? ColorsGeneratedMock,
            givenDims: newTheme.dims as? DimsGeneratedMock,
            expectedReturnValue: stub.colorsMock
        )
        ProgressBarGetCornerRadiusUseCaseableMockTest.XCTAssert(
            stub.getCornerRadiusUseCaseMock,
            expectedNumberOfCalls: 1,
            givenShape: shapeMock,
            givenBorder: newTheme.border as? BorderGeneratedMock,
            expectedReturnValue: stub.cornerRadiusMock
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
        let defaultValue: Stub.Intent = .init()
        let newValue: Stub.Intent = givenIsDifferentNewValue ? .init() : defaultValue

        let stub = Stub(
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
        ProgressBarMainViewModelPublisherTest.XCTAssert(
            colors: stub.colorsPublisherMock,
            expectedNumberOfSinks: givenIsDifferentNewValue ? 1 : 0,
            expectedValue: givenIsDifferentNewValue ? stub.colorsMock : nil
        )

        ProgressBarMainViewModelPublisherTest.XCTSinksCount(
            cornerRadius: stub.cornerRadiusPublisherMock,
            expectedNumberOfSinks: 0
        )
        // **

        // Use Cases
        ProgressBarMainGetColorsUseCaseableMockTest.XCTAssert(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenIntent: newValue,
            givenColors: stub.themeMock.colors as? ColorsGeneratedMock,
            givenDims: stub.themeMock.dims as? DimsGeneratedMock,
            expectedReturnValue: stub.colorsMock
        )
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
        let defaultValue: ProgressBarShape = .square
        let newValue: ProgressBarShape = givenIsDifferentNewValue ? .rounded : defaultValue

        let stub = Stub(
            shape: defaultValue
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        stub.resetMockedData()

        // WHEN
        viewModel.set(shape: newValue)

        // THEN
        XCTAssertEqual(viewModel.shape,
                       newValue,
                       "Wrong shape value")

        // **
        // Published properties
        ProgressBarMainViewModelPublisherTest.XCTSinksCount(
            colors: stub.colorsPublisherMock,
            expectedNumberOfSinks: 0
        )

        ProgressBarMainViewModelPublisherTest.XCTAssert(
            cornerRadius: stub.cornerRadiusPublisherMock,
            expectedNumberOfSinks: givenIsDifferentNewValue ? 1 : 0,
            expectedValue: givenIsDifferentNewValue ? stub.cornerRadiusMock : nil
        )
        // **

        // Use Cases
        ProgressBarGetCornerRadiusUseCaseableMockTest.XCTAssert(
            stub.getCornerRadiusUseCaseMock,
            expectedNumberOfCalls: givenIsDifferentNewValue ? 1 : 0,
            givenShape: newValue,
            givenBorder: stub.themeMock.border as? BorderGeneratedMock,
            expectedReturnValue: stub.cornerRadiusMock
        )
    }
}

// MARK: - Stub

private final class Stub: ProgressBarMainViewModelStub {

    // MARK: - Associated Type

    typealias Intent = Stub.GetColorsUseCase.Intent

    // MARK: - Data Properties

    let frameworkType: FrameworkType

    let themeMock = ThemeGeneratedMock.mocked()

    let colorsMock = Stub.GetColorsUseCase.ReturnMock()
    let cornerRadiusMock = 2.0

    // MARK: - Initialization

    init(
        frameworkType: FrameworkType = .uiKit,
        intent: Intent = .init(),
        shape: ProgressBarShape = .square,
        isEnabled: Bool = true,
        isImages: Bool = false,
        text: String? = nil,
        attributedText: NSAttributedString? = nil,
        userInteractionEnabled: Bool = true
    ) {
        // Data properties
        self.frameworkType = frameworkType

        // **
        // Use Cases
        let getColorsUseCaseMock = Stub.GetColorsUseCase()
        getColorsUseCaseMock.executeWithIntentAndColorsAndDimsReturnValue = self.colorsMock

        let getCornerRadiusUseCaseMock = ProgressBarGetCornerRadiusUseCaseableGeneratedMock()
        getCornerRadiusUseCaseMock.executeWithShapeAndBorderReturnValue = self.cornerRadiusMock
        // **

        // View Model
        let viewModel = ProgressBarMainViewModel(
            for: frameworkType,
            theme: self.themeMock,
            intent: intent,
            shape: shape,
            getColorsUseCase: getColorsUseCaseMock,
            getCornerRadiusUseCase: getCornerRadiusUseCaseMock
        )

        super.init(
            viewModel: viewModel,
            getColorsUseCaseMock: getColorsUseCaseMock,
            getCornerRadiusUseCaseMock: getCornerRadiusUseCaseMock
        )
    }
}
