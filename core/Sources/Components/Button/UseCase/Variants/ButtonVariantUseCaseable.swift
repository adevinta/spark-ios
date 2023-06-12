//
//  ButtonVariantUseCaseable.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

// sourcery: AutoMockable
protocol ButtonVariantUseCaseable {
    func colors(for intentColor: ButtonIntentColor, on colors: Colors, dims: Dims) -> ButtonColorables
}
