//
//  AttributedStringEither+ExtensionSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by robin.lemaire on 30/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SwiftUI
import UIKit

extension AttributedStringEither {

    static func mock(
        isSwiftUIComponent: Bool,
        text: String = "My AT Title",
        fontSize: CGFloat = 20
    ) -> Self {
        return isSwiftUIComponent ? .right(
            .mock(text: text, fontSize: fontSize)
        ) : .left(
            .mock(text: text, fontSize: fontSize)
        )
    }
}

private extension NSAttributedString {
    static func mock(
        text: String,
        fontSize: CGFloat
    ) -> NSAttributedString {
        return .init(string: text,
                     attributes: [
                        .foregroundColor: UIColor.purple,
                        .font: UIFont.italicSystemFont(ofSize: fontSize),
                        .underlineStyle: NSUnderlineStyle.single.rawValue
                     ]
        )
    }
}

private extension AttributedString {
    static func mock(
        text: String,
        fontSize: CGFloat
    ) -> AttributedString {
        var attributedString = AttributedString(text)
        attributedString.font = .italicSystemFont(ofSize: fontSize)
        attributedString.underlineStyle = .single
        attributedString.underlineColor = .purple
        attributedString.foregroundColor = .purple
        return attributedString
    }
}
