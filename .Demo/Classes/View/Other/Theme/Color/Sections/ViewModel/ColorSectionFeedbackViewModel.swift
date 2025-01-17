//
//  ColorSectionFeedbackViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//


struct ColorSectionFeedbackViewModel: ColorSectionViewModelable {

    // MARK: - Properties

    let name: String
    let itemViewModels: [[ColorItemViewModel]]

    // MARK: - Initialization

    init(color: ColorsFeedback) {
        self.name = "Feedback"
        self.itemViewModels = [
            [
                .init(name: "success", colorToken: color.success),
                .init(name: "onSuccess", colorToken: color.onSuccess),
                .init(name: "successContainer", colorToken: color.successContainer),
                .init(name: "onSuccessContainer", colorToken: color.onSuccessContainer),
                .init(name: "alert", colorToken: color.alert),
                .init(name: "onAlert", colorToken: color.onAlert),
                .init(name: "alertContainer", colorToken: color.alertContainer),
                .init(name: "onAlertContainer", colorToken: color.onAlertContainer),
                .init(name: "error", colorToken: color.error),
                .init(name: "onError", colorToken: color.onError),
                .init(name: "errorContainer", colorToken: color.errorContainer),
                .init(name: "onErrorContainer", colorToken: color.onErrorContainer),
                .init(name: "info", colorToken: color.info),
                .init(name: "onInfo", colorToken: color.onInfo),
                .init(name: "infoContainer", colorToken: color.infoContainer),
                .init(name: "onInfoContainer", colorToken: color.onInfoContainer),
                .init(name: "neutral", colorToken: color.neutral),
                .init(name: "onNeutral", colorToken: color.onNeutral),
                .init(name: "neutralContainer", colorToken: color.neutralContainer),
                .init(name: "onNeutralContainer", colorToken: color.onNeutralContainer)
            ]
        ]
    }
}
