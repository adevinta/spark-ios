//
//  ProgressTrackerComponentUIViewModel.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 26.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import Spark
@testable import SparkCore
import UIKit

final class ProgressTrackerComponentUIViewModel: ComponentUIViewModel {

    enum ContentType: CaseIterable {
        case icon
        case text
        case none

        var content: ProgressTrackerUIIndicatorContent {
            switch self {
            case .icon: return .init(indicatorImage: UIImage(systemName: "checkmark"))
            case .text: return .init(label: "A")
            case .none: return .init()
            }
        }
    }


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

    lazy var sizeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Size",
            type: .button,
            target: (source: self, action: #selector(self.presentSizeSheet))
        )
    }()

    lazy var contentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Content",
            type: .button,
            target: (source: self, action: #selector(self.presentContentSheet))
        )
    }()

    lazy var variantConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Variant",
            type: .button,
            target: (source: self, action: #selector(self.presentVariantSheet))
        )
    }()

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[ProgressTrackerIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showSizeSheet: AnyPublisher<[ProgressTrackerSize], Never> {
        showSizeSheetSubject
            .eraseToAnyPublisher()
    }

    var showVariantSheet: AnyPublisher<[ProgressTrackerVariant], Never> {
        showVariantSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentSheet: AnyPublisher<[ContentType], Never> {
        showContentSheetSubject
            .eraseToAnyPublisher()
    }

    let themes = ThemeCellModel.themes

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ProgressTrackerIntent], Never> = .init()
    private var showSizeSheetSubject: PassthroughSubject<[ProgressTrackerSize], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[ProgressTrackerVariant], Never> = .init()
    private var showContentSheetSubject: PassthroughSubject<[ContentType], Never> = .init()

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.sizeConfigurationItemViewModel,
            self.variantConfigurationItemViewModel,
            self.contentConfigurationItemViewModel
        ]
    }

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: ProgressTrackerIntent
    @Published var variant: ProgressTrackerVariant
    @Published var size: ProgressTrackerSize
    @Published var content: ContentType

    init(
        theme: Theme,
        intent: ProgressTrackerIntent = .main,
        variant: ProgressTrackerVariant = .tinted,
        size: ProgressTrackerSize = .medium
    ) {
        self.theme = theme
        self.intent = intent
        self.size = size
        self.content = .none
        self.variant = variant
        super.init(identifier: "Progress Tracker")
    }
}

// MARK: - Navigation
extension ProgressTrackerComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(ProgressTrackerIntent.allCases)
    }

    @objc func presentSizeSheet() {
        self.showSizeSheetSubject.send(ProgressTrackerSize.allCases)
    }

    @objc func presentVariantSheet() {
        self.showVariantSheetSubject.send(ProgressTrackerVariant.allCases)
    }

    @objc func presentContentSheet() {
        self.showContentSheetSubject.send(ContentType.allCases)
    }}
