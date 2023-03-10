//
//  IconographyCategoriesDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public struct IconographyCategoriesDefault: IconographyCategories {

    // MARK: - Properties

    public let apartment: IconographyImage
    public let vehicles: IconographyImage
    public let couch: IconographyImage
    public let equipment: IconographyImage
    public let hobby: IconographyImage
    public let ground: IconographyImage
    public let holidays: IconographyImage
    public let land: IconographyImage
    public let clothes: IconographyImage
    public let dress: IconographyImage
    public let baby: IconographyImage
    public let multimedia: IconographyImage
    public let parking: IconographyImage
    public let house: IconographyImage
    public let service: IconographyImage
    public let job: IconographyImage
    public let pets: IconographyImage
    public let computer: IconographyImage

    // MARK: - Initialization

    public init(apartment: IconographyImage,
                vehicles: IconographyImage,
                couch: IconographyImage,
                equipment: IconographyImage,
                hobby: IconographyImage,
                ground: IconographyImage,
                holidays: IconographyImage,
                land: IconographyImage,
                clothes: IconographyImage,
                dress: IconographyImage,
                baby: IconographyImage,
                multimedia: IconographyImage,
                parking: IconographyImage,
                house: IconographyImage,
                service: IconographyImage,
                job: IconographyImage,
                pets: IconographyImage,
                computer: IconographyImage) {
        self.apartment = apartment
        self.vehicles = vehicles
        self.couch = couch
        self.equipment = equipment
        self.hobby = hobby
        self.ground = ground
        self.holidays = holidays
        self.land = land
        self.clothes = clothes
        self.dress = dress
        self.baby = baby
        self.multimedia = multimedia
        self.parking = parking
        self.house = house
        self.service = service
        self.job = job
        self.pets = pets
        self.computer = computer
    }
}
