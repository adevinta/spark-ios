//
//  ButtonGetVariantUseCaseable.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

// sourcery: AutoMockable, AutoMockTest
protocol ButtonGetVariantUseCaseable {
    // sourcery: colors = "Identical", dims = "Identical"
    func execute(intent: ButtonIntent, colors: Colors, dims: Dims) -> ButtonColors
}
