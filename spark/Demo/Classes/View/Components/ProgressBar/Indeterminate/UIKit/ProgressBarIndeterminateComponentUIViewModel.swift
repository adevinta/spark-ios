//
//  ProgressBarIndeterminateComponentUIViewModel.swift
//  Spark
//
//  Created by robin.lemaire on 25/09/2023.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class ProgressBarIndeterminateComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Type Alias

    private typealias Constants = ProgressBarConstants

    // MARK: - Published Properties

    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[ProgressBarIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showShapeSheet: AnyPublisher<[ProgressBarShape], Never> {
        showShapeSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ProgressBarIntent], Never> = .init()
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

    lazy var isAnimatingConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is animated",
            type: .checkbox(title: "", isOn: self.isAnimating),
            target: (source: self, action: #selector(self.isAnimatingChanged))
        )
    }()

    lazy var cornerRadiusConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Corner Radius",
            type: .rangeSelector(
                selected: self.cornerRadius,
                range: Constants.IndicatorCornerRadius.range,
                stepper: Constants.IndicatorCornerRadius.stepper,
                conversion: Constants.IndicatorCornerRadius.conversion
            ),
            target: (source: self, action: #selector(self.cornerRadiusChanged)))
    }()

    // MARK: - Methods

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return  [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.shapeConfigurationItemViewModel,
            self.isAnimatingConfigurationItemViewModel,
            self.cornerRadiusConfigurationItemViewModel
        ]
    }

    // MARK: - Default Value Properties

    let themes = ThemeCellModel.themes

    @Published var theme: Theme
    @Published var intent: ProgressBarIntent
    @Published var shape: ProgressBarShape
    @Published var isAnimating: Bool
    @Published var cornerRadius: Int

    // MARK: - Initialization

    init(
        theme: Theme,
        intent: ProgressBarIntent = .main,
        shape: ProgressBarShape = .square,
        isAnimating: Bool = false,
        cornerRadius: Int = Constants.IndicatorCornerRadius.default
    ) {
        self.theme = theme
        self.intent = intent
        self.shape = shape
        self.isAnimating = isAnimating
        self.cornerRadius = cornerRadius

        super.init(identifier: "Indeterminate ProgressBar")
    }
}

// MARK: - Navigation

extension ProgressBarIndeterminateComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(self.themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(ProgressBarIntent.allCases)
    }

    @objc func presentShapeSheet() {
        self.showShapeSheetSubject.send(ProgressBarShape.allCases)
    }

    @objc func isAnimatingChanged() {
        self.isAnimating.toggle()
    }

    @objc func cornerRadiusChanged(_ control: NumberSelector) {
        self.cornerRadius = control.selectedValue
    }
}
