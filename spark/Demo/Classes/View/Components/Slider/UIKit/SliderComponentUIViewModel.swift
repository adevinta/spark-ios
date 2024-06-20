//
//  SliderComponentUIViewModel.swift
//  SparkDemo
//
//  Created by louis.borlee on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class SliderComponentUIViewModel: ComponentUIViewModel, ObservableObject {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        self.showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[SliderIntent], Never> {
        self.showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showSizeSheet: AnyPublisher<[SliderShape], Never> {
        self.showShapeSheetSubject
            .eraseToAnyPublisher()
    }

    let themes = ThemeCellModel.themes

    // MARK: - Private Properties
    private let numberFormatter = NumberFormatter()

    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[SliderIntent], Never> = .init()
    private var showShapeSheetSubject: PassthroughSubject<[SliderShape], Never> = .init()

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

    lazy var isContinuousConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "IsContinuous",
            type: .toggle(isOn: self.isContinuous),
            target: (source: self, action: #selector(self.toggleIsContinuous))
        )
    }()

    lazy var isEnabledConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "IsEnabled",
            type: .toggle(isOn: self.isEnabled),
            target: (source: self, action: #selector(self.toggleIsEnabled))
        )
    }()

    lazy var valueConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Value",
            type: .input(text: "\(self.value)"),
            target: (source: self, action: #selector(self.changeValue(_:)))
        )
    }()

    lazy var minConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Minimum",
            type: .input(text: "\(self.range.lowerBound)"),
            target: (source: self, action: #selector(self.changeMin(_:)))
        )
    }()

    lazy var maxConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Maximum",
            type: .input(text: "\(self.range.upperBound)"),
            target: (source: self, action: #selector(self.changeMax(_:)))
        )
    }()

    lazy var stepConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Step",
            type: .input(text: "\(self.step ?? 0)"),
            target: (source: self, action: #selector(self.changeStep(_:)))
        )
    }()

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.shapeConfigurationItemViewModel,
            self.isContinuousConfigurationItemViewModel,
            self.isEnabledConfigurationItemViewModel,
            self.valueConfigurationItemViewModel,
            self.minConfigurationItemViewModel,
            self.maxConfigurationItemViewModel,
            self.stepConfigurationItemViewModel
        ]
    }

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: SliderIntent
    @Published var shape: SliderShape
    @Published var isContinuous: Bool
    @Published var isEnabled: Bool
    @Published var value: Float
    @Published var range: ClosedRange<Float>
    @Published var step: Float?

    init(
        theme: Theme,
        intent: SliderIntent = .basic,
        shape: SliderShape = .rounded,
        isContinuous: Bool = true,
        isEnabled: Bool = true,
        value: Float = 0.0,
        range: ClosedRange<Float> = 0...1,
        step: Float? = nil
    ) {
        self.theme = theme
        self.intent = intent
        self.shape = shape
        self.isContinuous = isContinuous
        self.isEnabled = isEnabled
        self.value = value
        self.range = range
        self.step = step

        super.init(identifier: "Slider")
    }
}

// MARK: - Navigation
extension SliderComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(self.themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(SliderIntent.allCases)
    }

    @objc func presentShapeSheet() {
        self.showShapeSheetSubject.send(SliderShape.allCases)
    }

    @objc func toggleIsContinuous() {
        self.isContinuous.toggle()
    }

    @objc func toggleIsEnabled() {
        self.isEnabled.toggle()
    }

    @objc func changeValue(_ textField: UITextField) {
        guard let text = textField.text,
              let number = self.numberFormatter.number(from: text) else { return }
        let float = Float(truncating: number)
        self.value = float
    }

    @objc func changeMin(_ textField: UITextField) {
        guard let text = textField.text,
              let number = self.numberFormatter.number(from: text) else { return }
        let float = Float(truncating: number)
        guard float <= self.range.upperBound else { return }
        self.range = float...self.range.upperBound
    }

    @objc func changeMax(_ textField: UITextField) {
        guard let text = textField.text,
              let number = self.numberFormatter.number(from: text) else { return }
        let float = Float(truncating: number)
        guard self.range.lowerBound <= float else { return }
        self.range = self.range.lowerBound...float
    }

    @objc func changeStep(_ textField: UITextField) {
        guard let text = textField.text,
              let number = self.numberFormatter.number(from: text) else { return }
        let float = Float(truncating: number)
        self.step = float
    }
}
