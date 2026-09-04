//
//  XXXPreviewViewModelTests.swift
//  SparkComponentXXXTests
//
//  Created by robin.lemaire on 24/03/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

@testable import SparkComponentXXX
@_spi(SI_SPI) @testable import SparkComponentXXXTesting
@_spi(SI_SPI) import SparkThemingTesting
@_spi(SI_SPI) import SparkTheming
@_spi(SI_SPI) import SparkCommonTesting
import Testing

@Suite("XXXPreview ViewModel Tests")
struct XXXPreviewViewModelTests {

    // MARK: - Initialization

    @Test("Initialization should use default values")
    func initializationShouldUseDefaultValues() {
        // GIVEN / WHEN
        let stub = Stub()
        let viewModel = stub.viewModel

        // THEN
        #expect(viewModel.theme == nil)
        #expect(viewModel.file == nil)
        #expect(viewModel.isPressed == false)

        expectEqualToExpected(
            on: stub,
            otherBorder: XXXPreviewBorder(),
            otherColors: XXXPreviewColors(),
            otherContent: XXXPreviewContent(),
            otherFonts: XXXPreviewFonts(),
            otherImage: .file,
            otherLayout: XXXPreviewLayout()
        )

        expectNotCalled(
            on: stub,
            getBorderUseCase: true,
            getColorsUseCase: true,
            getContentUseCase: true,
            getFontsUseCase: true,
            getImageUseCase: true,
            getLayoutUseCase: true
        )
    }

    // MARK: - Setup

    @Test("Setup should call all use cases")
    func setupShouldCallAllUseCases() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        // WHEN
        viewModel.setup(stub: stub)

        // THEN
        expectEqualToExpected(on: stub)

        XXXPreviewGetBorderUseCaseableMockTest.expect(
            stub.getBorderUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            givenFile: stub.givenFile,
            expectedReturnValue: stub.expectedBorder
        )

        XXXPreviewGetColorsUseCaseableMockTest.expect(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            givenFile: stub.givenFile,
            givenIsPressed: false,
            expectedReturnValue: stub.expectedColors
        )

        XXXPreviewGetContentUseCaseableMockTest.expect(
            stub.getContentUseCaseMock,
            expectedNumberOfCalls: 1,
            givenFile: stub.givenFile,
            expectedReturnValue: stub.expectedContent
        )

        XXXPreviewGetFontsUseCaseableMockTest.expect(
            stub.getFontsUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            expectedReturnValue: stub.expectedFonts
        )

        XXXPreviewGetImageUseCaseableMockTest.expect(
            stub.getImageUseCaseMock,
            expectedNumberOfCalls: 1,
            givenFile: stub.givenFile,
            expectedReturnValue: stub.expectedImage
        )

