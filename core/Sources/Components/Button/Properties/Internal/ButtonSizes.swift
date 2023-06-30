//
//  ButtonSizes.swift
//  SparkCore
//
//  Created by robin.lemaire on 30/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ButtonSizes {
    var height: CGFloat { get }
    var iconSize: CGFloat { get }
}

struct ButtonSizesDefault: ButtonSizes {

    // MARK: - Properties

    let height: CGFloat
    let iconSize: CGFloat
}
