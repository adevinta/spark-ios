//
//  XXXSizesTests.swift
//  SparkComponentXXXTests
//
//  Created by robin.lemaire on 23/02/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import Testing
@testable import SparkComponentXXX

@Suite("XXX Sizes Tests")
struct XXXSizesTests {

    // MARK: - Tests

    @Test("Default initialization")
    func defaultInitialization() {
        // GIVEN / WHEN
        let sizes = XXXSizes()

        // THEN
        #expect(sizes.height == .zero)
        #expect(sizes.iconHeight == .zero)
    }

    @Test("Equality when same values")
    func equalityWhenSameValues() {
        // GIVEN / WHEN
        let sizes1 = XXXSizes(height: 48, iconHeight: 16)
        let sizes2 = XXXSizes(height: 48, iconHeight: 16)

        // THEN
        #expect(sizes1 == sizes2)
    }

    @Test("Inequality when different height")
    func inequalityWhenDifferentHeight() {
        // GIVEN / WHEN
        let sizes1 = XXXSizes(height: 48, iconHeight: 16)
        let sizes2 = XXXSizes(height: 56, iconHeight: 16)

        // THEN
        #expect(sizes1 != sizes2)
    }

    @Test("Inequality when different icon height")
    func inequalityWhenDifferentIconHeight() {
        // GIVEN / WHEN
        let sizes1 = XXXSizes(height: 48, iconHeight: 16)
        let sizes2 = XXXSizes(height: 48, iconHeight: 20)

        // THEN
        #expect(sizes1 != sizes2)
    }
}
