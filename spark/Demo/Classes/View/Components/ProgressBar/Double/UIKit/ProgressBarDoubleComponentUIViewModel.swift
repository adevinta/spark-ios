//
//  ProgressBarDoubleComponentUIViewModel.swift
//  Spark
//
//  Created by robin.lemaire on 25/09/2023.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class ProgressBarDoubleComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Type Alias

    private typealias Constants = ProgressBarConstants

    // MARK: - Published Properties

    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[ProgressBarDoubleIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showShapeSheet: AnyPublisher<[ProgressBarShape], Never> {
        showShapeSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ProgressBarDoubleIntent], Never> = .init()
    private var showShapeSheetSubject: PassthroughSubject<[ProgressBarShape], Never> = .init()

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

    lazy var shapeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Shape",
            type: .button,
            target: (source: self, action: #selector(self.presentShapeSheet))
        )
    }()

    lazy var topValueConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Top Value",
            type: .rangeSelectorWithConfig(
                selected: self.topValue,
                range: Constants.IndicatorValue.range,
                stepper: Constants.IndicatorValue.stepper,
                numberFormatter: Constants.IndicatorValue.numberFormatter
            ),
            target: (source: self, action: #selector(self.topValueChanged)))
    }()

    lazy var bottomValueConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Bottom Value",
            type: .rangeSelectorWithConfig(
                selected: self.bottomValue,
                range: Constants.IndicatorValue.range,
                stepper: Constants.IndicatorValue.stepper,
                numberFormatter: Constants.IndicatorValue.numberFormatter
            ),
            target: (source: self, action: #selector(self.bottomValueChanged)))
    }()

    // MARK: - Methods

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return  [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.shapeConfigurationItemViewModel,
            self.topValueConfigurationItemViewModel,
            self.bottomValueConfigurationItemViewModel
        ]
    }

    // MARK: - Default Value Properties

    let themes = ThemeCellModel.themes

    @Published var theme: Theme
    @Published var intent: ProgressBarDoubleIntent
    @Published var shape: ProgressBarShape
    @Published var topValue: Int
    @Published var bottomValue: Int

    // MARK: - Initialization

    init(
        theme: Theme,
        intent: ProgressBarDoubleIntent = .main,
        shape: ProgressBarShape = .square,
        topValue: Int = Constants.IndicatorValue.default,
        bottomValue: Int = Constants.IndicatorValue.bottomDefault
    ) {
        self.theme = theme
        self.intent = intent
        self.shape = shape
        self.topValue = topValue
        self.bottomValue = bottomValue

        super.init(identifier: "Double ProgressBar")
    }
}

// MARK: - Navigation

extension ProgressBarDoubleComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(self.themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(ProgressBarDoubleIntent.allCases)
    }

    @objc func presentShapeSheet() {
        self.showShapeSheetSubject.send(ProgressBarShape.allCases)
    }

    @objc func topValueChanged(_ control: NumberSelector) {
        self.topValue = control.selectedValue
    }

    @objc func bottomValueChanged(_ control: NumberSelector) {
        self.bottomValue = control.selectedValue
    }
}
