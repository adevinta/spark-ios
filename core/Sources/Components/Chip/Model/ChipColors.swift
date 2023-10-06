//
//  ChipColors.swift
//  SparkCore
//
//  Created by michael.zimmermann on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The colors a chip can have for the default state and the pressed state
struct ChipColors: Equatable {
    // MARK: - Properties

    let `default`: ChipStateColors
    let pressed: ChipStateColors
    let selected: ChipStateColors
}
