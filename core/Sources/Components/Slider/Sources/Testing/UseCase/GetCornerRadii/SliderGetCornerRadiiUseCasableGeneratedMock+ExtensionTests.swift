//
//  SliderGetCornerRadiiUseCasableGeneratedMock+ExtensionTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 06/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

extension SliderGetCornerRadiiUseCasableGeneratedMock {
    static func mocked(expectedRadii radii: SliderRadii) -> SliderGetCornerRadiiUseCasableGeneratedMock {
        let mock = SliderGetCornerRadiiUseCasableGeneratedMock()
        mock._executeWithThemeAndShape = { _, _ in
            return radii
        }
        return mock
    }
}
