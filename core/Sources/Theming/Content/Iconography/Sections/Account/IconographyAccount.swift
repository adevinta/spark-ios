//
//  IconographyAccount.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public protocol IconographyAccount {
    var bank: IconographyFilled & IconographyOutlined { get }
    var holiday: IconographyFilled & IconographyOutlined { get }
    var country: IconographyFilled & IconographyOutlined { get }
    var home: IconographyFilled & IconographyOutlined { get }
    var identity: IconographyFilled & IconographyOutlined { get }
    var key: IconographyFilled & IconographyOutlined { get }
    var favorite: IconographyFilled & IconographyOutlined { get }
    var shoppingCart: IconographyFilled & IconographyOutlined { get }
    var store: IconographyFilled & IconographyOutlined { get }
    var cv: IconographyFilled & IconographyOutlined { get }
    var fileOff: IconographyFilled & IconographyOutlined { get }
    var work: IconographyFilled & IconographyOutlined { get }
    var card: IconographyFilled & IconographyOutlined { get }
    var offer: IconographyFilled & IconographyOutlined { get }
    var burgerMenu: IconographyImage { get }
    var activity: IconographyImage { get }
    var listing: IconographyImage { get }
    var mobileCheck: IconographyImage { get }
}
