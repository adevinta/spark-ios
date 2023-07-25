//
//  TabState.swift
//  SparkCore
//
//  Created by alican.aycil on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// `TabState` determines the current state of the tab.
struct TabState: Equatable, Updateable {
    let isDisabled: Bool
    let isPressed: Bool
    let isSelected: Bool
    
    init(
        isDisabled: Bool = false,
        isPressed: Bool = false,
        isSelected: Bool = false
    ) {
        self.isDisabled = isDisabled
        self.isPressed = isPressed
        self.isSelected = isSelected
    }
}
