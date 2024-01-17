//
//  ChipConfiguration.swift
//  Spark
//
//  Created by alican.aycil on 13.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

struct ChipConfiguration: ComponentConfiguration {
    var theme: Theme
    var intent: ChipIntent
    var variant: ChipVariant
    var alignment: ChipAlignment
    var isEnabled: Bool
    var isSelected: Bool
    var title: String?
    var icon: UIImage?
}
