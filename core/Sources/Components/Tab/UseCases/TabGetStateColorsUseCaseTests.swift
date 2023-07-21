//
//  TabGetStateColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by alican.aycil on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class TabGetStateColorsUseCaseTests: TestCase {
    
    // MARK: - Private properties
    private var sut: TabGetStateColorsUseCase!
    private var theme: ThemeGeneratedMock!
    private var getIntentColorUseCase: TabGetIntentColorUseCasebleGeneratedMock!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.sut = TabGetStateColorsUseCase()
        self.theme = ThemeGeneratedMock.mocked()
        self.getIntentColorUseCase = TabGetIntentColorUseCasebleGeneratedMock()
    }
    
    // MARK: - Tests
    func test_enabled() {
        let mockedColor = ColorTokenGeneratedMock(uiColor: .black)
        self.getIntentColorUseCase.executeWithColorsAndIntentReturnValue = mockedColor
        let stateColors = sut.execute(theme: self.theme, intent: TabIntent.primary, state: .selected, tabGetColorUseCase: self.getIntentColorUseCase)
        
        let expectedColor = TabStateColors(label: mockedColor, line: mockedColor, background: theme.colors.base.surface, opacity: nil)
        XCTAssertEqual(stateColors, expectedColor)
    }
}
