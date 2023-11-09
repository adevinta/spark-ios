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

    let border: any ColorToken
    let statusIcon: any ColorToken
}

// MARK: Equatable

extension TextFieldColors: Equatable {

    static func == (lhs: TextFieldColors, rhs: TextFieldColors) -> Bool {
        lhs.border.equals(rhs.border)
    }
}
