//
//  ComponentVersion.swift
//  SparkDemo
//
//  Created by robin.lemaire on 31/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

enum ComponentVersion: CaseIterable {
    case swiftUI
    case uiKit

    // MARK: - Properties

    var name: String {
        switch self {
        case .swiftUI:
            return "SwiftUI"
        case .uiKit:
            return "UIKit"
        }
    }
}
