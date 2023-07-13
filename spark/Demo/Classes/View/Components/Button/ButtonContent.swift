//
//  ButtonContentDefault.swift
//  SparkDemo
//
//  Created by robin.lemaire on 28/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

enum ButtonContentDefault: CaseIterable {
    case icon
    case text
    case attributedText
    case iconAndText
    case iconAndAttributedText

    // MARK: - Properties

    var shouldShowIcon: Bool {
        switch self {
        case .icon, .iconAndText, .iconAndAttributedText:
            return true
        default:
            return false
        }
    }

    var shouldShowText: Bool {
        switch self {
        case .text, .iconAndText:
            return true
        default:
            return false
        }
    }

    var shouldShowAttributeText: Bool {
        switch self {
        case .attributedText, .iconAndAttributedText:
            return true
        default:
            return false
        }
    }
}
