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

    enum Constants {
        static let numberOfPages = 2
    }

    enum ContentType: CaseIterable {
        case page
        case icon
        case text
        case none

        var content: ProgressTrackerContent<ProgressTrackerUIIndicatorContent> {
            let startingValue = Int(("A" as UnicodeScalar).value)

            switch self {
            case .icon: return .init(
                numberOfPages: Constants.numberOfPages,
                currentPage: 0,
                showDefaultPageNumber: false,
                preferredIndicatorImage: UIImage(systemName: "checkmark"))
            case .text: var content: ProgressTrackerContent<ProgressTrackerUIIndicatorContent> = .init(numberOfPages: Constants.numberOfPages, currentPage: 0, showDefaultPageNumber: false)
                for i in 0..<Constants.numberOfPages {
                    content.setContentLabel(Character(UnicodeScalar(i + startingValue)!), ofIndex: i)
                }
                return content
            case .none: return .init(numberOfPages: Constants.numberOfPages, currentPage: 0, showDefaultPageNumber: false)
            case .page: return .init(numberOfPages: Constants.numberOfPages, currentPage: 0, showDefaultPageNumber: true)
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

    lazy var disableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Disable",
            type: .checkbox(title: "", isOn: self.isDisabled),
            target: (source: self, action: #selector(self.disableChanged(_:))))
    }()

    lazy var touchableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Touchable",
            type: .checkbox(title: "", isOn: self.isTouchable),
            target: (source: self, action: #selector(self.touchableChanged(_:))))
    }()

    lazy var selectedConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Selected",
            type: .checkbox(title: "", isOn: self.isSelected),
            target: (source: self, action: #selector(self.selectedChanged(_:))))
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
            self.contentConfigurationItemViewModel,
            self.disableConfigurationItemViewModel,
            self.touchableConfigurationItemViewModel,
            self.selectedConfigurationItemViewModel
        ]
    }

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: ProgressTrackerIntent
    @Published var variant: ProgressTrackerVariant
    @Published var size: ProgressTrackerSize
    @Published var content: ContentType
    @Published var showPageNumber = true
    @Published var isDisabled = false
    @Published var isTouchable = true
    @Published var isSelected = false

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
    }

    @objc func disableChanged(_ selected: Any?) {
        self.isDisabled = isTrue(selected)
    }

    @objc func touchableChanged(_ selected: Any?) {
        self.isTouchable = isTrue(selected)
    }

    @objc func selectedChanged(_ selected: Any?) {
        self.isSelected = isTrue(selected)
    }
}
