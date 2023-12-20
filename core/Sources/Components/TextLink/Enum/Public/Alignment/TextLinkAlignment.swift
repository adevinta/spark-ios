//
//  TextLinkAlignment.swift
//  SparkCore
//
//  Created by robin.lemaire on 08/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The alignment of the switch.
public enum TextLinkAlignment: CaseIterable {
    /// Image on the leading edge of the textlink.
    /// Text on the trailing edge of the textlink.
    /// Not interpreted if textlink contains only text.
    case leadingImage
    /// Image on the trailing edge of the textlink.
    /// Text on the leading edge of the textlink
    /// Not interpreted if textlink contains only text.
    case trailingImage

    // MARK: - Properties

    var isTrailingImage: Bool {
        return self == .trailingImage
    }
}
