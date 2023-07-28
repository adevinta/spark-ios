//
//  TabItemSpacings.swift
//  SparkCore
//
//  Created by alican.aycil on 28.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Spacings of the tab item:
/// - verticalSpacing: The vertical spacing determines top and bottom spacing of the tab item.
/// - horizontalSpacing: The horizantal spacing determines leading and trailing spacing of the tab item.
/// - horizontalPadding: The horizontal padding determines the padding of between the text and the icon.
struct TabItemSpacings: Equatable {
    
    let verticalSpacing: CGFloat
    let horizontalSpacing: CGFloat
    let horizontalPadding: CGFloat
    
    static func == (lhs: TabItemSpacings, rhs: TabItemSpacings) -> Bool {
        return lhs.verticalSpacing == rhs.verticalSpacing &&
        lhs.horizontalSpacing == lhs.horizontalSpacing &&
        lhs.horizontalPadding == rhs.horizontalPadding
    }
}
