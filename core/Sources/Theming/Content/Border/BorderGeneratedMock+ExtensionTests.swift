//
//  BorderGeneratedMock+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension BorderGeneratedMock {
    static func mocked() -> BorderGeneratedMock {
        let border = BorderGeneratedMock()

        let radius = BorderRadiusGeneratedMock()
        radius.small = 4
        radius.medium = 8
        radius.large = 16
        radius.xLarge = 24

        border.radius = radius

        let width = BorderWidthGeneratedMock()
        width.small = 1
        width.medium = 2

        border.width = width

        return border
    }
}
