//
//  EdgeInsets+Extension.swift
//  SparkCore
//
//  Created by robin.lemaire on 04/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public extension EdgeInsets {

    // MARK: - Init

    /// Init EdgeInsets with same value for top, leading, bottom and trailing
    /// - Parameters:
    ///   - all: inset value
    init(all value: CGFloat) {
        self = .init(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Init EdgeInsets with vertical (use to set top and bottom insets) and horizontal value (use to set leading and trailing insets)
    /// - Parameters:
    ///   - vertical: horizontal inset value use to set left and right insets.
    ///   - horizontal: horizontal inset value use to set left and right insets.
    init(vertical: CGFloat, horizontal: CGFloat) {
        self = .init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
