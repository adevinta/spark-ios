//
//  ProgressTrackerGetVariantColorsUseCaseable.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ProgressTrackerGetVariantColorsUseCaseable {
    func execute(colors: Colors,
                 intent: ProgressTrackerIntent,
                 state: ProgressTrackerState
    ) -> ProgressTrackerColors
}

