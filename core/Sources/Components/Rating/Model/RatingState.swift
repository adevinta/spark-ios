//
//  RatingState.swift
//  SparkCore
//
//  Created by michael.zimmermann on 09.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@_spi(SI_SPI) import SparkCommon

struct RatingState: Updateable, Equatable {
    var isEnabled: Bool
    var isPressed: Bool

    static var standard = RatingState(isEnabled: true, isPressed: false)
    static var disabled = RatingState(isEnabled: false, isPressed: false)
    static var pressed = RatingState(isEnabled: true, isPressed: true)
}
