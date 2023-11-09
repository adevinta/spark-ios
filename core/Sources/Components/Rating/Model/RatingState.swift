//
//  RatingState.swift
//  SparkCore
//
//  Created by michael.zimmermann on 09.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct RatingState: Updateable, Equatable {
    var isDisabled: Bool
    var isPressed: Bool

    static var standard = RatingState(isDisabled: false, isPressed: false)
    static var disabled = RatingState(isDisabled: true, isPressed: false)
    static var pressed = RatingState(isDisabled: false, isPressed: true)
}
