//
//  TagContent.swift
//  SparkDemo
//
//  Created by robin.lemaire on 21/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

enum TagContent: CaseIterable {
    case icon
    case text
    case longText
    case attributedText
    case longAttributedText
    case iconAndText
    case iconAndLongText
    case iconAndAttributedText
    case iconAndLongAttributedText

    // MARK: - Properties

    var shouldShowIcon: Bool {
        switch self {
        case .icon, .iconAndText, .iconAndLongText, .iconAndAttributedText, .iconAndLongAttributedText:
            return true
        default:
            return false
        }
    }

    var text: String {
        switch self {
        case .attributedText, .iconAndAttributedText:
            return "This is a AT Tag"
        case .longText, .longAttributedText, .iconAndLongText, .iconAndLongAttributedText:
            return "This is a Tag with a very very very very very long long long long width"
        default:
            return "This is a Tag"
        }
    }

    var shouldShowText: Bool {
        switch self {
        case .text, .longText, .iconAndText, .iconAndLongText:
            return true
        default:
            return false
        }
    }

    var shouldShowAttributedText: Bool {
        switch self {
        case .attributedText, .longAttributedText, .iconAndAttributedText, .iconAndLongAttributedText:
            return true
        default:
            return false
        }
    }
}
