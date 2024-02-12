//
//  ProgressTrackerInteractionState.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 29.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

/// The possible interaction states of the progress tracker
public enum ProgressTrackerInteractionState: CaseIterable {
    case none
    case discrete
    case continuous
    case independent
}
