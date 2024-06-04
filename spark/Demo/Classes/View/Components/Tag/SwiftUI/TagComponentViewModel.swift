//
//  TagComponentViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 20/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SwiftUI
import Spark

struct TagComponentViewModel: Hashable {

    // MARK: - Properties

    let imageNamed: String = "alert"

    func attributedText(_ text: String) -> AttributedString {
        var attributedText = AttributedString(text)
        attributedText.font = SparkTheme.shared.typography.body2.font
        attributedText.foregroundColor = SparkTheme.shared.colors.main.main.color
        attributedText.backgroundColor = SparkTheme.shared.colors.main.onMain.color
        return attributedText
    }
}
