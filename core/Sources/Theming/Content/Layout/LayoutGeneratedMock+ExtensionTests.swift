//
//  LayoutGeneratedMock.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension LayoutGeneratedMock {

    // MARK: - Methods

    static func mocked() -> LayoutGeneratedMock {
        let mock = LayoutGeneratedMock()
        let spacing = LayoutSpacingGeneratedMock()
        spacing.none = 1
        spacing.small = 3
        spacing.medium = 5
        spacing.large = 7
        spacing.xLarge = 9
        spacing.xxLarge = 11
        spacing.xxxLarge = 13
        mock.spacing = spacing

        return mock
    }
}