        XXXPreviewGetLayoutUseCaseableMockTest.expect(
            stub.getLayoutUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            expectedReturnValue: stub.expectedLayout
        )
    }

    // MARK: - Property Changes

    @Test("Theme when changed should call use cases")
    func themeWhenChangedShouldCallUseCases() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel
        viewModel.setup(stub: stub)

        stub.resetMockedData()

        let newTheme = ThemeGeneratedMock.mocked()

        // WHEN
        viewModel.theme = newTheme

        // THEN
        expectEqualToExpected(on: stub)

        XXXPreviewGetBorderUseCaseableMockTest.expect(
            stub.getBorderUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: newTheme,
            givenFile: stub.givenFile,
            expectedReturnValue: stub.expectedBorder
        )

        XXXPreviewGetColorsUseCaseableMockTest.expect(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: newTheme,
            givenFile: stub.givenFile,
            givenIsPressed: false,
            expectedReturnValue: stub.expectedColors
        )

        XXXPreviewGetFontsUseCaseableMockTest.expect(
            stub.getFontsUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: newTheme,
            expectedReturnValue: stub.expectedFonts
        )

        XXXPreviewGetLayoutUseCaseableMockTest.expect(
            stub.getLayoutUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: newTheme,
            expectedReturnValue: stub.expectedLayout
        )

        expectNotCalled(
            on: stub,
            getContentUseCase: true,
            getImageUseCase: true
        )
    }

    @Test("File when changed should call use cases")
    func fileWhenChangedShouldCallUseCases() throws {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel
        viewModel.setup(stub: stub)

        stub.resetMockedData()

        let newFile = XXX(
            id: "new-id",
            name: "newfile.jpg",
            source: .files,
            result: .success(XXXDetails(
                url: URL(fileURLWithPath: "file:///newfile.jpg"),
                data: .mock,
                fileExtension: "jpg",
                size: 3_000_000
            ))
        )

        // WHEN
        viewModel.file = newFile

        // THEN
        expectEqualToExpected(on: stub)

        XXXPreviewGetBorderUseCaseableMockTest.expect(
            stub.getBorderUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            givenFile: newFile,
            expectedReturnValue: stub.expectedBorder
        )

        XXXPreviewGetColorsUseCaseableMockTest.expect(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            givenFile: newFile,
            givenIsPressed: false,
            expectedReturnValue: stub.expectedColors
        )

        XXXPreviewGetContentUseCaseableMockTest.expect(
            stub.getContentUseCaseMock,
            expectedNumberOfCalls: 1,
            givenFile: newFile,
            expectedReturnValue: stub.expectedContent
        )

        XXXPreviewGetImageUseCaseableMockTest.expect(
            stub.getImageUseCaseMock,
            expectedNumberOfCalls: 1,
            givenFile: newFile,
            expectedReturnValue: stub.expectedImage
        )

        expectNotCalled(
            on: stub,
            getFontsUseCase: true,
            getLayoutUseCase: true
        )
    }

    @Test("IsPressed when changed should call colors use case")
    func isPressedWhenChangedShouldCallColorsUseCase() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel
        viewModel.setup(stub: stub)

        stub.resetMockedData()

        // WHEN
        viewModel.isPressed = true

        // THEN
        expectEqualToExpected(on: stub)

        XXXPreviewGetColorsUseCaseableMockTest.expect(
            stub.getColorsUseCaseMock,
            expectedNumberOfCalls: 1,
            givenTheme: stub.givenTheme,
            givenFile: stub.givenFile,
            givenIsPressed: true,
            expectedReturnValue: stub.expectedColors
        )

        expectNotCalled(
            on: stub,
            getBorderUseCase: true,
            getContentUseCase: true,
            getFontsUseCase: true,
            getImageUseCase: true,
            getLayoutUseCase: true
        )
    }

    // MARK: - Properties Changed Before Setup

    @Test("Properties changed before setup should not call use cases")
    func propertiesChangedBeforeSetupShouldNotCallUseCases() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        // WHEN
        viewModel.theme = ThemeGeneratedMock.mocked()
        viewModel.file = stub.givenFile
        viewModel.isPressed = true

        // THEN
        expectEqualToExpected(
            on: stub,
            otherBorder: XXXPreviewBorder(),
            otherColors: XXXPreviewColors(),
            otherContent: XXXPreviewContent(),
            otherFonts: XXXPreviewFonts(),
            otherImage: .file,
            otherLayout: XXXPreviewLayout()
        )

        expectNotCalled(
            on: stub,
            getBorderUseCase: true,
            getColorsUseCase: true,
            getContentUseCase: true,
            getFontsUseCase: true,
            getImageUseCase: true,
            getLayoutUseCase: true
        )
    }

    @Test("Properties changed without value change should not call use cases")
    func propertiesChangedWithoutValueChangeShouldNotCallUseCases() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        viewModel.setup(stub: stub)
        stub.resetMockedData()

        // WHEN
        viewModel.theme = stub.givenTheme
        viewModel.file = stub.givenFile
        viewModel.isPressed = false

        // THEN
        expectEqualToExpected(on: stub)

        expectNotCalled(
            on: stub,
            getBorderUseCase: true,
            getColorsUseCase: true,
            getContentUseCase: true,
            getFontsUseCase: true,
            getImageUseCase: true,
            getLayoutUseCase: true
        )
    }

    @Test("Properties changed with nil values should not call use cases")
    func propertiesChangedWithNilValuesShouldNotCallUseCases() {
        // GIVEN
        let stub = Stub()
        let viewModel = stub.viewModel

        viewModel.setup(stub: stub)
        stub.resetMockedData()

        // WHEN
        viewModel.theme = nil
        viewModel.file = nil

        // THEN
        expectEqualToExpected(on: stub)

        expectNotCalled(
            on: stub,
            getBorderUseCase: true,
            getColorsUseCase: true,
            getContentUseCase: true,
            getFontsUseCase: true,
            getImageUseCase: true,
            getLayoutUseCase: true
        )
    }
}

