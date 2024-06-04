//
//  RadioButtonConfiguration.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Spark

struct RadioButtonConfiguration: ComponentConfiguration {
    var theme: Theme
    var intent: RadioButtonIntent
    var alignment: RadioButtonLabelAlignment
    var isSelected: Bool
    var isEnabled: Bool
    var text: String
}
