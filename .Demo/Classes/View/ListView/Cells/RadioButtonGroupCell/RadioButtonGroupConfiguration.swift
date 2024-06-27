//
//  RadioButtonGroupConfiguration.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

struct RadioButtonGroupConfiguration: ComponentConfiguration {
    var theme: Theme
    var intent: RadioButtonIntent
    var alignment: RadioButtonLabelAlignment
    var layout: RadioButtonGroupLayout
    var isEnabled: Bool
    var selectedID: Int
}

