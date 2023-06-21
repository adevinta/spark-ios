//
//  TagVariant.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The variant for the tag.
public enum TagVariant: CaseIterable {
    /// Background and border color is the same, tint is lighter.
    case filled
    /// Border and tint color is the same, background is lighter.
    case outlined
    /// Background and border color is the same, tint is darker.
    case tinted
}
