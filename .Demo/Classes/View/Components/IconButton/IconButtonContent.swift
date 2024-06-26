//
//  IconButtonContent.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

enum IconButtonContentDefault: CaseIterable {
    case image
    case none

    // MARK: - Static Properties

    static var allCasesExceptNone: [Self] {
        var test = self.allCases
        test.removeAll { $0 == .none }
        return test
    }
}
