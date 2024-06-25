//
//  SliderRadii+ExtensionTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 08/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

extension SliderRadii {
    static func mocked() -> SliderRadii {
        return .init(
            trackRadius: 0.123,
            indicatorRadius: 49.3
        )
    }
}
