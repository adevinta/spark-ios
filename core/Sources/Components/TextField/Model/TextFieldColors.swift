//
//  TextFieldColors.swift
//  SparkCore
//
//  Created by Quentin.richard on 22/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct TextFieldColors {

    // MARK: - Properties

    let labelColor: any ColorToken
    let borderColor: any ColorToken
    let helperColor: any ColorToken
    let iconColor: any ColorToken
}

// MARK: Hashable & Equatable

extension TextFieldColors: Hashable, Equatable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.labelColor)
        hasher.combine(self.borderColor)
        hasher.combine(self.helperColor)
        hasher.combine(self.iconColor)
    }

    static func == (lhs: TextFieldColors, rhs: TextFieldColors) -> Bool {
        return lhs.labelColor.equals(rhs.labelColor) &&
        lhs.borderColor.equals(rhs.borderColor) &&
        lhs.helperColor.equals(rhs.helperColor) &&
        lhs.iconColor.equals(rhs.iconColor)
    }
}
