//
//  ComponentSnapshotTestMode.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 06/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

enum ComponentSnapshotTestMode: String, CaseIterable {
    case dark
    case light

    // MARK: - Properties

    private var interfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        }
    }

    var traitCollection: UITraitCollection {
        return .init(
            traitsFrom: [
                .init(userInterfaceStyle: self.interfaceStyle)
            ]
        )
    }

    var suffix: String {
        return self.rawValue
    }
}
