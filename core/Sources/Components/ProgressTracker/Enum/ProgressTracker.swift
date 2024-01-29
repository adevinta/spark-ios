//
//  ProgressTracker.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 29.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

public enum ProgressTracker {
    public enum Orientation {
        case horizontal
        case vertical
    }

    public enum Variant: CaseIterable {
        case outlined
        case tinted
    }

    public enum Size: CGFloat, CaseIterable {
        case small = 16
        case medium = 24
        case large = 32
    }

    public enum Intent: CaseIterable {
        case accent
        case alert
        case basic
        case danger
        case info
        case main
        case neutral
        case success
        case support
    }

    public enum InteractionState: CaseIterable {
        case none
        case discrete
        case continuous
    }
}
