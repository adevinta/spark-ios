//
//  Color+ExtensionTests.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SwiftUI

extension ColorToken where Self == ColorTokenGeneratedMock {

    // MARK: - Methods

    static func mock(_ color: Color) -> Self {
        let mock = ColorTokenGeneratedMock()
        mock.color = color
        return mock
    }
}
