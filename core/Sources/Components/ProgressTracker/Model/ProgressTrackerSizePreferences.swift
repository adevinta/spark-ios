//
//  ProgressTrackerSizePreferences.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 20.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

/// Preference keys used by the SwiftUI layout of the progress tracker.
struct ProgressTrackerSizePreferences: PreferenceKey {
    typealias Value = [Int: CGRect]

    static var defaultValue = [Int: CGRect]()

    static func reduce(
        value: inout [Int: CGRect],
        nextValue: () -> [Int: CGRect]
    ) {
        value.merge(nextValue()) { $1 }
    }
}

