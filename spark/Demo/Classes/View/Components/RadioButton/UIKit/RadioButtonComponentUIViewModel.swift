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
            target: (source: self, action: #selector(self.labelAlignmentChanged(_:)))
        )
    }()

    lazy var axisConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Vertical layout",
            type: .checkbox(title: "", isOn: self.axis == .vertical),
            target: (source: self, action: #selector(self.axisChanged(_:)))
        )
    }()

    lazy var longLabelConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Long Label",
            type: .checkbox(title: "", isOn: self.showLongLabel),
            target: (source: self, action: #selector(self.showLongLabelChanged(_:))))
    }()

    lazy var attributedLabelConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Attributed Label",
            type: .checkbox(title: "", isOn: self.showAttributedLabel),
            target: (source: self, action: #selector(self.showAttributedLabelChanged(_:))))
    }()

    lazy var disableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Disable",
            type: .checkbox(title: "", isOn: self.isDisabled),
            target: (source: self, action: #selector(self.disableChanged(_:))))
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
            .init(id: $0, label: self.label(at: $0))
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
            self.attributedLabelConfigurationItemViewModel,
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
    @Published var showAttributedLabel = false
    @Published var showIcon = true
    @Published var showBadge = false
    @Published var isDisabled = false
    @Published var numberOfRadioButtons = 3
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


    func attributedLabel(at index: Int) -> NSAttributedString {
        if self.showLongLabel {
            return self.longTitleAttributed(at: index)
        } else {
            return self.shortTitleAttributed(at: index)
        }
    }

    func label(at index: Int) -> String {
        if self.showLongLabel && index == 1 {
            return self.longTitle(at: index)
        } else {
            return self.shortTitle(at: index)
        }
    }

    func longTitle(at index: Int) -> String {
        return "\(index + 1) - \(self.longText)"
    }

    func shortTitle(at index: Int) -> String {
        return "\(index + 1) - \(self.text) "
    }

    func longTitleAttributed(at index: Int) -> NSAttributedString {
        return NSAttributedStringBuilder()
            .text("\(index + 1)", color: .red)
            .text(" - ")
            .text(self.longText)
            .superscript("TM")
            .build()
    }

    func shortTitleAttributed(at index: Int) -> NSAttributedString {
        return NSAttributedStringBuilder()
            .text("\(index + 1)", color: .red)
            .text(" - ")
            .text(self.text)
            .superscript("TM")
            .build()
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

    @objc func showLongLabelChanged(_ selected: Any?) {
        self.showLongLabel = isTrue(selected)
    }

    @objc func showAttributedLabelChanged(_ selected: Any?) {
        self.showAttributedLabel = isTrue(selected)
    }

    @objc func disableChanged(_ selected: Any?) {
        self.isDisabled = isTrue(selected)
    }

    @objc func axisChanged(_ selected: Any?) {
        self.axis = isTrue(selected) ? .vertical : .horizontal
    }

    @objc func labelAlignmentChanged(_ selected: Any?) {
        self.labelAlignment = isTrue(selected) ? .trailing : .leading
    }

    @objc func numberOfRadioButtonsChanged(_ control: NumberSelector) {
        self.numberOfRadioButtons = control.selectedValue
    }
}

