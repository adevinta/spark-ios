//
//  CheckboxGroupConfiguration.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Spark

struct CheckboxGroupConfiguration: ComponentConfiguration {
    var theme: Theme
    var intent: CheckboxIntent
    var alignment: CheckboxAlignment
    var layout: CheckboxGroupLayout
    var showGroupTitle: Bool
    var items: [any CheckboxGroupItemProtocol]
}
