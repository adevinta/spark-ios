//
//  IconographySectionViewModelHelper.swift
//  SparkDemo
//
//  Created by robin.lemaire on 13/03/2023.
//

import SparkCore

enum IconographySectionViewModelHelper {

    static func makeFilledAndOutlineViewModels(name: String,
                                             iconography: IconographyFilled & IconographyOutlined) -> [IconographyItemViewModel] {
        return [
            .init(name: Self.makeNameViewModel(from: name, typeName: "filled"),
                  iconographyImage: iconography.filled),
            .init(name:  Self.makeNameViewModel(from: name, typeName: "outlined"),
                  iconographyImage: iconography.outlined)
        ]
    }

    static func makeLeftAndRightViewModels(name: String,
                                           iconography: IconographyLeft & IconographyRight) -> [IconographyItemViewModel] {
        return [
            .init(name:  Self.makeNameViewModel(from: name, typeName: "left"),
                  iconographyImage: iconography.left),
            .init(name:  Self.makeNameViewModel(from: name, typeName: "right"),
                  iconographyImage: iconography.right)
        ]
    }

    static func makeUpAndDownViewModels(name: String,
                                        iconography: IconographyUp & IconographyDown) -> [IconographyItemViewModel] {
        return [
            .init(name:  Self.makeNameViewModel(from: name, typeName: "up"),
                  iconographyImage: iconography.up),
            .init(name:  Self.makeNameViewModel(from: name, typeName: "down"),
                  iconographyImage: iconography.down)
        ]
    }

    static func makeVerticalAndHorizontalViewModels(name: String,
                                                    iconography: IconographyVertical & IconographyHorizontal) -> [IconographyItemViewModel] {
        return [
            .init(name:  Self.makeNameViewModel(from: name, typeName: "vertical"),
                  iconographyImage: iconography.vertical),
            .init(name:  Self.makeNameViewModel(from: name, typeName: "horizontal"),
                  iconographyImage: iconography.horizontal),
        ]
    }

    private static func makeNameViewModel(from prefix: String, typeName: String) -> String {
        return prefix + " - " + typeName
    }
}
