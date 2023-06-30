//
//  ButtonState.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ButtonState {
    var isInteractionEnabled: Bool { get }
    var opacity: CGFloat { get }
}

struct ButtonStateDefault: ButtonState {

    // MARK: - Properties

    let isInteractionEnabled: Bool
    let opacity: CGFloat
}
