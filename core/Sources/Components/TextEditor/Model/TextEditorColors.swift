//
//  TextEditorColors.swift
//  SparkCore
//
//  Created by alican.aycil on 25.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

struct TextEditorColors: Equatable {
    let text: any ColorToken
    let placeholder: any ColorToken
    let border: any ColorToken
    let background: any ColorToken

    static func == (lhs: TextEditorColors, rhs: TextEditorColors) -> Bool {
        return lhs.text.equals(rhs.text) &&
        lhs.placeholder.equals(rhs.placeholder) &&
        lhs.border.equals(rhs.border) &&
        lhs.background.equals(rhs.background)
    }
}
