//
//  SwitchInteractionState.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchInteractionStateable {
    var interactionEnabled: Bool { get }
    var opacity: CGFloat { get }
}

struct SwitchInteractionState: SwitchInteractionStateable {

    // MARK: - Properties

    let interactionEnabled: Bool
    let opacity: CGFloat
}
