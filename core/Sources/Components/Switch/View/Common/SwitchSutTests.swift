//
//  SwitchSutTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 14/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import UIKit
import SwiftUI
import XCTest

struct SwitchSutTests {

    // MARK: - Properties

    let intentColor: SwitchIntentColor
    let isOn: Bool
    let alignment: SwitchAlignment
    let isEnabled: Bool
    let variant: SwitchVariant?
    private let isMultilineText: Bool
    var text: String {
        return self.isMultilineText ? "Multiline switch.\nMore text.\nAnd more text." : "Text"
    }

    // MARK: - Getter

    func testName(on function: String = #function) -> String {
        return [
            function,
            "\(self.intentColor)",
            self.isOn ? "isOn" : "isOff",
            "\(self.alignment)" + "Aligment",
            self.isEnabled ? "isEnabled" : "isDisabled",
            self.variant != nil ? "withVariant" : "withoutVariant",
            self.isMultilineText ? "isMultilineText" : "isSinglelineText",
        ].joined(separator: "-")
    }

    // MARK: - Cases

    static func allCases(isSwiftUIComponent: Bool) throws -> [Self] {
        let intentColorPossibilities: [SwitchIntentColor] = [.alert, .error, .info, .neutral, .primary, .secondary, .success]
        let isOnPossibilities = [true, false]
        let alignmentPossibilities: [SwitchAlignment] = [.left, .right]
        let isEnabledPossibilities = [true, false]
        let variantPossibilities: [SwitchVariant?] = try [nil, .init(isSwiftUIComponent: isSwiftUIComponent)]
        let isMultilineTextPossibilities = [true, false]

        return intentColorPossibilities.flatMap { intentColor in
            isOnPossibilities.flatMap { isOn in
                alignmentPossibilities.flatMap { alignment in
                    isEnabledPossibilities.flatMap { isEnabled in
                        variantPossibilities.flatMap { variant in
                            isMultilineTextPossibilities.map { isMultilineText -> SwitchSutTests in
                                    .init(
                                        intentColor: intentColor,
                                        isOn: isOn,
                                        alignment: alignment,
                                        isEnabled: isEnabled,
                                        variant: variant,
                                        isMultilineText: isMultilineText
                                    )
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Private Extensions

private extension SwitchVariant {

    init(isSwiftUIComponent: Bool) throws {
        self = try isSwiftUIComponent ? Image.variant : UIImage.variant
    }
}

private extension Image {

    static let variant: SwitchVariant = .init(
        onImage: Image("switchOn"),
        offImage: Image("switchOff")
    )
}

private extension UIImage {

    static var variant: SwitchVariant {
        get throws {
            .init(
                onImage: IconographyTests.shared.switchOn,
                offImage: IconographyTests.shared.switchOff
            )
        }
    }
}
