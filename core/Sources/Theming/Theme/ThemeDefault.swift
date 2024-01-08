//
//  ThemeDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ThemeDefault: Theme {

    // MARK: - Properties

    public let border: any Border
    public let colors: any Colors
    public let elevation: any Elevation
    public let layout: any Layout
    public let typography: any Typography
    public let dims: any Dims

    // MARK: - Initialization

    public init(border: some Border,
                colors: some Colors,
                elevation: some Elevation,
                layout: some Layout,
                typography: some Typography,
                dims: some Dims) {
        self.border = border
        self.colors = colors
        self.elevation = elevation
        self.layout = layout
        self.typography = typography
        self.dims = dims
    }
}
