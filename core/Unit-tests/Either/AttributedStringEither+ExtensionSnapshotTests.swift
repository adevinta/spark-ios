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

    static func mock(isSwiftUIComponent: Bool) -> Self {
        return isSwiftUIComponent ? .right(.mock) : .left(.mock)
    }
}

private extension NSAttributedString {
    static let mock = NSAttributedString(
        string: "My AT Title",
        attributes: [
            .foregroundColor: UIColor.purple,
            .font: UIFont.italicSystemFont(ofSize: 20),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    )
}

private extension AttributedString {
    static var mock: AttributedString = {
        var attributedString = AttributedString("My AT Title")
        attributedString.font = .largeTitle
        attributedString.foregroundColor = .purple
        attributedString.font = .italicSystemFont(ofSize: 20)
        attributedString.underlineStyle = .single
        attributedString.underlineColor = .purple
        return attributedString
    }()
}
