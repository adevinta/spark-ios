//
//  IconographyCRMDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyCRMDefault: IconographyCRM {

    // MARK: - Properties

    public var wallet: IconographyImage
    public var card: IconographyImage

    // MARK: - Init

    public init(wallet: IconographyImage,
                card: IconographyImage) {
        self.wallet = wallet
        self.card = card
    }
}
