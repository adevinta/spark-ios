//
//  StarConfiguration.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

struct StarCellConfiguration: ComponentConfiguration {
    var theme: Theme
    var borderColor: UIColor
    var fillColor: UIColor
    var numberOfVertices: Int
    var fillMode: StarFillMode
}
