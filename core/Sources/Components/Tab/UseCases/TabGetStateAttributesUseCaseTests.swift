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
            tabSize: .md,
            hasTitle: true
        )
        let selectedColors = TabItemColors(
            label: mockedColor,
            line: mockedColor,
            background: self.theme.colors.base.surface
        )
        let expectedHeights = TabItemHeights(
            separatorLineHeight: self.theme.border.width.medium,
            itemHeight: 40,
            iconHeight: 16
        )

        let expectedAttribute = TabStateAttributes(
            spacings: self.spacings,
            colors: selectedColors,
            heights: expectedHeights,
            font: self.theme.typography.body1
        )
        XCTAssertEqual(stateAttribute, expectedAttribute)
    }
    
    func test_enabled() {
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .main,
            state: .enabled,
            tabSize: .md,
            hasTitle: true
        )

        let expectedHeights = TabItemHeights(
            separatorLineHeight: self.theme.border.width.small,
            itemHeight: 40,
            iconHeight: 16
        )

        let expectedAttribute = TabStateAttributes(
            spacings: self.spacings,
            colors: self.colors,
            heights: expectedHeights,
            font: self.theme.typography.body1
        )
        XCTAssertEqual(stateAttribute, expectedAttribute)
    }
    
    func test_pressed() {
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .main,
            state: .pressed,
            tabSize: .sm,
            hasTitle: true
        )

        self.colors = TabItemColors(
            label: self.theme.colors.base.onSurface.opacity(self.theme.dims.dim1),
            line: self.theme.colors.base.outline,
            background: self.theme.colors.states.surfacePressed
        )

        let expectedHeights = TabItemHeights(
            separatorLineHeight: self.theme.border.width.small,
            itemHeight: 36,
            iconHeight: 14
        )

        let expectedAttribute = TabStateAttributes(
            spacings: self.spacings,
            colors: self.colors,
            heights: expectedHeights,
            font: self.theme.typography.body1
        )
        XCTAssertEqual(stateAttribute, expectedAttribute)
    }
    
    func test_disabled() {
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .main,
            state: .disabled,
            tabSize: .xs,
            hasTitle: true
        )


        let expectedHeights = TabItemHeights(
            separatorLineHeight: self.theme.border.width.small,
            itemHeight: 32,
            iconHeight: 12
        )

        let expectedAttribute = TabStateAttributes(
            spacings: self.spacings,
            colors: self.colors.update(\.opacity, value: theme.dims.dim3),
            heights: expectedHeights,
            font: self.theme.typography.body1
        )
        XCTAssertEqual(stateAttribute, expectedAttribute)
    }

    func test_no_title() {
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .main,
            state: .disabled,
            tabSize: .xs,
            hasTitle: false
        )


        let expectedHeights = TabItemHeights(
            separatorLineHeight: self.theme.border.width.small,
            itemHeight: 40,
            iconHeight: 16
        )

        let expectedAttribute = TabStateAttributes(
            spacings: self.spacings,
            colors: self.colors.update(\.opacity, value: theme.dims.dim3),
            heights: expectedHeights,
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
