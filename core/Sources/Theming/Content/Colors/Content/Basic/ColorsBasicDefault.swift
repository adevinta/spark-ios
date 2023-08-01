//
//  ColorsBasicDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 01/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsBasicDefault: ColorsBasic {

    // MARK: - Properties

    public let basic: any ColorToken
    public let onBasic: any ColorToken
    public let basicContainer: any ColorToken
    public let onBasicContainer: any ColorToken

    // MARK: - Init

    public init(basic: any ColorToken,
                onBasic: any ColorToken,
                basicContainer: any ColorToken,
                onBasicContainer: any ColorToken) {
        self.basic = basic
        self.onBasic = onBasic
        self.basicContainer = basicContainer
        self.onBasicContainer = onBasicContainer
    }
}
