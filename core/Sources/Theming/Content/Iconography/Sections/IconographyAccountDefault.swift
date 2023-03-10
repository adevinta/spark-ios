//
//  IconographyAccountDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public struct IconographyAccountDefault: IconographyAccount {

    // MARK: - Properties

    public let bank: IconographyFill & IconographyOutlined
    public let holiday: IconographyFill & IconographyOutlined

    // MARK: - Initialization

    public init(bank: IconographyFill & IconographyOutlined,
         holiday: IconographyFill & IconographyOutlined) {
        self.bank = bank
        self.holiday = holiday
    }
}
