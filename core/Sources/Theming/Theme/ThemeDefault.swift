//
//  ThemeDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ThemeDefault: Theme {

    // MARK: - Properties

    public let border: Border
    public let colors: Colors
    public let iconography: Iconography
    public let layout: Layout
    public let typography: Typography
    public let dim: Dim

    // MARK: - Initialization

    public init(border: Border,
                colors: Colors,
                iconography: Iconography,
                layout: Layout,
                typography: Typography,
                dim: Dim) {
        self.border = border
        self.colors = colors
        self.iconography = iconography
        self.layout = layout
        self.typography = typography
        self.dim = dim
    }
}
