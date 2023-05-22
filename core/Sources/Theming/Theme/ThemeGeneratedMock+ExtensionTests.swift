//
//  ThemeGeneratedMock+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension ThemeGeneratedMock {
    static func mocked() -> ThemeGeneratedMock {
        let theme = ThemeGeneratedMock()

        theme.colors =  ColorsGeneratedMock.mocked()
        theme.layout = LayoutGeneratedMock.mocked()
        theme.typography = TypographyGeneratedMock.mocked()

        theme.dims = DimsGeneratedMock.mocked()
        theme.border = BorderGeneratedMock.mocked()

        return theme
    }
}
