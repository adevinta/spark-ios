//
//  ButtonSutSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 03/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import UIKit
import SwiftUI
import XCTest

struct ButtonSutSnapshotTests {

    // MARK: - Properties

    let intent: ButtonIntent
    let variant: ButtonVariant
    let size: ButtonSize
    let shape: ButtonShape
    let alignment: ButtonAlignmentDeprecated
    let iconImage: ImageEither?
    let title: String?
    let attributedTitle: AttributedStringEither?
    let isEnabled: Bool
    let isPressed: Bool

    // MARK: - Getter

    func testName(on function: String = #function) -> String {
        return [
            function,
            "\(self.intent)",
            "\(self.variant)",
            "\(self.size)",
            "\(self.shape)",
            "\(self.alignment)",
            self.iconImage != nil ? "withIcon" : "withoutIcon",
            self.title != nil ? "withTitle" : "withoutTitle",
            self.attributedTitle != nil ? "withAttributedTitle" : "withoutAttributedTitle",
            self.isEnabled ? "isEnabled" : "isDisabled",
            self.isPressed ? "isPressed" : "isUnpressed",
        ].joined(separator: "-")
    }

    // MARK: - Cases

    static func allColorsCases() -> [Self] {
        let intentPossibilities = ButtonIntent.allCases
        let variantPossibilities = ButtonVariant.allCases
        let isEnabledPossibilities = Bool.allCases
        let isPressedPossibilities = Bool.allCases

        return intentPossibilities.flatMap { intent in
            variantPossibilities.flatMap { variant in
                isEnabledPossibilities.flatMap { isEnabled in
                    isPressedPossibilities.map { isPressed in
                            .init(
                                intent: intent,
                                variant: variant,
                                size: .medium,
                                shape: .rounded,
                                alignment: .leadingIcon,
                                iconImage: nil,
                                title: "My Color Button",
                                attributedTitle: nil,
                                isEnabled: isEnabled,
                                isPressed: isPressed
                            )
                    }
                }
            }
        }
    }

    static func allStylesCases() -> [Self] {
        let sizePossibilities = ButtonSize.allCases
        let shapePossibilities = ButtonShape.allCases

        return sizePossibilities.flatMap { size in
            shapePossibilities.map { shape in
                    .init(
                        intent: .main,
                        variant: .filled,
                        size: size,
                        shape: shape,
                        alignment: .leadingIcon,
                        iconImage: nil,
                        title: "My Style Button",
                        attributedTitle: nil,
                        isEnabled: true,
                        isPressed: false
                    )
            }
        }
    }

    static func allContentCases(isSwiftUIComponent: Bool) -> [Self] {
        typealias ContentCases = (image: ImageEither?, title: String?, attributedTitle: AttributedStringEither?)

        let image: ImageEither = isSwiftUIComponent ? .right(Image.mock) : .left(UIImage.mock)
        let attributedTitle: AttributedStringEither = isSwiftUIComponent ? .right(AttributedString("My Attributed Button")) : .left(.init(string: "My Attributed Button"))

        let items: [ContentCases] = [
            (image: image, title: nil, attributedTitle: nil), // Only icon
            (image: image, title: "My Full Content Button", attributedTitle: nil), // Icon + title
            (image: nil, title: "My Content Button", attributedTitle: nil), // Only title
            (image: image, title: nil, attributedTitle: attributedTitle), // Icon + attributed title
            (image: nil, title: nil, attributedTitle: attributedTitle) // Only attributed title
        ]

        return items.map { item in
            .init(
                intent: .main,
                variant: .filled,
                size: .medium,
                shape: .rounded,
                alignment: .leadingIcon,
                iconImage: item.image,
                title: item.title,
                attributedTitle: item.attributedTitle,
                isEnabled: true,
                isPressed: false
            )
        }
    }
}

// MARK: - Private Extensions

private extension Image {
    static let mock = Image("arrow")
}

private extension UIImage {
    static var mock = IconographyTests.shared.arrow
}
