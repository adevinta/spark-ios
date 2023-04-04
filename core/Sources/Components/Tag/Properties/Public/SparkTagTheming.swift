//
//  SparkTagTheming.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct SparkTagTheming {

    // MARK: - Properties

    let theme: Theme
    let intentColor: SparkTagIntentColor
    let variant: SparkTagVariant

    // MARK: - Initialization

    public init(theme: Theme, intentColor: SparkTagIntentColor, variant: SparkTagVariant) {
        self.theme = theme
        self.intentColor = intentColor
        self.variant = variant
    }
}
