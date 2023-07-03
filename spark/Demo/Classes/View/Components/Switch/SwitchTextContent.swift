//
//  SwitchContent.swift
//  SparkDemo
//
//  Created by robin.lemaire on 29/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

enum SwitchTextContentDefault: CaseIterable {
    case text
    case attributedText
    case multilineText

    // MARK: - Properties

    var shouldShowText: Bool {
        switch self {
        case .text, .multilineText:
            return true
        default:
            return false
        }
    }

    var shouldShowShowAttributeText: Bool {
        switch self {
        case .attributedText:
            return true
        default:
            return false
        }
    }

    var isMultilineText: Bool {
        switch self {
        case .multilineText:
            return true
        default:
            return false
        }
    }
}
