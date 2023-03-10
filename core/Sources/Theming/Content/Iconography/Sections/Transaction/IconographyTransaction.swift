//
//  IconographyTransaction.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyTransaction {
    var carWarranty: IconographyFill & IconographyOutlined { get }
    var piggyBank: IconographyFill & IconographyOutlined { get }
    var money: IconographyFill & IconographyOutlined { get }
}
