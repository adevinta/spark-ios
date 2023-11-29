//
//  ButtonAlignment.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The alignment of the switch.
public enum ButtonAlignment: CaseIterable {
    /// Image on the leading edge of the button.
    /// Text on the trailing edge of the button.
    /// Not interpreted if button contains only just image or just text.
    case leadingImage
    /// Image on the trailing edge of the button.
    /// Text on the leading edge of the button
    /// Not interpreted if button contains only just image or just text.
    case trailingImage

    // MARK: - Properties

    var isTrailingImage: Bool {
        return self == .trailingImage
    }
}
