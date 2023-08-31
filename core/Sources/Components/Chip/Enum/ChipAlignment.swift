//
//  ChipAlignment.swift
//  SparkCore
//
//  Created by michael.zimmermann on 21.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public enum ChipAlignment: CaseIterable {
    /// Icon on the leading edge of the chip.
    /// Text on the trailing edge of the chip.
    /// Not interpreted if chip contains just an icon or just text.
    case leadingIcon
    /// Icon on the trailing edge of the chip.
    /// Text on the leading edge of the chip
    /// Not interpreted if the chip contains just an icon or just text.
    case trailingIcon
}
