//
//  ProgressIndeterminateBarViewModelTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 21/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest
@testable import SparkCore
import Combine

final class ProgressIndeterminateBarViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Setup

    override func tearDown() {
        super.tearDown()

        // Clear publishers
        self.subscriptions.removeAll()
    }

    // MARK: - Init Tests
    
    func test_properties_on_init_when_frameworkType_is_UIKit_and_isAnimating_is_false() {
        self.testPropertiesOnInit(
            givenFrameworkType: .uiKit
        )
    }

    func test_properties_on_init_when_frameworkType_is_SwiftUI_and_isAnimating_is_false() {
        self.testPropertiesOnInit(
            givenFrameworkType: .swiftUI
        )
    }

    private func testPropertiesOnInit(
        givenFrameworkType: FrameworkType
    ) {
        // GIVEN / WHEN
        let givenIsAnimating = false

        let stub = Stub(
            frameworkType: givenFrameworkType,
            isAnimating: givenIsAnimating
        )
        let isSwiftUI = givenFrameworkType == .swiftUI

        stub.subscribePublishers(on: &self.subscriptions)

        // THEN

        // **
        // Published properties

        // Is Animating
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            isAnimating: stub.isAnimatingPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: givenIsAnimating
        )

        // Animation data
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            animatedData: stub.animatedDataPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: nil
        )

        // Animation type
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            animationType: stub.animationTypePublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: nil
        )

        // Animation status
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            animationStatus: stub.animationStatusPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: isSwiftUI ? .stop : nil
        )

        // Indicator opacity
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            indicatorOpacity: stub.indicatorOpacityPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: isSwiftUI ? 0 : nil
        )
        // **

        // Use Cases
        ProgressBarGetAnimatedDataUseCaseableMockTest.XCTAssert(
            stub.getAnimatedDataUseCaseMock,
            expectedNumberOfCalls: 0,
            expectedReturnValue: stub.animatedData
        )
    }

    func test_set_isAnimating_to_true() {
        // GIVEN
        let givenIsAnimating = true

        let stub = Stub(
            isAnimating: false
        )

        stub.subscribePublishers(on: &self.subscriptions)
        stub.resetMockedData()

        // WHEN
        stub.viewModel.isAnimating = givenIsAnimating

        // THEN

        // **
        // Published properties

        // Is Animating
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            isAnimating: stub.isAnimatingPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: givenIsAnimating
        )

        // Animation data
        ProgressIndeterminateBarViewModelPublisherTest.XCTSinksCount(
            animatedData: stub.animatedDataPublisherMock,
            expectedNumberOfSinks: 0
        )

        // Animation type
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            animationType: stub.animationTypePublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: .easeIn
        )

        // Animation status
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            animationStatus: stub.animationStatusPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: .start
        )

        // Indicator opacity
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            indicatorOpacity: stub.indicatorOpacityPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: 1
        )
        // **

        // Use Cases
        ProgressBarGetAnimatedDataUseCaseableMockTest.XCTAssert(
            stub.getAnimatedDataUseCaseMock,
            expectedNumberOfCalls: 0,
            expectedReturnValue: stub.animatedData
        )
    }

    // MARK: - Animation Tests

    func test_updateAnimatedData() {
        // GIVEN
        let givenTrackWidth: CGFloat = 200

        let stub = Stub()

        stub.subscribePublishers(on: &self.subscriptions)
        stub.resetMockedData()

        // WHEN
        stub.viewModel.updateAnimatedData(
            from: givenTrackWidth
        )

        // THEN
        // Published properties
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            animatedData: stub.animatedDataPublisherMock,
            expectedNumberOfSinks: 1,
            expectedValue: stub.animatedData
        )

        // Use Case
        ProgressBarGetAnimatedDataUseCaseableMockTest.XCTAssert(
            stub.getAnimatedDataUseCaseMock,
            expectedNumberOfCalls: 1,
            givenType: stub.viewModel.animationType,
            givenTrackWidth: givenTrackWidth,
            expectedReturnValue: stub.animatedData
        )
    }

    func test_animationStepIsDone_when_isAnimating_is_true() {
        self.testAnimationStepIsDone(
            givenIsAnimating: true
        )
    }

    func test_animationStepIsDone_when_isAnimating_is_false() {
        self.testAnimationStepIsDone(
            givenIsAnimating: false
        )
    }

    func testAnimationStepIsDone(
        givenIsAnimating: Bool
    ) {
        // GIVEN
        let stub = Stub(
            isAnimating: givenIsAnimating
        )

        var animationType = stub.viewModel.animationType
        animationType?.next()

        stub.subscribePublishers(on: &self.subscriptions)
        stub.resetMockedData()

        // WHEN
        stub.viewModel.animationStepIsDone()

        // THEN
        // **
        // Published properties
        
        // Animation type
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            animationType: stub.animationTypePublisherMock,
            expectedNumberOfSinks: givenIsAnimating ? 1 : 0,
            expectedValue: animationType
        )

        // Animation status
        ProgressIndeterminateBarViewModelPublisherTest.XCTAssert(
            animationStatus: stub.animationStatusPublisherMock,
            expectedNumberOfSinks: givenIsAnimating ? 0 : 1,
            expectedValue: .stop
        )
        // **
    }

    func test_easeInAnimatedData() {
        self.testAnimatedData(
            givenType: .easeIn
        )
    }

    func test_easeOutAnimatedData() {
        self.testAnimatedData(
            givenType: .easeOut
        )
    }

    func test_resetAnimatedData() {
        self.testAnimatedData(
            givenType: .reset
        )
    }

    private func testAnimatedData(
        givenType: ProgressIndeterminateBarAnimationType
    ) {
        // GIVEN
        let givenTrackWidth: CGFloat = 200

        let stub = Stub()

        // WHEN
        let animatedData: ProgressBarAnimatedData
        switch givenType {
        case .easeIn:
            animatedData = stub.viewModel.easeInAnimatedData(
                trackWidth: givenTrackWidth
            )
        case .easeOut:
            animatedData = stub.viewModel.easeOutAnimatedData(
                trackWidth: givenTrackWidth
            )
        case .reset:
            animatedData = stub.viewModel.resetAnimatedData(
                trackWidth: givenTrackWidth
            )
        }

        // THEN
        ProgressBarGetAnimatedDataUseCaseableMockTest.XCTAssert(
            stub.getAnimatedDataUseCaseMock,
            expectedNumberOfCalls: 1,
            givenType: givenType,
            givenTrackWidth: givenTrackWidth,
            expectedReturnValue: animatedData
        )
    }
}

private final class Stub: ProgressIndeterminateBarViewModelStub {

    // MARK: - Properties

    let animatedData = ProgressBarAnimatedData.mocked()

    // MARK: - Initialization

    init(
        frameworkType: FrameworkType = .uiKit,
        isAnimating: Bool = false
    ) {
        // **
        // Use Cases
        let getAnimatedDataUseCaseMock = ProgressBarGetAnimatedDataUseCaseableGeneratedMock()
        getAnimatedDataUseCaseMock.executeWithTypeAndTrackWidthReturnValue = self.animatedData
        // **

        // **
        // View Model
        let viewModel = ProgressIndeterminateBarViewModel(
            for: frameworkType,
            theme: ThemeGeneratedMock.mocked(),
            intent: .main,
            shape: .pill,
            isAnimating: isAnimating,
            getColorsUseCase: .init(),
            getAnimatedDataUseCase: getAnimatedDataUseCaseMock
        )
        // **

        super.init(
            viewModel: viewModel,
            getAnimatedDataUseCaseMock: getAnimatedDataUseCaseMock
        )
    }
}
