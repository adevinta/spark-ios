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
        mock.spacing = LayoutSpacingGeneratedMock.mocked()

        return mock
    }
}

extension LayoutSpacingGeneratedMock {

    // MARK: - Methods

    static func mocked() -> LayoutSpacingGeneratedMock {
        let mock = LayoutSpacingGeneratedMock()
        mock.none = 1
        mock.small = 3
        mock.medium = 5
        mock.large = 7
        mock.xLarge = 9
        mock.xxLarge = 11
        mock.xxxLarge = 13

        return mock
    }
}
