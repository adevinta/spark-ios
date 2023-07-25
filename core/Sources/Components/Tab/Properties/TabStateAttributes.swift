//
//  TabStateAttributes.swift
//  SparkCore
//
//  Created by alican.aycil on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Attributes available for the states of the tab:
/// - labelColor: defines the color of the text and the tint color of the icon
/// - lineColor: The color of the base line
/// - backgroundColor: The background color of the tab item.
/// - opacity: The opacity of the tab item.
/// - separatorLineHeight: The lineHeight of the tab item.
struct TabStateAttributes: Equatable {
    
    let labelColor: any ColorToken
    let lineColor: any ColorToken
    let backgroundColor: any ColorToken
    let opacity: CGFloat?
    let separatorLineHeight: CGFloat
    
    static func == (lhs: TabStateAttributes, rhs: TabStateAttributes) -> Bool {
        return colorsEqual(lhs.labelColor, rhs.labelColor) && colorsEqual(lhs.lineColor, rhs.lineColor) && colorsEqual(lhs.backgroundColor, rhs.backgroundColor) && lhs.opacity == rhs.opacity && lhs.separatorLineHeight == rhs.separatorLineHeight
    }
    
    private static func colorsEqual(_ lhs: any ColorToken, _ rhs: any ColorToken) -> Bool {
        return lhs.color == rhs.color && lhs.uiColor == rhs.uiColor
    }
}
