//
//  ColorsMainDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsMainDefault: ColorsMain {

    // MARK: - Properties

    public let main: any ColorToken
    public let onMain: any ColorToken
    public let mainVariant: any ColorToken
    public let onMainVariant: any ColorToken
    public let mainContainer: any ColorToken
    public let onMainContainer: any ColorToken

    // MARK: - Init

    public init(main: any ColorToken,
                onMain: any ColorToken,
                mainVariant: any ColorToken,
                onMainVariant: any ColorToken,
                mainContainer: any ColorToken,
                onMainContainer: any ColorToken) {
        self.main = main
        self.onMain = onMain
        self.mainVariant = mainVariant
        self.onMainVariant = onMainVariant
        self.mainContainer = mainContainer
        self.onMainContainer = onMainContainer
    }
}
