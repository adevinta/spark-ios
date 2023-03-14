//
//  IconographyAccountDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public struct IconographyAccountDefault: IconographyAccount {

    // MARK: - Properties

    public let bank: IconographyFilled & IconographyOutlined
    public let holiday: IconographyFilled & IconographyOutlined
    public let country: IconographyFilled & IconographyOutlined
    public let home: IconographyFilled & IconographyOutlined
    public let identity: IconographyFilled & IconographyOutlined
    public let key: IconographyFilled & IconographyOutlined
    public let favorite: IconographyFilled & IconographyOutlined
    public let shoppingCart: IconographyFilled & IconographyOutlined
    public let store: IconographyFilled & IconographyOutlined
    public let cv: IconographyFilled & IconographyOutlined
    public let fileOff: IconographyFilled & IconographyOutlined
    public let work: IconographyFilled & IconographyOutlined
    public let card: IconographyFilled & IconographyOutlined
    public let offer: IconographyFilled & IconographyOutlined
    public let burgerMenu: IconographyImage
    public let activity: IconographyImage
    public let listing: IconographyImage
    public let mobileCheck: IconographyImage

    // MARK: - Initialization

    public init(bank: IconographyFilled & IconographyOutlined,
                holiday: IconographyFilled & IconographyOutlined,
                country: IconographyFilled & IconographyOutlined,
                home: IconographyFilled & IconographyOutlined,
                identity: IconographyFilled & IconographyOutlined,
                key: IconographyFilled & IconographyOutlined,
                favorite: IconographyFilled & IconographyOutlined,
                shoppingCart: IconographyFilled & IconographyOutlined,
                store: IconographyFilled & IconographyOutlined,
                cv: IconographyFilled & IconographyOutlined,
                fileOff: IconographyFilled & IconographyOutlined,
                work: IconographyFilled & IconographyOutlined,
                card: IconographyFilled & IconographyOutlined,
                offer: IconographyFilled & IconographyOutlined,
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
