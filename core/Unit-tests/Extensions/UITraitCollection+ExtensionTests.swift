//
//  UITraitCollection+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 05/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

extension UITraitCollection {

    // MARK: - Properties

    static let darkMode: UITraitCollection = .init(
        traitsFrom: [
            .init(userInterfaceStyle: .dark)
        ]
    )
}
