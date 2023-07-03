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
    let images: SwitchImagesEither?
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
            self.images != nil ? "withImages" : "withoutImages",
            self.isMultilineText ? "isMultilineText" : "isSinglelineText",
        ].joined(separator: "-")
    }

    // MARK: - Cases

    /// Test all colors for all intent, isOn and IsEnabled cases
    static func allColorsCases(isSwiftUIComponent: Bool) throws -> [Self] {
        let intentColorPossibilities = SwitchIntentColor.allCases
        let isOnPossibilities = Bool.allCases
        let isEnabledPossibilities = Bool.allCases

        return intentColorPossibilities.flatMap { intentColor in
            isOnPossibilities.flatMap { isOn in
                isEnabledPossibilities.map { isEnabled -> SwitchSutTests in
                        .init(
                            intentColor: intentColor,
                            isOn: isOn,
                            alignment: .left,
                            isEnabled: isEnabled,
                            images: nil,
                            isMultilineText: false
                        )
                }
            }
        }
    }

    /// Test all contents for all images cases
    static func allContentsCases(isSwiftUIComponent: Bool) throws -> [Self] {
        let imagesPossibilities: [SwitchImagesEither?] = try [nil, isSwiftUIComponent ? .right(Image.images) : .left(UIImage.images)]

        return imagesPossibilities.map { images -> SwitchSutTests in
                .init(
                    intentColor: .primary,
                    isOn: true,
                    alignment: .left,
                    isEnabled: true,
                    images: images,
                    isMultilineText: false
                )
        }
    }

    /// Test all positions for all alignment cases
    static func allPositionsCases(isSwiftUIComponent: Bool) throws -> [Self] {
        let alignmentPossibilities = SwitchAlignment.allCases
        let isMultilineTextPossibilities = Bool.allCases

        return alignmentPossibilities.flatMap { alignment in
            isMultilineTextPossibilities.map { isMultilineText -> SwitchSutTests in
                    .init(
                        intentColor: .primary,
                        isOn: true,
                        alignment: alignment,
                        isEnabled: true,
                        images: nil,
                        isMultilineText: isMultilineText
                    )
            }
        }
    }
}

// MARK: - Private Extensions

private extension Image {

    static let images: SwitchImages = .init(
        on: Image("switchOn"),
        off: Image("switchOff")
    )
}

private extension UIImage {

    static var images: SwitchUIImages {
        get throws {
            .init(
                on: IconographyTests.shared.switchOn,
                off: IconographyTests.shared.switchOff
            )
        }
    }
}
