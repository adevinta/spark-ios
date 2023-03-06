//
//  ColorViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SparkCore

struct ColorViewModel {

    // MARK: - Properties

    let itemViewModels: [[ColorItemViewModel]]

    // MARK: - Initialization

    init() {
        let colors = CurrentTheme.part.colors
        self.itemViewModels = [
            [
                .init(name: "primary", colorToken: colors.primary),
                .init(name: "primaryVariant", colorToken: colors.primaryVariant)
            ],

            [
                .init(name: "secondary", colorToken: colors.secondary),
                .init(name: "secondaryVariant", colorToken: colors.secondaryVariant)
            ],

            [
                .init(name: "background", colorToken: colors.background)
            ],

            [
                .init(name: "surface", colorToken: colors.surface),
                .init(name: "surfaceInverse", colorToken: colors.surfaceInverse)
            ],

            [
                .init(name: "success", colorToken: colors.success),
                .init(name: "alert", colorToken: colors.alert),
                .init(name: "error", colorToken: colors.error),
                .init(name: "info", colorToken: colors.info),
                .init(name: "neutral", colorToken: colors.neutral)
            ],

            [
                .init(name: "primaryContainer", colorToken: colors.primaryContainer),
                .init(name: "secondaryContainer", colorToken: colors.secondaryContainer),
                .init(name: "successContainer", colorToken: colors.successContainer),
                .init(name: "alertContainer", colorToken: colors.alertContainer),
                .init(name: "errorContainer", colorToken: colors.errorContainer),
                .init(name: "infoContainer", colorToken: colors.infoContainer),
                .init(name: "neutralContainer", colorToken: colors.neutralContainer)
            ]
        ]
    }
}
