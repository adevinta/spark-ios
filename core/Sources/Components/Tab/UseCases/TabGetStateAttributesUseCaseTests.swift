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
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.sut = TabGetStateAttributesUseCase()
        self.theme = ThemeGeneratedMock.mocked()
        self.getIntentColorUseCase = TabGetIntentColorUseCasebleGeneratedMock()
    }
    
    // MARK: - Tests
    func test_selected() {
        let mockedColor = ColorTokenGeneratedMock(uiColor: .black)
        self.getIntentColorUseCase.executeWithColorsAndIntentReturnValue = mockedColor
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .primary,
            state: .selected,
            tabGetColorUseCase: self.getIntentColorUseCase
        )
        
        let expectedAttribute = TabStateAttributes(label: mockedColor, line: mockedColor, background: theme.colors.base.surface, opacity: nil, lineHeight: theme.border.width.medium)
        XCTAssertEqual(stateAttribute, expectedAttribute)
    }
    
    func test_enabled() {
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .primary,
            state: .enabled,
            tabGetColorUseCase: self.getIntentColorUseCase
        )
        
        let expectedAttribute = TabStateAttributes(
            label: theme.colors.base.outline,
            line: theme.colors.base.outline,
            background: theme.colors.base.surface,
            opacity: nil,
            lineHeight: theme.border.width.small
        )
        XCTAssertEqual(stateAttribute, expectedAttribute)
    }
    
    func test_pressed() {
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .primary,
            state: .pressed,
            tabGetColorUseCase: self.getIntentColorUseCase
        )
        
        let expectedAttribute = TabStateAttributes(
            label: theme.colors.base.outline,
            line: theme.colors.base.outline,
            background: theme.colors.base.surface,
            opacity: nil,
            lineHeight: theme.border.width.small
        )
        XCTAssertEqual(stateAttribute, expectedAttribute)
    }
    
    func test_disabled() {
        let stateAttribute = sut.execute(
            theme: self.theme,
            intent: .primary,
            state: .disabled,
            tabGetColorUseCase: self.getIntentColorUseCase
        )
        
        let expectedAttribute = TabStateAttributes(
            label: theme.colors.base.outline,
            line: theme.colors.base.outline,
            background: theme.colors.base.surface,
            opacity: theme.dims.dim3,
            lineHeight: theme.border.width.small
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
        return .init(isDisabled: true)
    }
}
