//
//  TextFieldGetColorsUseCasableGeneratedMock+ExtensionTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 01/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

extension TextFieldGetColorsUseCasableGeneratedMock {
    static func mocked(returnedColors: TextFieldColors) -> TextFieldGetColorsUseCasableGeneratedMock {
        let mock = TextFieldGetColorsUseCasableGeneratedMock()
        mock.executeWithThemeAndIntentAndIsFocusedAndIsEnabledAndIsUserInteractionEnabledReturnValue = returnedColors
        return mock
    }
}
