//
//  PurpleBorder.swift
//  Spark
//
//  Created by alex.vecherov on 05.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark

struct PurpleBorder: Border {

    // MARK: - Properties

    let width: BorderWidth = BorderWidthDefault(small: 2,
                                                medium: 3)
    let radius: BorderRadius = BorderRadiusDefault(small: 5,
                                                   medium: 9,
                                                   large: 20,
                                                   xLarge: 28)
}
