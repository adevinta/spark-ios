//
//  IconographySectionDeliveryViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct IconographySectionDeliveryViewModel: IconographySectionViewModelable {

    // MARK: - Type Alias

    private typealias Helper = IconographySectionViewModelHelper

    // MARK: - Properties

    let name: String
    let itemViewModels: [[IconographyItemViewModel]]

    // MARK: - Initialization

    init(iconography: IconographyDelivery) {
        self.name = "delivery"
        self.itemViewModels = [
            Helper.makeFillAndOutlineViewModels(name: "deliveryFast", iconography: iconography.deliveryFast),
            Helper.makeFillAndOutlineViewModels(name: "deliveryHands", iconography: iconography.deliveryHands),
            Helper.makeFillAndOutlineViewModels(name: "box", iconography: iconography.box),
            Helper.makeFillAndOutlineViewModels(name: "deliveryTruck", iconography: iconography.deliveryTruck),
            Helper.makeFillAndOutlineViewModels(name: "mailClose", iconography: iconography.mailClose),
            Helper.makeFillAndOutlineViewModels(name: "mailOpen", iconography: iconography.mailOpen),
            Helper.makeFillAndOutlineViewModels(name: "delivery", iconography: iconography.delivery),
            [
                .init(name: "mondialRelay", iconographyImage: iconography.mondialRelay),
                .init(name: "colissimo", iconographyImage: iconography.colissimo),
                .init(name: "shop2Shop", iconographyImage: iconography.shop2Shop),
                .init(name: "laposte", iconographyImage: iconography.laposte)
            ]
        ]
    }
}
