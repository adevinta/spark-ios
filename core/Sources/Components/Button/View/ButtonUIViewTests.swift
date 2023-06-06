//
//  ButtonUIViewTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 11.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import Spark
@testable import SparkCore

final class ButtonUIViewTests: UIKitComponentTestCase {

    // MARK: - Properties
    let theme: Theme = SparkTheme.shared

    let intents = [ButtonIntentColor.alert, .danger, .success, .neutral, .secondary, .surface, .primary]
    let variants = [ButtonVariant.filled, .outlined, .tinted, .ghost, .contrast]

    // MARK: -  Tests

    func test_button() throws {
        for variant in variants {
            for intent in intents {
                let button = ButtonUIView(
                    theme: theme,
                    text: "Hello world",
                    state: .enabled,
                    variant: variant,
                    intentColor: intent
                )

                let identifier = "\(variant.identifier)-\(intent.identifier)"
                assertSnapshotInDarkAndLight(matching: button, named: identifier)
            }
        }
    }

    func test_button_with_icon() throws {
        for variant in variants {
            for intent in intents {
                let button = ButtonUIView(
                    theme: theme,
                    text: "Hello world",
                    icon: .leading(icon: UIImage(systemName: "trash")!),
                    state: .enabled,
                    variant: variant,
                    intentColor: intent
                )

                let identifier = "\(variant.identifier)-\(intent.identifier)"
                assertSnapshotInDarkAndLight(matching: button, named: identifier)
            }
        }
    }
}

// MARK: - Private extension

private extension ButtonIntentColor {
    var identifier: String {
        let returnValue: String
        switch self {
        case .alert:
            returnValue = "alert"
        case .danger:
            returnValue = "danger"
        case .neutral:
            returnValue = "neutral"
        case .primary:
            returnValue = "primary"
        case .secondary:
            returnValue = "secondary"
        case .success:
            returnValue = "success"
        case .surface:
            returnValue = "surface"
        }
        return returnValue
    }
}

private extension ButtonVariant {
    var identifier: String {
        let returnValue: String
        switch self {
        case .filled:
            returnValue = "filled"
        case .outlined:
            returnValue = "outlined"
        case .tinted:
            returnValue = "tinted"
        case .ghost:
            returnValue = "ghost"
        case .contrast:
            returnValue = "contrast"
        }
        return returnValue
    }
}
