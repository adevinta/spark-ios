//
//  IconographyTransaction.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyTransaction {
    var carWarranty: IconographyFilled & IconographyOutlined { get }
    var piggyBank: IconographyFilled & IconographyOutlined { get }
    var money: IconographyFilled & IconographyOutlined { get }
}
