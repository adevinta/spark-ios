//
//  Theme.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI

// sourcery: AutoMockable
public protocol Theme {
    var border: SparkCore.Border { get }
    var colors: SparkCore.Colors { get }
    var elevation: SparkCore.Elevation { get }
    var layout: SparkCore.Layout { get }
    var typography: SparkCore.Typography { get }
    var dims: SparkCore.Dims { get }
}
