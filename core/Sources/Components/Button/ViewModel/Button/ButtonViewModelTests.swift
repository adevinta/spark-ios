//
//  ButtonViewModelTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 13/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest
@testable import SparkCore
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

    func test_properties_on_init_when_frameworkType_is_UIKit() {
        self.testPropertiesOnInit(givenFrameworkType: .uiKit)
    }

    func test_properties_on_init_when_frameworkType_is_SwiftUI() {
        self.testPropertiesOnInit(givenFrameworkType: .swiftUI)
    }

    private func testPropertiesOnInit(
        givenFrameworkType: FrameworkType
    ) {
        // GIVEN
        let givenAlignment: ButtonAlignment = .trailingImage

        let isUIKit = givenFrameworkType == .uiKit

        // WHEN
        let stub = Stub(
            frameworkType: givenFrameworkType,
            alignment: givenAlignment
        )

        stub.subscribePublishers(on: &self.subscriptions)

        // THEN

        // Properties
        XCTAssertEqual(
            stub.viewModel.alignment,
            givenAlignment,
            "Wrong alignment value"
        )

        // **
        // Published properties

        // Spacings
        ButtonViewModelPublisherTest.XCTAssert(
            spacings: stub.spacingsPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: !isUIKit ? stub.spacings : nil
        )

        // Is Image Trailing
        ButtonViewModelPublisherTest.XCTAssert(
            isImageTrailing: stub.isImageTrailingPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: !isUIKit ? givenAlignment.isTrailingImage : false
        )

        // Title Font Token
        ButtonViewModelPublisherTest.XCTAssert(
            titleFontToken: stub.titleFontTokenPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: !isUIKit ? stub.themeMock.typography.callout as? TypographyFontTokenGeneratedMock : nil
        )
        // **

        // Use Cases
        ButtonGetSpacingsUseCaseableMockTest.XCTAssert(
            stub.getSpacingsUseCaseMock,
            expectedNumberOfCalls: (isUIKit ? 0 : 1),
            givenSpacing: stub.themeMock.layout.spacing as? LayoutSpacingGeneratedMock,
            expectedReturnValue: stub.spacings
        )
    }

    // MARK: - Setter Tests

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
        let defaultValue: ButtonAlignment = .leadingImage
        let newValue: ButtonAlignment = givenIsDifferentNewValue ? .trailingImage : defaultValue

        let stub = Stub(
            alignment: defaultValue
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        stub.resetMockedData()

        // WHEN
        viewModel.alignment = newValue

        // THEN

        // Properties
        XCTAssertEqual(
            stub.viewModel.alignment,
            newValue,
            "Wrong alignment value"
        )

        // **
        // Published properties

        // Spacings
        ButtonViewModelPublisherTest.XCTSinksCount(
            spacings: stub.spacingsPublisherMock,
            expectedNumberOfSinks: 0
        )

        // Is Image Trailing
        ButtonViewModelPublisherTest.XCTAssert(
            isImageTrailing: stub.isImageTrailingPublisherMock,
            expectedNumberOfSinks: givenIsDifferentNewValue ? 1 : 0,
            expectedValue: newValue.isTrailingImage
        )

        // Title Font Token
        ButtonViewModelPublisherTest.XCTSinksCount(
            titleFontToken: stub.titleFontTokenPublisherMock,
            expectedNumberOfSinks: 0
        )
        // **

        // Use Cases
        ButtonGetSpacingsUseCaseableMockTest.XCTCallsCount(
            stub.getSpacingsUseCaseMock,
            executeWithSpacingNumberOfCalls: 0
        )
    }

    // MARK: - Update Tests

    func test_updateAll() {
        // GIVEN
        let givenAlignment: ButtonAlignment = .trailingImage

        let stub = Stub(
            alignment: givenAlignment
        )
        let viewModel = stub.viewModel

        stub.subscribePublishers(on: &self.subscriptions)

        viewModel.load() // Needed to get colors from usecase one time

        // Reset all UseCase mock
        stub.resetMockedData()

        // WHEN
        viewModel.updateAll()

        // THEN

        // **
        // Published properties

        // Spacings
        ButtonViewModelPublisherTest.XCTAssert(
            spacings: stub.spacingsPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: stub.spacings
        )

        // Is Image Trailing
        ButtonViewModelPublisherTest.XCTAssert(
            isImageTrailing: stub.isImageTrailingPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: givenAlignment.isTrailingImage
        )

        // Title Font Token
        ButtonViewModelPublisherTest.XCTAssert(
            titleFontToken: stub.titleFontTokenPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: stub.themeMock.typography.callout as? TypographyFontTokenGeneratedMock
        )
        // **

        // Use Cases
        ButtonGetSpacingsUseCaseableMockTest.XCTAssert(
            stub.getSpacingsUseCaseMock,
            expectedNumberOfCalls: 1,
            givenSpacing: stub.themeMock.layout.spacing as? LayoutSpacingGeneratedMock,
            expectedReturnValue: stub.spacings
        )
    }
}

private final class Stub: ButtonViewModelStub {

    // MARK: - Properties

    let spacings = ButtonSpacings.mocked()

    let themeMock = ThemeGeneratedMock.mocked()

    // MARK: - Initialization

    init(
        frameworkType: FrameworkType = .uiKit,
        alignment: ButtonAlignment
    ) {
        // **
        // Use Cases
        let getSpacingsUseCaseMock = ButtonGetSpacingsUseCaseableGeneratedMock()
        getSpacingsUseCaseMock.executeWithSpacingReturnValue = self.spacings
        // **

        // **
        // View Model
        let viewModel = ButtonViewModel(
            for: frameworkType,
            theme: self.themeMock,
            intent: .main,
            variant: .filled,
            size: .medium,
            shape: .pill,
            alignment: alignment,
            getSpacingsUseCase: getSpacingsUseCaseMock
        )
        // **

        super.init(
            viewModel: viewModel,
            getSpacingsUseCaseMock: getSpacingsUseCaseMock
        )
    }
}

