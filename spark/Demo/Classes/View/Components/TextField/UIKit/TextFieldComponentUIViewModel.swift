//
//  TextFieldComponentUIViewModel.swift
//  SparkDemo
//
//  Created by Quentin.richard on 14/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class TextFieldComponentUIViewModel: ObservableObject {
    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[ChipIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showVariantSheet: AnyPublisher<[ChipVariant], Never> {
        showVariantSheetSubject
            .eraseToAnyPublisher()
    }

    var showViewModeSheet: AnyPublisher<[ViewMode], Never> {
        showViewModeSheetSubject
            .eraseToAnyPublisher()
    }

    let themes = ThemeCellModel.themes

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ChipIntent], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[ChipVariant], Never> = .init()
    private var showViewModeSheetSubject: PassthroughSubject<[ViewMode], Never> = .init()

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: ChipIntent
    @Published var variant: ChipVariant
    @Published var viewMode: ViewMode
    @Published var text: String?
    @Published var icon: UIImage?
    @Published var component: UIView?
    @Published var action: (()->Void)?

    init(
        theme: Theme,
        intent: ChipIntent = .main,
        variant: ChipVariant = .filled,
        viewMode: ViewMode = .never,
        text: String? = "Label",
        icon: UIImage? = UIImage(imageLiteralResourceName: "alert"),
        component: UIView? = nil,
        action: (()->Void)? = nil
    ) {
        self.theme = theme
        self.intent = intent
        self.variant = variant
        self.text = text
        self.icon = icon
        self.component = component
        self.action = action
        self.viewMode = viewMode
    }
}

// MARK: - Navigation
extension TextFieldComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(ChipIntent.allCases)
    }

    @objc func presentVariantSheet() {
        self.showVariantSheetSubject.send(ChipVariant.allCases)
    }

    @objc func presentViewModeSheet() {
        self.showViewModeSheetSubject.send(ViewMode.allCases)
    }

}

public enum ViewMode: CaseIterable {
    case never
    case always
    case whileEditing
    case unlessEditing
}
