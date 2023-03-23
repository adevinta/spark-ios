//
//  ColorsSecondaryDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsSecondaryDefault: ColorsSecondary {

    // MARK: - Properties

    public let secondary: ColorToken
    public let onSecondary: ColorToken
    public let secondaryVariant: ColorToken
    public let onSecondaryVariant: ColorToken
    public let secondaryContainer: ColorToken
    public let onSecondaryContainer: ColorToken

    // MARK: - Init

    public init(secondary: ColorToken,
                onSecondary: ColorToken,
                secondaryVariant: ColorToken,
                onSecondaryVariant: ColorToken,
                secondaryContainer: ColorToken,
                onSecondaryContainer: ColorToken) {
        self.secondary = secondary
        self.onSecondary = onSecondary
        self.secondaryVariant = secondaryVariant
        self.onSecondaryVariant = onSecondaryVariant
        self.secondaryContainer = secondaryContainer
        self.onSecondaryContainer = onSecondaryContainer
    }
}
