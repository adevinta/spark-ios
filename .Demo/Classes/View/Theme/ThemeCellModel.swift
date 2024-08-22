//
//  ThemeSwitchView.swift
//  SparkDemo
//
//  Created by janniklas.freundt.ext on 02.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore

struct ThemeCellModel: Equatable, Hashable {

    // MARK: - Properties
    let title: String
    let theme: Theme

    // MARK: - Public Properties
    static var themes: [ThemeCellModel] = [
        .init(title: "Spark", theme: SparkTheme.shared),
        .init(title: "Spark Pro", theme: SparkProTheme.shared),
        .init(title: "Spark Sky", theme: SkyTheme())
    ]

    // MARK: - Initialize
    init(title: String, theme: Theme) {
        self.title = title
        self.theme = theme
    }

    // MARK: - Methods
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.title)
    }

    static func == (lhs: ThemeCellModel, rhs: ThemeCellModel) -> Bool {
        lhs.title == rhs.title
    }
}
