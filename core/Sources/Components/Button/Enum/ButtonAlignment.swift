//
//  ButtonAlignment.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The alignment of the switch.
public enum ButtonAlignment: CaseIterable {
    /// Icon on the leading edge of the button.
    /// Text on the trailing edge of the button.
    /// Not interpreted if button contains only just icon or just text.
    case leadingIcon
    /// Icon on the trailing edge of the button.
    /// Text on the leading edge of the button
    /// Not interpreted if button contains only just icon or just text.
    case trailingIcon
}
