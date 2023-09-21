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
        return TagIntent.allCases.flatMap { intent in
            TagVariant.allCases.map { variant in
                (intent, variant)
            }
        }
        .map(Self.init)
    }
}
