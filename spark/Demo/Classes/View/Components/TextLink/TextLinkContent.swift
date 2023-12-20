//
//  TextLinkContent.swift
//  SparkDemo
//
//  Created by robin.lemaire on 07/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

enum TextLinkContent: CaseIterable {
    case text
    case paragraph
    case imageAndText
    case imageAndParagraph

    // MARK: - Properties

    var containsText: Bool {
        switch self {
        case .text, .imageAndText:
            return true
        default:
            return false
        }
    }

    var containsImage: Bool {
        switch self {
        case .imageAndText, .imageAndParagraph:
            return true
        default:
            return false
        }
    }
}
