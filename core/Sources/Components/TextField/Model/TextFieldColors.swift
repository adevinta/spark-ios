//
//  TextFieldColors.swift
//  SparkCore
//
//  Created by Quentin.richard on 22/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct TextFieldColors: Equatable {
    let text: any ColorToken
    let placeholder: any ColorToken
    let border: any ColorToken
    let statusIcon: any ColorToken
    let background: any ColorToken

    static func == (lhs: TextFieldColors, rhs: TextFieldColors) -> Bool {
        return lhs.text.equals(rhs.text) &&
        lhs.placeholder.equals(rhs.placeholder) &&
        lhs.border.equals(rhs.border) &&
        lhs.statusIcon.equals(rhs.statusIcon) &&
        lhs.background.equals(rhs.background)
    }
}
