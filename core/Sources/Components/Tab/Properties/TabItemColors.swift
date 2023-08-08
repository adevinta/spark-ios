//
//  TabItemColors.swift
//  SparkCore
//
//  Created by alican.aycil on 28.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Colors of the tab item:
/// - label: defines the color of the text and the tint color of the icon
/// - line: The color of the base line
/// - background: The background color of the tab item.
struct TabItemColors: Equatable {
    var icon: any ColorToken {
        return self.label
    }
    let label: any ColorToken
    let line: any ColorToken
    let background: any ColorToken
    
    static func == (lhs: TabItemColors, rhs: TabItemColors) -> Bool {
        return colorsEqual(lhs.label, rhs.label) && colorsEqual(lhs.line, rhs.line) && colorsEqual(lhs.background, rhs.background)
    }
    
    private static func colorsEqual(_ lhs: any ColorToken, _ rhs: any ColorToken) -> Bool {
        return lhs.color == rhs.color && lhs.uiColor == rhs.uiColor
    }
}
