//
//  ColorSectionBaseViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//


struct ColorSectionBaseViewModel: ColorSectionViewModelable {

    // MARK: - Properties

    let name: String
    let itemViewModels: [[ColorItemViewModel]]

    // MARK: - Initialization

    init(color: ColorsBase) {
        self.name = "Base"
        self.itemViewModels = [
            [
                .init(name: "background", colorToken: color.background),
                .init(name: "onBackground", colorToken: color.onBackground),
                .init(name: "backgroundVariant", colorToken: color.backgroundVariant),
                .init(name: "onBackgroundVariant", colorToken: color.onBackgroundVariant),
                .init(name: "surface", colorToken: color.surface),
                .init(name: "onSurface", colorToken: color.onSurface),
                .init(name: "surfaceInverse", colorToken: color.surfaceInverse),
                .init(name: "onSurfaceInverse", colorToken: color.onSurfaceInverse),
                .init(name: "outline", colorToken: color.outline),
                .init(name: "outlineHigh", colorToken: color.outlineHigh),
                .init(name: "overlay", colorToken: color.overlay),
                .init(name: "onOverlay", colorToken: color.onOverlay)
            ]
        ]
    }
}
