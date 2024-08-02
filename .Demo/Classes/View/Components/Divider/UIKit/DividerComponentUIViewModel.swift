//
//  DividerComponentUIViewModel.swift
//  SparkDemo
//
//  Created by louis.borlee on 31/07/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine

final class DividerComponentUIViewModel: ComponentUIViewModel, ObservableObject {

    let themes = ThemeCellModel.themes

    @Published var theme: Theme
    @Published var text: String?
    @Published var intent = DividerIntent.outline
    @Published var axis = DividerAxis.horizontal
    @Published var alignment = DividerAlignment.center

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        self.showThemeSheetSubject
            .eraseToAnyPublisher()
    }
    var showIntentSheet: AnyPublisher<[DividerIntent], Never> {
        self.showIntentSheetSubject
            .eraseToAnyPublisher()
    }
    var showAxisSheet: AnyPublisher<[DividerAxis], Never> {
        self.showAxisSheetSubject
            .eraseToAnyPublisher()
    }
    var showAlignmentSheet: AnyPublisher<[DividerAlignment], Never> {
        self.showAlignmentSheetSubject
            .eraseToAnyPublisher()
    }

    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[DividerIntent], Never> = .init()
    private var showAxisSheetSubject: PassthroughSubject<[DividerAxis], Never> = .init()
    private var showAlignmentSheetSubject: PassthroughSubject<[DividerAlignment], Never> = .init()

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

    lazy var axisConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Axis",
            type: .button,
            target: (source: self, action: #selector(self.presentAxisSheet))
        )
    }()

    lazy var alignmentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Alignment",
            type: .button,
            target: (source: self, action: #selector(self.presentAlignmentSheet))
        )
    }()

    lazy var textConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Text",
            type: .input(text: self.text),
            target: (source: self, action: #selector(self.textChanged(_:))))
    }()

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.axisConfigurationItemViewModel,
            self.alignmentConfigurationItemViewModel,
            self.textConfigurationItemViewModel
        ]
    }

    init(theme: any Theme) {
        self.theme = theme
        super.init(identifier: "Divider")
    }

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(self.themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(DividerIntent.allCases)
    }

    @objc func presentAxisSheet() {
        self.showAxisSheetSubject.send(DividerAxis.allCases)
    }

    @objc func presentAlignmentSheet() {
        self.showAlignmentSheetSubject.send(DividerAlignment.allCases)
    }

    @objc func textChanged(_ textField: UITextField) {
        if textField.text?.isEmpty == false {
            self.text = textField.text
        } else  {
            self.text = nil
        }
    }
}
