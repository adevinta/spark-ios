//
//  DimsGeneratedMock+ExtensionTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension DimsGeneratedMock {

    // MARK: - Methods

    static func mocked() -> DimsGeneratedMock {
        let mock = DimsGeneratedMock()
        mock.dim1 = 0.2
        mock.dim2 = 0.3
        mock.dim3 = 0.4
        mock.dim4 = 0.5
        mock.dim5 = 0.6

        return mock
    }
}
