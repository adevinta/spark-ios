//
//  ColorsSecondaryDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsSecondaryDefault: ColorsSecondary {

    // MARK: - Properties

    public let secondary: any ColorToken
    public let onSecondary: any ColorToken
    public let secondaryVariant: any ColorToken
    public let onSecondaryVariant: any ColorToken
    public let secondaryContainer: any ColorToken
    public let onSecondaryContainer: any ColorToken

    // MARK: - Init

    public init(secondary: any ColorToken,
                onSecondary: any ColorToken,
                secondaryVariant: any ColorToken,
                onSecondaryVariant: any ColorToken,
                secondaryContainer: any ColorToken,
                onSecondaryContainer: any ColorToken) {
        self.secondary = secondary
        self.onSecondary = onSecondary
        self.secondaryVariant = secondaryVariant
        self.onSecondaryVariant = onSecondaryVariant
        self.secondaryContainer = secondaryContainer
        self.onSecondaryContainer = onSecondaryContainer
    }
}
