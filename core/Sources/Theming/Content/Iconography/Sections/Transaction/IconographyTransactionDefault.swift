//
//  IconographyTransactionDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyTransactionDefault: IconographyTransaction {

    // MARK: - Properties

    public let carWarranty: IconographyFilled & IconographyOutlined
    public let piggyBank: IconographyFilled & IconographyOutlined
    public let money: IconographyFilled & IconographyOutlined

    // MARK: - Init

    public init(carWarranty: IconographyFilled & IconographyOutlined,
                piggyBank: IconographyFilled & IconographyOutlined,
                money: IconographyFilled & IconographyOutlined) {
        self.carWarranty = carWarranty
        self.piggyBank = piggyBank
        self.money = money
    }
}
