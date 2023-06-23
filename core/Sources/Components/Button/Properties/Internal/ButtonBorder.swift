//
//  ButtonBorder.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ButtonBorderProtocol {
    var width: CGFloat { get }
    var radius: CGFloat { get }
}

struct ButtonBorder: ButtonBorderProtocol {

    // MARK: - Properties

    let width: CGFloat
    let radius: CGFloat
}