// MARK: - Stub

private final class Stub {

    // MARK: - Properties

    let givenTheme = ThemeGeneratedMock.mocked()
    let givenFile: XXX = XXX(
        id: "test-id",
        name: "test.pdf",
        source: .files,
        result: .success(XXXDetails(
            url: URL(fileURLWithPath: "file:///test.pdf"),
            data: .mock,
            fileExtension: "pdf",
            size: 2_048_000
        ))
    )

    let expectedBorder = XXXPreviewBorder(width: 1, radius: 2, imageRadius: 3)
    let expectedColors = XXXPreviewColors(
        backgroundColorToken: ColorTokenGeneratedMock.random(),
        borderColorToken: ColorTokenGeneratedMock.green(),
        imageTintColorToken: ColorTokenGeneratedMock.random(),
        imageBackgroundColorToken: ColorTokenGeneratedMock.random(),
        nameTextColorToken: ColorTokenGeneratedMock.random(),
        sizeTextColorToken: ColorTokenGeneratedMock.random(),
        errorTextColorToken: ColorTokenGeneratedMock.random()
    )
    let expectedContent = XXXPreviewContent(fileSize: "2 MB")
    let expectedFonts = XXXPreviewFonts(
        nameFontToken: TypographyFontTokenGeneratedMock.caption(),
        sizeFontToken: TypographyFontTokenGeneratedMock.callout(),
        errorFontToken: TypographyFontTokenGeneratedMock.footnote()
    )
    let expectedImage: XXXPreviewImage = .pdf
    let expectedLayout = XXXPreviewLayout(
        spacing: 8.0,
        horizontalPadding: 16.0,
        verticalPadding: 12.0
    )

    // MARK: - Use Case Mocks

    let getBorderUseCaseMock: XXXPreviewGetBorderUseCaseableGeneratedMock
    let getColorsUseCaseMock: XXXPreviewGetColorsUseCaseableGeneratedMock
    let getContentUseCaseMock: XXXPreviewGetContentUseCaseableGeneratedMock
    let getFontsUseCaseMock: XXXPreviewGetFontsUseCaseableGeneratedMock
    let getImageUseCaseMock: XXXPreviewGetImageUseCaseableGeneratedMock
    let getLayoutUseCaseMock: XXXPreviewGetLayoutUseCaseableGeneratedMock

    // MARK: - ViewModel

    let viewModel: XXXPreviewViewModel

    // MARK: - Initialization

    init() {
        let getBorderUseCaseMock = XXXPreviewGetBorderUseCaseableGeneratedMock()
        getBorderUseCaseMock.executeWithThemeAndFileReturnValue = self.expectedBorder

        let getColorsUseCaseMock = XXXPreviewGetColorsUseCaseableGeneratedMock()
        getColorsUseCaseMock.executeWithThemeAndFileAndIsPressedReturnValue = self.expectedColors

        let getContentUseCaseMock = XXXPreviewGetContentUseCaseableGeneratedMock()
        getContentUseCaseMock.executeWithFileReturnValue = self.expectedContent

        let getFontsUseCaseMock = XXXPreviewGetFontsUseCaseableGeneratedMock()
        getFontsUseCaseMock.executeWithThemeReturnValue = self.expectedFonts

        let getImageUseCaseMock = XXXPreviewGetImageUseCaseableGeneratedMock()
        getImageUseCaseMock.executeWithFileReturnValue = self.expectedImage

        let getLayoutUseCaseMock = XXXPreviewGetLayoutUseCaseableGeneratedMock()
        getLayoutUseCaseMock.executeWithThemeReturnValue = self.expectedLayout

        self.viewModel = XXXPreviewViewModel(
            getBorderUseCase: getBorderUseCaseMock,
            getColorsUseCase: getColorsUseCaseMock,
            getContentUseCase: getContentUseCaseMock,
            getFontsUseCase: getFontsUseCaseMock,
            getImageUseCase: getImageUseCaseMock,
            getLayoutUseCase: getLayoutUseCaseMock
        )

        self.getBorderUseCaseMock = getBorderUseCaseMock
        self.getColorsUseCaseMock = getColorsUseCaseMock
        self.getContentUseCaseMock = getContentUseCaseMock
        self.getFontsUseCaseMock = getFontsUseCaseMock
        self.getImageUseCaseMock = getImageUseCaseMock
        self.getLayoutUseCaseMock = getLayoutUseCaseMock
    }

