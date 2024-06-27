//
//  ButtonContentDefault.swift
//  SparkDemo
//
//  Created by robin.lemaire on 28/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

enum ButtonContentDefault: CaseIterable {
    case image
    case text
    case attributedText
    case imageAndText
    case imageAndAttributedText
    case none

    // MARK: - Static Properties

    static var allCasesExceptNone: [Self] {
        var test = self.allCases
        test.removeAll { $0 == .none }
        return test
    }

    // MARK: - Properties

    var containsImage: Bool {
        switch self {
        case .image, .imageAndText, .imageAndAttributedText:
            return true
        default:
            return false
        }
    }

    var containsText: Bool {
        switch self {
        case .text, .imageAndText:
            return true
        default:
            return false
        }
    }

    var containsAttributedText: Bool {
        switch self {
        case .attributedText, .imageAndAttributedText:
            return true
        default:
            return false
        }
    }
}
