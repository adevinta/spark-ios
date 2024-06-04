//
//  BadgeComponentUIViewModel.swift
//  SparkDemo
//
//  Created by alican.aycil on 16.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@_spi(SI_SPI) import SparkCommon
import Spark
import UIKit

final class BadgeComponentUIViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published var theme: Theme
    @Published var intent: BadgeIntentType = .main
    @Published var size: BadgeSize = .medium
    @Published var value: Int? = 99
    @Published var format: BadgeFormat = .default
    @Published var isBorderVisible: Bool = false

    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[BadgeIntentType], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showSizeSheet: AnyPublisher<[BadgeSize], Never> {
        showSizeSheetSubject
            .eraseToAnyPublisher()
    }

    var showFormatSheet: AnyPublisher<[String], Never> {
        showFormatSheetSubject
            .eraseToAnyPublisher()
    }

    let themes = ThemeCellModel.themes

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[BadgeIntentType], Never> = .init()
    private var showSizeSheetSubject: PassthroughSubject<[BadgeSize], Never> = .init()
    private var showFormatSheetSubject: PassthroughSubject<[String], Never> = .init()


    // MARK: - Initializer
    init(theme: Theme) {
        self.theme = theme
    }
}

// MARK: - Navigation
extension BadgeComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(BadgeIntentType.allCases)
    }

    @objc func presentSizeSheet() {
        self.showSizeSheetSubject.send(BadgeSize.allCases)
    }

    @objc func presentFormatSheet() {
        self.showFormatSheetSubject.send(BadgeFormat.allNames)
    }
}

private  extension BadgeFormat {
    static var allNames: [String] = [Names.default, Names.custom, Names.overflowCounter]
 }
