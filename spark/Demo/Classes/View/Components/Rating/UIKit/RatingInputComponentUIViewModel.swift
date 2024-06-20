//
//  RatingInputComponentUIViewModel.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 29.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

import Combine
import Spark
import SparkCore
import UIKit

final class RatingInputComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[RatingIntent], Never> = .init()
    var themes = ThemeCellModel.themes

    // MARK: - Items Properties
    lazy var themeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Theme",
            type: .button,
            target: (source: self, action: #selector(self.presentThemeSheet))
        )
    }()

    lazy var intentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Intent",
            type: .button,
            target: (source: self, action: #selector(self.presentIntentSheet))
        )
    }()

    lazy var ratingConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Rating",
            type: .rangeSelector(
                selected: Int(self.rating),
                range: 1...5
            ),
            target: (source: self, action: #selector(self.ratingChanged)))
    }()

    lazy var disableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Disable",
            type: .checkbox(title: "", isOn: self.isDisabled),
            target: (source: self, action: #selector(self.disableChanged(_:))))
    }()

    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[RatingIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Published Properties
    @Published var theme: Theme
    @Published var intent: RatingIntent
    @Published var rating: CGFloat = 1.0
    @Published var count: RatingStarsCount = .five
    @Published var isDisabled: Bool = false

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.ratingConfigurationItemViewModel,
            self.disableConfigurationItemViewModel
        ]
    }

    // MARK: Initializer
    init(
        theme: Theme,
        intent: RatingIntent = .main
    ) {
        self.theme = theme
        self.intent = intent

        super.init(identifier: "Rating Input")
    }
}

// MARK: - Navigation
extension RatingInputComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(RatingIntent.allCases)
    }

    @objc func ratingChanged(_ control: NumberSelector) {
        self.rating = CGFloat(control.selectedValue)
    }

    @objc func disableChanged(_ isSelected: Any?) {
        self.isDisabled = isTrue(isSelected)
    }
}
