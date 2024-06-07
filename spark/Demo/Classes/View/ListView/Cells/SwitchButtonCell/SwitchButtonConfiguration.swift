//
//  SwitchButtonConfiguration.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Spark

struct SwitchButtonConfiguration: ComponentConfiguration {
    var theme: Theme
    var intent: SwitchIntent
    var alignment: SwitchAlignment
    var textContent: SwitchTextContentDefault
    var isOn: Bool
    var isEnabled: Bool
}
