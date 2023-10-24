//
//  RadioButtonComponentUIViewModel.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 23.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import UIKit
import SparkCore

final class RadioButtonComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[RadioButtonIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[RadioButtonIntent], Never> = .init()
    private var showLabelAlignmentSheetSubject: PassthroughSubject<[RadioButtonLabelAlignment], Never> = .init()

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

    lazy var alignmentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Trailing Label",
            type: .checkbox(title: "", isOn: self.labelAlignment == .trailing),
            target: (source: self, action: #selector(self.labelAlignmentChanged))
        )
    }()

    lazy var axisConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Vertical layout",
            type: .checkbox(title: "", isOn: self.axis == .vertical),
            target: (source: self, action: #selector(self.axisChanged))
        )
    }()

    lazy var longLabelConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Long Label",
            type: .checkbox(title: "", isOn: self.showLongLabel),
            target: (source: self, action: #selector(self.showLongLabelChanged)))
    }()

    lazy var disableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Disable",
            type: .checkbox(title: "", isOn: self.disabledIndex != nil),
            target: (source: self, action: #selector(self.disableChanged)))
    }()

    lazy var numberOfRadioButtonsConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Number of Items",
            type: .rangeSelector(selected: self.numberOfRadioButtons, range: 2...20),
            target: (source: self, action: #selector(self.numberOfRadioButtonsChanged))
        )
    }()

    var content: [RadioButtonUIItem<Int>] {
        (0...self.numberOfRadioButtons).map {
            .init(id: $0, label: self.title(at: $0))
        }
    }

    var themes = ThemeCellModel.themes

    // MARK: - Methods

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.alignmentConfigurationItemViewModel,
            self.axisConfigurationItemViewModel,
            self.longLabelConfigurationItemViewModel,
            self.disableConfigurationItemViewModel,
            self.numberOfRadioButtonsConfigurationItemViewModel
        ]
    }

    // MARK: - Inherited Properties

    let text = "Label"
    let longText = "Lorem Ipsum is dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"

    // MARK: - Published Properties
    @Published var theme: Theme
    @Published var intent: RadioButtonIntent
    @Published var showLongLabel = false
    @Published var showIcon = true
    @Published var showBadge = false
    @Published var disabledIndex: Int?
    @Published var numberOfRadioButtons = 5
    @Published var selectedRadioButton = 0
    @Published var axis: RadioButtonGroupLayout = .vertical
    @Published var labelAlignment: RadioButtonLabelAlignment = .trailing

    // MARK: - Initialization
    init(
        theme: Theme,
        intent: RadioButtonIntent = .basic
    ) {
        self.theme = theme
        self.intent = intent

        super.init(identifier: "RadioButton")
    }

    func longTitle(at index: Int) -> String {
        return " \(index + 1) - \(self.longText)"
    }

    func title(at index: Int) -> String {
        return "\(index + 1) - \(self.text) "
    }

}

// MARK: - Navigation
extension RadioButtonComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(RadioButtonIntent.allCases)
    }

    @objc func showLongLabelChanged() {
        self.showLongLabel.toggle()
    }

    @objc func disableChanged() {
        if self.disabledIndex != nil {
            self.disabledIndex = nil
        } else {
            self.disabledIndex = Int.random(in: 0..<self.numberOfRadioButtons)
        }
    }

    @objc func axisChanged() {
        self.axis = self.axis == .vertical ? .horizontal : .vertical
    }

    @objc func labelAlignmentChanged() {
        self.labelAlignment = self.labelAlignment == .leading ? .trailing : .leading
    }



    @objc func numberOfRadioButtonsChanged(_ control: NumberSelector) {
        self.numberOfRadioButtons = control.selectedValue
    }
}

