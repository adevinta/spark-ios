//
//  RatingInputConfiguration.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

struct RatingInputConfiguration: ComponentConfiguration {
    var theme: Theme
    var intent: RatingIntent
    var rating: CGFloat
    var isEnabled: Bool
}
