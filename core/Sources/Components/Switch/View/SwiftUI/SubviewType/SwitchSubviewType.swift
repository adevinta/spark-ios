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

    // MARK: - Properties

    static var leftAlignmentCases: [Self] {
        return [.toggle, .space, .text]
    }

    static var rightAlignmentCases: [Self] {
        return [.text, .space, .toggle]
    }
}
