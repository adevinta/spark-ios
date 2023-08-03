//
//  ColorsAccentDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 01/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsAccentDefault: ColorsAccent {

    // MARK: - Properties

    public let accent: any ColorToken
    public let onAccent: any ColorToken
    public let accentVariant: any ColorToken
    public let onAccentVariant: any ColorToken
    public let accentContainer: any ColorToken
    public let onAccentContainer: any ColorToken

    // MARK: - Init

    public init(accent: any ColorToken,
                onAccent: any ColorToken,
                accentVariant: any ColorToken,
                onAccentVariant: any ColorToken,
                accentContainer: any ColorToken,
                onAccentContainer: any ColorToken) {
        self.accent = accent
        self.onAccent = onAccent
        self.accentVariant = accentVariant
        self.onAccentVariant = onAccentVariant
        self.accentContainer = accentContainer
        self.onAccentContainer = onAccentContainer
    }
}
