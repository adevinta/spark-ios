//
//  AddOnTextFieldConfiguration.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

struct AddOnTextFieldConfiguration: ComponentConfiguration {
    var theme: Theme
    var intent: TextFieldIntent
    var leftViewMode: ViewMode
    var rightViewMode: ViewMode
    var leadingAddOnOption: AddOnOption
    var trailingAddOnOption: AddOnOption
    var clearButtonMode: ViewMode
    var text: String?
    var icon: UIImage?
}
