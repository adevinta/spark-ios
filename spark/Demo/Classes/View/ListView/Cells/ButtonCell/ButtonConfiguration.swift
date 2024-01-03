//
//  ButtonConfiguration.swift
//  SparkDemo
//
//  Created by alican.aycil on 14.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

struct ButtonConfiguration: ComponentConfiguration {
    var theme: Theme
    var intent: ButtonIntent
    var variant: ButtonVariant
    var size: ButtonSize
    var shape: ButtonShape
    var alignment: ButtonAlignment
    var content: ButtonContentDefault
    var isEnabled: Bool
}
