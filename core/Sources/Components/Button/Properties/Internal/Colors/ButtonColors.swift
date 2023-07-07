//
//  ButtonColors.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// All Button Colors from a theme, variant and intents
struct ButtonColors {

    // MARK: - Properties

    let foregroundColor: any ColorToken
    let backgroundColor: any ColorToken
    let pressedBackgroundColor: any ColorToken
    let borderColor: any ColorToken
    let pressedBorderColor: any ColorToken
}

// MARK: Hashable & Equatable

extension ButtonColors: Hashable, Equatable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.foregroundColor)
        hasher.combine(self.backgroundColor)
        hasher.combine(self.pressedBackgroundColor)
        hasher.combine(self.borderColor)
        hasher.combine(self.pressedBorderColor)
    }

    static func == (lhs: ButtonColors, rhs: ButtonColors) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
