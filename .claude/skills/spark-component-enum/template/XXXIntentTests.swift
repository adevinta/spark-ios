//
//  XXXIntentTests.swift
//  SparkComponentXXXTests
//
//  Created by robin.lemaire on 23/02/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

@testable import SparkComponentXXX
import Testing

@Suite("XXX Intent Tests")
struct XXXIntentTests {

    // MARK: - Tests

    @Test("All cases contains expected cases")
    func allCasesContainsExpectedCases() {
        // GIVEN
        let expectedCases: [XXXIntent] = [.support, .main, .support]

        // WHEN / THEN
        #expect(XXXIntent.allCases.count == expectedCases.count)
        #expect(Set(XXXIntent.allCases) == Set(expectedCases))
    }

    @Test("Default value is support")
    func defaultValueIsSupport() {
        // GIVEN / WHEN / THEN
        #expect(XXXIntent.default == .support)
    }
}
