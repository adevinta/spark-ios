//
//  ComponentsConfigurationItemUIViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 25/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import UIKit

final class ComponentsConfigurationItemUIViewModel {

    // MARK: - Properties

    var identifier: String {
        return self.name.lowercased() + "Item"
    }
    let name: String
    let type: ComponentsConfigurationItemUIType
    let target: (source: Any, action: Selector)

    // MARK: - Published Properties

    @Published var color: UIColor = .blue
    @Published var labelText: String = ""
    @Published var buttonTitle: String?
    @Published var isOn: Bool?
    @Published var theme: Theme {
        didSet {
            self.color = self.theme.colors.main.main.uiColor
        }
    }

    // MARK: - Initialization

    init(
        name: String,
        type: ComponentsConfigurationItemUIType,
        target: (source: Any, action: Selector)
    ) {
        self.name = name
        self.type = type
        self.target = target
        self.theme = SparkTheme.shared
        self.color = self.theme.colors.main.main.uiColor
    }
}
