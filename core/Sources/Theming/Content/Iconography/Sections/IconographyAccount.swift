//
//  IconographyAccount.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public protocol IconographyAccount {
    var bank: IconographyFill & IconographyOutlined { get }
    var holiday: IconographyFill & IconographyOutlined { get }
}