    // MARK: - Methods

    func resetMockedData() {
        self.getBorderUseCaseMock.reset()
        self.getColorsUseCaseMock.reset()
        self.getContentUseCaseMock.reset()
        self.getFontsUseCaseMock.reset()
        self.getImageUseCaseMock.reset()
        self.getLayoutUseCaseMock.reset()
    }
}

// MARK: - Extension

private extension XXXPreviewViewModel {

    func setup(stub: Stub) {
        self.setup(
            theme: stub.givenTheme,
            file: stub.givenFile
        )
    }
}

// MARK: - Expectations

private func expectNotCalled(
    on stub: Stub,
    getBorderUseCase: Bool = false,
    getColorsUseCase: Bool = false,
    getContentUseCase: Bool = false,
    getFontsUseCase: Bool = false,
    getImageUseCase: Bool = false,
    getLayoutUseCase: Bool = false,
    sourceLocation: Testing.SourceLocation = #_sourceLocation
) {
    XXXPreviewGetBorderUseCaseableMockTest.expectCalled(
        stub.getBorderUseCaseMock,
        executeWithThemeAndFileCalled: !getBorderUseCase,
        sourceLocation: sourceLocation
    )

    XXXPreviewGetColorsUseCaseableMockTest.expectCalled(
        stub.getColorsUseCaseMock,
        executeWithThemeAndFileAndIsPressedCalled: !getColorsUseCase,
        sourceLocation: sourceLocation
    )

    XXXPreviewGetContentUseCaseableMockTest.expectCalled(
        stub.getContentUseCaseMock,
        executeWithFileCalled: !getContentUseCase,
        sourceLocation: sourceLocation
    )

    XXXPreviewGetFontsUseCaseableMockTest.expectCalled(
        stub.getFontsUseCaseMock,
        executeWithThemeCalled: !getFontsUseCase,
        sourceLocation: sourceLocation
    )

    XXXPreviewGetImageUseCaseableMockTest.expectCalled(
        stub.getImageUseCaseMock,
        executeWithFileCalled: !getImageUseCase,
        sourceLocation: sourceLocation
    )

    XXXPreviewGetLayoutUseCaseableMockTest.expectCalled(
        stub.getLayoutUseCaseMock,
        executeWithThemeCalled: !getLayoutUseCase,
        sourceLocation: sourceLocation
    )
}

private func expectEqualToExpected(
    on stub: Stub,
    otherBorder: XXXPreviewBorder? = nil,
    otherColors: XXXPreviewColors? = nil,
    otherContent: XXXPreviewContent? = nil,
    otherFonts: XXXPreviewFonts? = nil,
    otherImage: XXXPreviewImage? = nil,
    otherLayout: XXXPreviewLayout? = nil,
    sourceLocation: Testing.SourceLocation = #_sourceLocation
) {
    let viewModel = stub.viewModel

    let expectedBorder = otherBorder ?? stub.expectedBorder
    let expectedColors = otherColors ?? stub.expectedColors
    let expectedContent = otherContent ?? stub.expectedContent
    let expectedFonts = otherFonts ?? stub.expectedFonts
    let expectedImage = otherImage ?? stub.expectedImage
    let expectedLayout = otherLayout ?? stub.expectedLayout

    #expect(
        viewModel.border == expectedBorder,
        "Wrong border value",
        sourceLocation: sourceLocation
    )

    #expect(
        viewModel.colors == expectedColors,
        "Wrong colors value",
        sourceLocation: sourceLocation
    )

    #expect(
        viewModel.content == expectedContent,
        "Wrong content value",
        sourceLocation: sourceLocation
    )

    #expect(
        viewModel.fonts == expectedFonts,
        "Wrong fonts value",
        sourceLocation: sourceLocation
    )

    #expect(
        viewModel.image == expectedImage,
        "Wrong image value",
        sourceLocation: sourceLocation
    )

    #expect(
        viewModel.layout == expectedLayout,
        "Wrong layout value",
        sourceLocation: sourceLocation
    )
}
