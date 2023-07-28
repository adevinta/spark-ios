//
//  TabItemColors.swift
//  SparkCore
//
//  Created by alican.aycil on 28.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Colors of the tab item:
/// - labelColor: defines the color of the text and the tint color of the icon
/// - lineColor: The color of the base line
/// - backgroundColor: The background color of the tab item.
struct TabItemColors: Equatable {
    
    let labelColor: any ColorToken
    let lineColor: any ColorToken
    let backgroundColor: any ColorToken
    
    static func == (lhs: TabItemColors, rhs: TabItemColors) -> Bool {
        return colorsEqual(lhs.labelColor, rhs.labelColor) && colorsEqual(lhs.lineColor, rhs.lineColor) && colorsEqual(lhs.backgroundColor, rhs.backgroundColor)
    }
    
    private static func colorsEqual(_ lhs: any ColorToken, _ rhs: any ColorToken) -> Bool {
        return lhs.color == rhs.color && lhs.uiColor == rhs.uiColor
    }
}
