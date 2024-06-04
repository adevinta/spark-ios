//
//  CheckboxConfiguration.swift
//  Spark
//
//  Created by alican.aycil on 14.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Spark

struct CheckboxConfiguration: ComponentConfiguration {
    var theme: Theme
    var intent: CheckboxIntent
    var isEnabled: Bool
    var alignment: CheckboxAlignment
    var text: String
    var icon: UIImage?
    var selectionState: CheckboxSelectionState
}
