//
//  SwitchSubviewType.swift
//  SparkCore
//
//  Created by robin.lemaire on 11/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

enum SwitchSubviewType {
    case space
    case text
    case toggle

    // MARK: - Methods

    static func allCases(isLeftAlignment: Bool, showSpace: Bool) -> [Self] {
        var cases: [Self]

        // Left or right alignement ?
        if isLeftAlignment {
            cases = [.toggle, .text]
        } else {
            cases = [.text, .toggle]
        }

        // Add spaces ?
        if showSpace {
            cases.insert(.space, at: 1)
        }

        return cases
    }
}
