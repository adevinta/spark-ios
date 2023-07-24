//
//  TabStateAttributes.swift
//  SparkCore
//
//  Created by alican.aycil on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Attributes available for the states of the tab:
/// - Label: defines the color of the text and the tint color of the icon
/// - Line: The color of the base line
/// - Background: The background color of the tab item.
/// - Opacity: The opacity of the tab item.
/// - LineHeight: The lineHeight of the tab item.
struct TabStateAttributes: Equatable {
    
    let label: any ColorToken
    let line: any ColorToken
    let background: any ColorToken
    let opacity: CGFloat?
    let lineHeight: CGFloat
    
    static func == (lhs: TabStateAttributes, rhs: TabStateAttributes) -> Bool {
        return colorsEqual(lhs.label, rhs.label) && colorsEqual(lhs.line, rhs.line) && colorsEqual(lhs.background, rhs.background) && lhs.opacity == rhs.opacity && lhs.lineHeight == rhs.lineHeight
    }
    
    private static func colorsEqual(_ lhs: any ColorToken, _ rhs: any ColorToken) -> Bool {
        return lhs.color == rhs.color && lhs.uiColor == rhs.uiColor
    }
}