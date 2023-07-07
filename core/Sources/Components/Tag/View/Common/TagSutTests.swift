//
//  TagSutTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 05/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

struct TagSutTests {

    // MARK: - Properties

    let intent: TagIntent
    let variant: TagVariant

    // MARK: - Getter

    func testName(on function: String = #function) -> String {
        return "\(function)-\(self.intent)-\(self.variant)"
    }

    // MARK: - Cases

    static var allCases: [Self] {
        return Self.allVariantCases(for: .alert) +
        Self.allVariantCases(for: .danger) +
        Self.allVariantCases(for: .info) +
        Self.allVariantCases(for: .neutral) +
        Self.allVariantCases(for: .primary) +
        Self.allVariantCases(for: .secondary) +
        Self.allVariantCases(for: .success)
    }

    private static func allVariantCases(for intent: TagIntent) -> [Self] {
        return [
            .init(intent: intent, variant: .filled),
            .init(intent: intent, variant: .outlined),
            .init(intent: intent, variant: .tinted)
        ]
    }
}
