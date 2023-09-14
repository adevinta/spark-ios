//
//  CheckboxComponentUIViewModel.swift
//  Spark
//
//  Created by alican.aycil on 14.09.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class CheckboxComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[CheckboxIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showStateSheet: AnyPublisher<[CheckboxState], Never> {
        showStateSheetSubject
            .eraseToAnyPublisher()
    }

    var showAlignmentSheet: AnyPublisher<[CheckboxAlignment], Never> {
        showAlignmentSheetSubject
            .eraseToAnyPublisher()
    }


    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[CheckboxIntent], Never> = .init()
    private var showStateSheetSubject: PassthroughSubject<[CheckboxState], Never> = .init()
    private var showAlignmentSheetSubject: PassthroughSubject<[CheckboxAlignment], Never> = .init()

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

    lazy var stateConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "State",
            type: .button,
            target: (source: self, action: #selector(self.presentStateSheet))
        )
    }()

    lazy var alignmentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Aligment",
            type: .button,
            target: (source: self, action: #selector(self.presentAlignmentSheet))
        )
    }()

    lazy var isMultilineConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Multiline Text",
            type: .toggle(isOn: self.isMultilineText),
            target: (source: self, action: #selector(self.toggleIsMultilineText))
        )
    }()

    var identifier: String = "Checkbox"

    lazy var configurationViewModel: ComponentsConfigurationUIViewModel = {
        return .init(itemsViewModel: [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.stateConfigurationItemViewModel,
            self.alignmentConfigurationItemViewModel,
            self.isMultilineConfigurationItemViewModel
        ])
    }()

    var themes = ThemeCellModel.themes

    // MARK: - Default Value Properties
    let image: UIImage = DemoIconography.shared.checkmark
    let text: String = "Hello World"
    let multilineText: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    let selectionState: CheckboxSelectionState

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: CheckboxIntent
    @Published var state: CheckboxState
    @Published var alignment: CheckboxAlignment
    @Published var isMultilineText: Bool

    init(
        theme: Theme,
        intent: CheckboxIntent = .main,
        state: CheckboxState = .enabled,
        selectionState: CheckboxSelectionState = .unselected,
        alignment: CheckboxAlignment = .left,
        isMultilineText: Bool = false
    ) {
        self.theme = theme
        self.intent = intent
        self.state = state
        self.selectionState = selectionState
        self.alignment = alignment
        self.isMultilineText = isMultilineText
    }
}

// MARK: - Navigation
extension CheckboxComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(CheckboxIntent.allCases)
    }

    @objc func presentStateSheet() {
        self.showStateSheetSubject.send(CheckboxState.allCases)
    }

    @objc func presentAlignmentSheet() {
        self.showAlignmentSheetSubject.send(CheckboxAlignment.allCases)
    }

    @objc func toggleIsMultilineText() {
        self.isMultilineText.toggle()
    }
}
