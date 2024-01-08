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
    var border: any SparkCore.Border { get }
    var colors: any SparkCore.Colors { get }
    var elevation: any SparkCore.Elevation { get }
    var layout: any SparkCore.Layout { get }
    var typography: any SparkCore.Typography { get }
    var dims: any SparkCore.Dims { get }
}
