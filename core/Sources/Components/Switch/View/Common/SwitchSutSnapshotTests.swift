//
//  SwitchSutSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 14/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import UIKit
import SwiftUI
import XCTest

struct SwitchSutSnapshotTests {

    // MARK: - Type Alias

    typealias SwitchAttributedStringEither = Either<NSAttributedString, AttributedString>

    // MARK: - Properties

    let intent: SwitchIntent
    let isOn: Bool
    let alignment: SwitchAlignment
    let isEnabled: Bool
    let images: SwitchImagesEither?
    let text: String?
    let attributedText: SwitchAttributedStringEither?

    // MARK: - Getter

    func testName(on function: String = #function) -> String {
        return [
            function,
            "\(self.intent)",
            self.isOn ? "isOn" : "isOff",
            "\(self.alignment)" + "Aligment",
            self.isEnabled ? "isEnabled" : "isDisabled",
            self.images != nil ? "withImages" : "withoutImages",
            self.text != nil ? "withText" : "withoutText",
            self.attributedText != nil ? "withAttributedText" : "withoutAttributedText",
        ].joined(separator: "-")
    }

    // MARK: - Cases

    /// Test all colors for all intent, isOn and IsEnabled cases
    static func allColorsCases(isSwiftUIComponent: Bool) throws -> [Self] {
        let intentPossibilities = SwitchIntent.allCases
        let isOnPossibilities = Bool.allCases
        let isEnabledPossibilities = Bool.allCases

        return intentPossibilities.flatMap { intent in
            isOnPossibilities.flatMap { isOn in
                isEnabledPossibilities.map { isEnabled -> SwitchSutSnapshotTests in
                        .init(
                            intent: intent,
                            isOn: isOn,
                            alignment: .left,
                            isEnabled: isEnabled,
                            images: nil,
                            text: "My Color Switch",
                            attributedText: nil
                        )
                }
            }
        }
    }

    /// Test all contents for all images, text and attributedText cases
    static func allContentsCases(isSwiftUIComponent: Bool) throws -> [Self] {
        typealias ContentCases = (images: SwitchImagesEither?, text: String?, attributedText: SwitchAttributedStringEither?)

        let images: SwitchImagesEither = try isSwiftUIComponent ? .right(Image.images) : .left(UIImage.images)

        let attributedText: SwitchAttributedStringEither = isSwiftUIComponent ? .right(AttributedString("My Attributed Switch")) : .left(.init(string: "My Attributed Switch"))

        let items: [ContentCases] = [
            (images: images, text: "My Full Content Switch", attributedText: nil), // Images + text
            (images: nil, text: "My Content Switch", attributedText: nil), // Only text
            (images: images, text: nil, attributedText: attributedText), // Images + attributed text
            (images: nil, text: nil, attributedText: attributedText), // Only attributed text
            (images: nil, text: nil, attributedText: nil) // Nothing
        ]

        return items.map { item -> SwitchSutSnapshotTests in
                .init(
                    intent: .main,
                    isOn: true,
                    alignment: .left,
                    isEnabled: true,
                    images: item.images,
                    text: item.text,
                    attributedText: item.attributedText
                )
        }
    }

    /// Test all positions for all alignment cases
    static func allPositionsCases(isSwiftUIComponent: Bool) throws -> [Self] {
        let alignmentPossibilities = SwitchAlignment.allCases
        let isMultilineTextPossibilities = Bool.allCases

        return alignmentPossibilities.flatMap { alignment in
            isMultilineTextPossibilities.map { isMultilineText -> SwitchSutSnapshotTests in
                    .init(
                        intent: .main,
                        isOn: true,
                        alignment: alignment,
                        isEnabled: true,
                        images: nil,
                        text: isMultilineText ? "Multiline switch.\nMore text.\nAnd more text." : "My Text",
                        attributedText: nil
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
