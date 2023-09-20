//
//  ChipComponentUIViewModel.swift
//  SparkDemo
//
//  Created by alican.aycil on 24.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class ChipComponentUIViewModel: ObservableObject {

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

    let themes = ThemeCellModel.themes

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ChipIntent], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[ChipVariant], Never> = .init()

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: ChipIntent
    @Published var variant: ChipVariant
    @Published var text: String?
    @Published var icon: UIImage?
    @Published var component: UIView?
    @Published var action: (()->Void)?
    @Published var isEnabled = true

    init(
        theme: Theme,
        intent: ChipIntent = .main,
        variant: ChipVariant = .filled,
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
    }
}

// MARK: - Navigation
extension ChipComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(ChipIntent.allCases)
    }

    @objc func presentVariantSheet() {
        self.showVariantSheetSubject.send(ChipVariant.allCases)
    }
}
