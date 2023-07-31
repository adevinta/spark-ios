//
//  TabItemSpacings.swift
//  SparkCore
//
//  Created by alican.aycil on 28.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Spacings of the tab item:
/// - verticalEdge: The vertical edge determines top and bottom spacing of the tab item.
/// - horizontalEdge: The horizontal edge determines leading and trailing spacing of the tab item.
/// - content: The content determines the space  between the icon, text and badge.
struct TabItemSpacings: Equatable {
    
    let verticalEdge: CGFloat
    let horizontalEdge: CGFloat
    let content: CGFloat
    
    static func == (lhs: TabItemSpacings, rhs: TabItemSpacings) -> Bool {
        return lhs.verticalEdge == rhs.verticalEdge &&
        lhs.horizontalEdge == lhs.horizontalEdge &&
        lhs.content == rhs.content
    }
}
