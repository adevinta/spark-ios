//
//  TabConfiguration.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Spark

struct TabConfiguration: ComponentConfiguration {
    var theme: Theme
    var intent: TabIntent
    var size: TabSize
    var contents: [TabUIItemContent]
    var showBadge: Bool
    var isEqualWidth: Bool
}
