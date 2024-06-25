//
//  TextFieldSpacings+ExtensionTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 01/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

extension TextFieldSpacings {
    static func mocked(left: CGFloat, content: CGFloat, right: CGFloat) -> TextFieldSpacings {
        return .init(left: left, content: content, right: right)
    }
}
