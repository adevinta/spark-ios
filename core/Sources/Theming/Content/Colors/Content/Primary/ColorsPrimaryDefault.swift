//
//  ColorsPrimaryDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsPrimaryDefault: ColorsPrimary {

    // MARK: - Properties

    public let primary: any ColorToken
    public let onPrimary: any ColorToken
    public let primaryVariant: any ColorToken
    public let onPrimaryVariant: any ColorToken
    public let primaryContainer: any ColorToken
    public let onPrimaryContainer: any ColorToken

    // MARK: - Init

    public init(primary: any ColorToken,
                onPrimary: any ColorToken,
                primaryVariant: any ColorToken,
                onPrimaryVariant: any ColorToken,
                primaryContainer: any ColorToken,
                onPrimaryContainer: any ColorToken) {
        self.primary = primary
        self.onPrimary = onPrimary
        self.primaryVariant = primaryVariant
        self.onPrimaryVariant = onPrimaryVariant
        self.primaryContainer = primaryContainer
        self.onPrimaryContainer = onPrimaryContainer
    }
}
