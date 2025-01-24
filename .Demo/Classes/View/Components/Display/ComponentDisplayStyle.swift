//
//  ComponentDisplayStyle.swift
//  SparkDemo
//
//  Created by robin.lemaire on 24/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import Foundation

enum ComponentDisplayStyle: String, CaseIterable {
    case alone
    case horizontalList
    case horizontalContent
    case verticalList

    // MARK: - Properties

    static var `default`: Self {
        .verticalList
    }

    var name: String {
        self.rawValue.addSpacesBeforeCapitalLetter.capitalized
    }

    var systemImage: String {
        switch self {
        case .alone: "square"
        case .horizontalList: "circle.grid.2x1"
        case .horizontalContent: "align.vertical.center.fill"
        case .verticalList: "list.bullet"
        }
    }

    var hasBottomSpace: Bool {
        switch self {
        case .alone, .horizontalList, .horizontalContent: true
        default: false
        }
    }
}

// MARK: - Extension

extension Array where Element == ComponentDisplayStyle {

    func hasAddButton(currentStyle: Element) -> Bool {
        let containsList = self.contains(where: { $0 == .horizontalList || $0 == .verticalList })

        return containsList && currentStyle != .alone
    }
}
