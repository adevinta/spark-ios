//
//  TabStateAttributes.swift
//  SparkCore
//
//  Created by alican.aycil on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Attributes available for the states of the tab:
/// - spacings: Spacings of the tab item.
/// - colors: Colors of the tab item.
/// - opacity: The opacity of the tab item.
/// - separatorLineHeight: The lineHeight of the tab item.
struct TabStateAttributes: Equatable {
    
    let spacings: TabItemSpacings
    let colors: TabItemColors
    let opacity: CGFloat?
    let separatorLineHeight: CGFloat
    
    static func == (lhs: TabStateAttributes, rhs: TabStateAttributes) -> Bool {
        return lhs.spacings == rhs.spacings && lhs.colors == rhs.colors && lhs.opacity == rhs.opacity && lhs.separatorLineHeight == rhs.separatorLineHeight
    }
}
