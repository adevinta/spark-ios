//
//  ButtonAlignmentDeprecated.swift
//  SparkCore
//
//  Created by robin.lemaire on 17/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The alignment of the switch.
@available(*, deprecated, message: "Use ButtonAlignment instead")
public enum ButtonAlignmentDeprecated: CaseIterable {
    /// Icon on the leading edge of the button.
    /// Text on the trailing edge of the button.
    /// Not interpreted if button contains only just icon or just text.
    case leadingIcon
    /// Icon on the trailing edge of the button.
    /// Text on the leading edge of the button
    /// Not interpreted if button contains only just icon or just text.
    case trailingIcon
}
