//
//  ColorsPrimaryDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsPrimaryDefault: ColorsPrimary {

    // MARK: - Properties

    public let primary: ColorToken
    public let onPrimary: ColorToken
    public let primaryVariant: ColorToken
    public let onPrimaryVariant: ColorToken
    public let primaryContainer: ColorToken
    public let onPrimaryContainer: ColorToken

    // MARK: - Init

    public init(primary: ColorToken,
                onPrimary: ColorToken,
                primaryVariant: ColorToken,
                onPrimaryVariant: ColorToken,
                primaryContainer: ColorToken,
                onPrimaryContainer: ColorToken) {
        self.primary = primary
        self.onPrimary = onPrimary
        self.primaryVariant = primaryVariant
        self.onPrimaryVariant = onPrimaryVariant
        self.primaryContainer = primaryContainer
        self.onPrimaryContainer = onPrimaryContainer
    }
}
