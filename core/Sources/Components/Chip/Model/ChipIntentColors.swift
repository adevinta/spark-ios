//
//  ChipIntentColors.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// The intent colors a chip can have
struct ChipIntentColors {

    // MARK: - Properties
    
    let border: any ColorToken
    let text: any ColorToken
    let selectedText: any ColorToken
    let background: any ColorToken
    let pressedBackground: any ColorToken
    let selectedBackground: any ColorToken
    let disabledBackground: (any ColorToken)?

    init(border: any ColorToken,
         text: any ColorToken,
         selectedText: any ColorToken,
         background: any ColorToken,
         pressedBackground: any ColorToken,
         selectedBackground: any ColorToken,
         disabledBackground: (any ColorToken)? = nil) {
        self.border = border
        self.text = text
        self.selectedText = selectedText
        self.background = background
        self.pressedBackground = pressedBackground
        self.selectedBackground = selectedBackground
        self.disabledBackground = disabledBackground
    }
}
