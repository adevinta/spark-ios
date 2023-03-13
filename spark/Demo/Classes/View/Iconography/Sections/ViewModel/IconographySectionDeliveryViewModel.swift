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
            Helper.makeFilledAndOutlineViewModels(name: "deliveryFast", iconography: iconography.deliveryFast),
            Helper.makeFilledAndOutlineViewModels(name: "deliveryHands", iconography: iconography.deliveryHands),
            Helper.makeFilledAndOutlineViewModels(name: "box", iconography: iconography.box),
            Helper.makeFilledAndOutlineViewModels(name: "deliveryTruck", iconography: iconography.deliveryTruck),
            Helper.makeFilledAndOutlineViewModels(name: "mailClose", iconography: iconography.mailClose),
            Helper.makeFilledAndOutlineViewModels(name: "mailOpen", iconography: iconography.mailOpen),
            Helper.makeFilledAndOutlineViewModels(name: "delivery", iconography: iconography.delivery),
            [
                .init(name: "mondialRelay", iconographyImage: iconography.mondialRelay),
                .init(name: "colissimo", iconographyImage: iconography.colissimo),
                .init(name: "shop2Shop", iconographyImage: iconography.shop2Shop),
                .init(name: "laposte", iconographyImage: iconography.laposte)
            ]
        ]
    }
}
