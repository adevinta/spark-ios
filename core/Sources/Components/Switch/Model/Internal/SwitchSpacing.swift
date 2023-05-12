//
//  SwitchSpacing.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchSpacingable {
    var horizontal: CGFloat { get }
    var vertical: CGFloat { get }
}

struct SwitchSpacing: SwitchSpacingable {

    // MARK: - Properties

    let horizontal: CGFloat
    let vertical: CGFloat
}
