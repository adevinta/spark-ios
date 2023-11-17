//
//  CheckboxGetSpacingUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class CheckboxGetSpacingUseCaseTests: XCTestCase {

    var sut: CheckboxGetSpacingUseCase!
    var layoutSpacing: LayoutSpacingGeneratedMock!
    
    override func setUp()  {
        self.layoutSpacing = LayoutSpacingGeneratedMock.mocked()
        self.sut = CheckboxGetSpacingUseCase()
    }
    
    func test_left_alignment_spacing() {
        let spacing = sut.execute(layoutSpacing: self.layoutSpacing, alignment: .left)
        
        XCTAssertEqual(spacing, self.layoutSpacing.medium)
    }

    func test_right_alignment_spacing() {
        let spacing = sut.execute(layoutSpacing: self.layoutSpacing, alignment: .right)
        
        XCTAssertEqual(spacing, self.layoutSpacing.xxxLarge)
    }
}
