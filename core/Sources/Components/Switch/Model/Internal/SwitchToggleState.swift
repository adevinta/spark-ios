//
//  SwitchToggleState.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchToggleStateable{
    var interactionEnabled: Bool { get }
    var opacity: CGFloat { get }
}

struct SwitchToggleState: SwitchToggleStateable {

    // MARK: - Properties

    let interactionEnabled: Bool
    let opacity: CGFloat
}
