//
//  IconographyTransactionDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyTransactionDefault: IconographyTransaction {

    // MARK: - Properties

    public let carWarranty: IconographyFill & IconographyOutlined
    public let piggyBank: IconographyFill & IconographyOutlined
    public let money: IconographyFill & IconographyOutlined

    // MARK: - Init

    public init(carWarranty: IconographyFill & IconographyOutlined,
                piggyBank: IconographyFill & IconographyOutlined,
                money: IconographyFill & IconographyOutlined) {
        self.carWarranty = carWarranty
        self.piggyBank = piggyBank
        self.money = money
    }
}
