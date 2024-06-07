//
//  ProgressTrackerSpacing.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 24.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
@_spi(SI_SPI) import SparkCommon

/// Spacings defined in the progress tracker
struct ProgressTrackerSpacing: Updateable, Equatable {
    var trackIndicatorSpacing: CGFloat
    var minLabelSpacing: CGFloat
}
