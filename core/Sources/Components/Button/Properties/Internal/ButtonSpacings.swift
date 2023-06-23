//
//  ButtonSpacing.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ButtonSpacingsProtocol {
    var verticalSpacing: CGFloat { get }
    var horizontalSpacing: CGFloat { get }
    var horizontalPadding: CGFloat { get }
}

struct ButtonSpacings: ButtonSpacingsProtocol {

    // MARK: - Properties

    let verticalSpacing: CGFloat
    let horizontalSpacing: CGFloat
    let horizontalPadding: CGFloat
}
