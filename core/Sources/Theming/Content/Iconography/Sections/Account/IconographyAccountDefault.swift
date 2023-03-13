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
    public let country: IconographyFill & IconographyOutlined
    public let home: IconographyFill & IconographyOutlined
    public let identity: IconographyFill & IconographyOutlined
    public let key: IconographyFill & IconographyOutlined
    public let favorite: IconographyFill & IconographyOutlined
    public let shoppingCart: IconographyFill & IconographyOutlined
    public let store: IconographyFill & IconographyOutlined
    public let cv: IconographyFill & IconographyOutlined
    public let fileOff: IconographyFill & IconographyOutlined
    public let work: IconographyFill & IconographyOutlined
    public let card: IconographyFill & IconographyOutlined
    public let offer: IconographyFill & IconographyOutlined
    public let burgerMenu: IconographyImage
    public let activity: IconographyImage
    public let listing: IconographyImage
    public let mobileCheck: IconographyImage

    // MARK: - Initialization

    public init(bank: IconographyFill & IconographyOutlined,
                holiday: IconographyFill & IconographyOutlined,
                country: IconographyFill & IconographyOutlined,
                home: IconographyFill & IconographyOutlined,
                identity: IconographyFill & IconographyOutlined,
                key: IconographyFill & IconographyOutlined,
                favorite: IconographyFill & IconographyOutlined,
                shoppingCart: IconographyFill & IconographyOutlined,
                store: IconographyFill & IconographyOutlined,
                cv: IconographyFill & IconographyOutlined,
                fileOff: IconographyFill & IconographyOutlined,
                work: IconographyFill & IconographyOutlined,
                card: IconographyFill & IconographyOutlined,
                offer: IconographyFill & IconographyOutlined,
                burgerMenu: IconographyImage,
                activity: IconographyImage,
                listing: IconographyImage,
                mobileCheck: IconographyImage) {
        self.bank = bank
        self.holiday = holiday
        self.country = country
        self.home = home
        self.identity = identity
        self.key = key
        self.favorite = favorite
        self.shoppingCart = shoppingCart
        self.store = store
        self.cv = cv
        self.fileOff = fileOff
        self.work = work
        self.card = card
        self.offer = offer
        self.burgerMenu = burgerMenu
        self.activity = activity
        self.listing = listing
        self.mobileCheck = mobileCheck
    }
}
