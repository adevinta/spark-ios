//
//  ColorsSupportDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsSupportDefault: ColorsSupport {

    // MARK: - Properties

    public let support: any ColorToken
    public let onSupport: any ColorToken
    public let supportVariant: any ColorToken
    public let onSupportVariant: any ColorToken
    public let supportContainer: any ColorToken
    public let onSupportContainer: any ColorToken

    // MARK: - Init

    public init(support: any ColorToken,
                onSupport: any ColorToken,
                supportVariant: any ColorToken,
                onSupportVariant: any ColorToken,
                supportContainer: any ColorToken,
                onSupportContainer: any ColorToken) {
        self.support = support
        self.onSupport = onSupport
        self.supportVariant = supportVariant
        self.onSupportVariant = onSupportVariant
        self.supportContainer = supportContainer
        self.onSupportContainer = onSupportContainer
    }
}
