//
//  IconographyAccount.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public protocol IconographyAccount {
    var bank: IconographyFill & IconographyOutlined { get }
    var holiday: IconographyFill & IconographyOutlined { get }
    // TODO: // TODO: UI question: france ?
    var home: IconographyFill & IconographyOutlined { get }
    var identity: IconographyFill & IconographyOutlined { get }
    var key: IconographyFill & IconographyOutlined { get }
    var favorite: IconographyFill & IconographyOutlined { get }
    var shoppingCart: IconographyFill & IconographyOutlined { get }
    var store: IconographyFill & IconographyOutlined { get }
    var cv: IconographyFill & IconographyOutlined { get }
    var fileOff: IconographyFill & IconographyOutlined { get }
    var work: IconographyFill & IconographyOutlined { get }
    var card: IconographyFill & IconographyOutlined { get }
    var offer: IconographyFill & IconographyOutlined { get }
    var burgerMenu: IconographyImage { get }
    var activity: IconographyImage { get }
    var listing: IconographyImage { get }
    var mobileCheck: IconographyImage { get }
}
