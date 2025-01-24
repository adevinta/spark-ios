//
//  String+AttributedStringExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

extension String {

    var demoAttributedString: AttributedString {
        var attributedText = AttributedString(self)
        attributedText.font = SparkTheme.shared.typography.body2.font
        attributedText.foregroundColor = .red
        attributedText.backgroundColor = .gray
        return attributedText
    }
}
