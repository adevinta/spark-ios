//
//  TabGetStateAttributesUseCaseTests.swift
//  SparkCoreTests
//
//  Created by alican.aycil on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class TabGetStateAttributesUseCaseTests: TestCase {
    
    // MARK: - Private properties
    private var sut: TabGetStateAttributesUseCase!
    private var theme: ThemeGeneratedMock!
    private var getIntentColorUseCase: TabGetIntentColorUseCasebleGeneratedMock!
    private var getFontUseCase: TabGetFontUseCaseableGeneratedMock!
    private var spacings: TabItemSpacings!
    private var colors: TabItemColors!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.theme = ThemeGeneratedMock.mocked()
        self.getIntentColorUseCase = TabGetIntentColorUseCasebleGeneratedMock()
        self.getFontUseCase = TabGetFontUseCaseableGeneratedMock()

        self.sut = TabGetStateAttributesUseCase(
            getIntentColorUseCase: getIntentColorUseCase,
            getTabFontUseCase: getFontUseCase
        )
        self.spacings = TabItemSpacings(
            verticalEdge: self.theme.layout.spacing.medium,
            horizontalEdge: self.theme.layout.spacing.large,
            content: self.theme.layout.spacing.medium
        )
        self.colors = TabItemColors(
            label: self.theme.colors.base.onSurface,
            line: self.theme.colors.base.outline,
            background: self.theme.colors.base.surface
        )

        self.getFontUseCase.executeWithTypographyAndSizeReturnValue = self.theme.typography.body2
    }
    
    // MARK: - Tests
    func test_selected() {
        let mockedColor = ColorTokenGeneratedMock(uiColor: .black)
        self.getIntentColorUseCase.executeWithColorsAndIntentReturnValue = mockedColor
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .main,
            state: .selected,
            size: .md
        )
        let selectedColors = TabItemColors(
            label: mockedColor,
            line: mockedColor,
            background: self.theme.colors.base.surface
        )
        let expectedAttribute = TabStateAttributes(
            spacings: self.spacings,
            colors: selectedColors,
            opacity: 1,
            separatorLineHeight: self.theme.border.width.medium,
            font: self.theme.typography.body1
        )
        XCTAssertEqual(stateAttribute, expectedAttribute)
    }
    
    func test_enabled() {
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .main,
            state: .enabled,
            size: .md
        )
        let expectedAttribute = TabStateAttributes(
            spacings: self.spacings,
            colors: self.colors,
            opacity: 1,
            separatorLineHeight: self.theme.border.width.small,
            font: self.theme.typography.body1
        )
        XCTAssertEqual(stateAttribute, expectedAttribute)
    }
    
    func test_pressed() {
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .main,
            state: .pressed,
            size: .sm
        )

        let expectedAttribute = TabStateAttributes(
            spacings: self.spacings,
            colors: self.colors,
            opacity: 1,
            separatorLineHeight: self.theme.border.width.small,
            font: self.theme.typography.body1
        )
        XCTAssertEqual(stateAttribute, expectedAttribute)
    }
    
    func test_disabled() {
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .main,
            state: .disabled,
            size: .xs
        )
        let expectedAttribute = TabStateAttributes(
            spacings: self.spacings,
            colors: self.colors,
            opacity: theme.dims.dim3,
            separatorLineHeight: self.theme.border.width.small,
            font: self.theme.typography.body1
        )
        XCTAssertEqual(stateAttribute, expectedAttribute)
    }
}

private extension TabState {
    static var enabled: TabState {
        return .init()
    }
    
    static var selected: TabState {
        return .init(isSelected: true)
    }
    
    static var pressed: TabState {
        return .init(isPressed: true)
    }
    
    static var disabled: TabState {
        return .init(isEnabled: false)
    }
}
