//
//  RatingDisplayComponentUIViewModel.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class RatingDisplayComponentUIViewModel: ComponentUIViewModel {
    
    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[RatingIntent], Never> = .init()
    private var showSizeSheetSubject: PassthroughSubject<[RatingDisplaySize], Never> = .init()
    
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

    lazy var sizeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Size",
            type: .button,
            target: (source: self, action: #selector(self.presentSizeSheet))
        )
    }()
    
    lazy var ratingConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Rating",
            type: .rangeSelectorWithConfig(
                selected: Int(self.rating),
                range: 0...10,
                stepper: 1,
                numberFormatter: NumberFormatter()
                    .multipling(0.5)
                    .maximizingFractionDigits(2)
            ),
            target: (source: self, action: #selector(self.ratingChanged)))
    }()

    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[RatingIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showSizeSheet: AnyPublisher<[RatingDisplaySize], Never> {
        showSizeSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Published Properties
    @Published var theme: Theme
    @Published var intent: RatingIntent
    @Published var size: RatingDisplaySize
    @Published var rating: CGFloat = 0.0

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.sizeConfigurationItemViewModel,
            self.ratingConfigurationItemViewModel
        ]
    }

    // MARK: Initializer
    init(
        theme: Theme,
        intent: RatingIntent = .main,
        size: RatingDisplaySize = .medium
    ) {
        self.theme = theme
        self.intent = intent
        self.size = size

        super.init(identifier: "Rating Display")
    }
}

// MARK: - Navigation
extension RatingDisplayComponentUIViewModel {
    
    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }
    
    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(RatingIntent.allCases)
    }
    
    @objc func presentSizeSheet() {
        self.showSizeSheetSubject.send(RatingDisplaySize.allCases)
    }
    
    @objc func ratingChanged(_ control: NumberSelector) {
        self.rating = CGFloat(control.selectedValue) / 2.0
    }
}
