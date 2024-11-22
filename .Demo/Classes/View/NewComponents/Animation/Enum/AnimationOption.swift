//
//  AnimationOption.swift
//  SparkDemo
//
//  Created by robin.lemaire on 20/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SparkCore

enum AnimationOption: CaseIterable, Hashable {
    case once
    case limited
    case unlimited

    // MARK: - Properties

    var `repeat`: SparkAnimationRepeat {
        return switch self {
        case .once: .once
        case .limited: .limited(3)
        case .unlimited: .unlimited
        }
    }

    var title: String {
        switch self {
        case .once: "Played once"
        case .limited: "Played three times"
        case .unlimited: "Played indefinitely"
        }
    }

    var hasBottomSeparationLine: Bool {
        switch self {
        case .once, .limited: true
        case .unlimited: false
        }
    }

    var canBeReplayed: Bool {
        switch self {
        case .once, .limited: true
        case .unlimited: false
        }
    }

    var iconIntent: IconIntent {
        switch self {
        case .once: .main
        case .limited: .success
        case .unlimited: .error
        }
    }

    var buttonIntent: ButtonIntent {
        switch self {
        case .once: .main
        case .limited: .success
        case .unlimited: .danger
        }
    }
}
