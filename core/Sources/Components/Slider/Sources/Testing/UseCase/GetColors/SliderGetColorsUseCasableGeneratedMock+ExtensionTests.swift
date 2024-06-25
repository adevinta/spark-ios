//
//  SliderGetColorsUseCasableGeneratedMock+ExtensionTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 06/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

extension SliderGetColorsUseCasableGeneratedMock {
    static func mocked(returnedColors colors: SliderColors) -> SliderGetColorsUseCasableGeneratedMock {
        let mock = SliderGetColorsUseCasableGeneratedMock()
        mock._executeWithThemeAndIntent = { _, _ in
            return colors
        }
        return mock
    }
}
