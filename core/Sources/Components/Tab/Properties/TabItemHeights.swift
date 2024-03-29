//
//  TabItemHeights.swift
//  SparkCore
//
//  Created by michael.zimmermann on 08.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Heights of a tab item.
/// - separatorLineHeight: The height of the bottom line.
/// - itemHeight: The height of the item
/// - iconHeight: The height of the icon
struct TabItemHeights: Equatable, Updateable {
    var separatorLineHeight: CGFloat
    var itemHeight: CGFloat
    var iconHeight: CGFloat
}
