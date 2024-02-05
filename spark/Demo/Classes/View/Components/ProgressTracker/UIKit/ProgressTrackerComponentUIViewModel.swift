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
        static let numberOfPages = 4
    }

    enum ContentType: CaseIterable {
        case page
        case icon
        case text
        case none

        func makeContent(currentPageIndex: Int = 0) -> ProgressTrackerContent<ProgressTrackerUIIndicatorContent> {
            let startingValue = Int(("A" as UnicodeScalar).value)

            switch self {
            case .icon: var content: ProgressTrackerContent<ProgressTrackerUIIndicatorContent> = .init(
                numberOfPages: Constants.numberOfPages,
                currentPageIndex: currentPageIndex,
                showDefaultPageNumber: false)

                for i in 0..<Constants.numberOfPages {
                    content.setIndicatorImage(UIImage.standardImage(at: i), atIndex: i)
                }
                return content

            case .text: var content: ProgressTrackerContent<ProgressTrackerUIIndicatorContent> =
                    .init(
                        numberOfPages: Constants.numberOfPages,
                        currentPageIndex: currentPageIndex,
                        showDefaultPageNumber: false
                    )
                for i in 0..<Constants.numberOfPages {
                    content.setIndicatorLabel(Character(UnicodeScalar(i + startingValue)!), atIndex: i)
                }
                return content
            case .none: return .init(numberOfPages: Constants.numberOfPages, showDefaultPageNumber: false)
            case .page: return .init(numberOfPages: Constants.numberOfPages, showDefaultPageNumber: true)
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

    lazy var orientationConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Orientation",
            type: .button,
            target: (source: self, action: #selector(self.presentOrientationSheet))
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

    lazy var labelContentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Label",
            type: .input(text: self.label),
            target: (source: self, action: #selector(self.labelChanged(_:))))
    }()

    lazy var labelsConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Labels",
            type: .checkbox(title: "", isOn: self.showLabels),
            target: (source: self, action: #selector(self.showLabelsChanged(_:))))
    }()

    lazy var touchableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Touchable",
            type: .checkbox(title: "", isOn: self.isTouchable),
            target: (source: self, action: #selector(self.touchableChanged(_:))))
    }()

    lazy var currentPageIndexConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Current Page",
            type: .rangeSelector(
                selected: self.selectedPageIndex,
                range: 0...Constants.numberOfPages
            ),
            target: (source: self, action: #selector(self.selectedPageChanged(_:))))
    }()

    private var label: String? = "Lore Ipsum" {
        didSet {
            self.title = self.label
        }
    }

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        self.showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[ProgressTrackerIntent], Never> {
        self.showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showOrientationSheet: AnyPublisher<[ProgressTrackerOrientation], Never> {
        self.showOrientationSheetSubject
            .eraseToAnyPublisher()
    }

    var showSizeSheet: AnyPublisher<[ProgressTrackerSize], Never> {
        self.showSizeSheetSubject
            .eraseToAnyPublisher()
    }

    var showVariantSheet: AnyPublisher<[ProgressTrackerVariant], Never> {
        self.showVariantSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentSheet: AnyPublisher<[ContentType], Never> {
        self.showContentSheetSubject
            .eraseToAnyPublisher()
    }

    let themes = ThemeCellModel.themes

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ProgressTrackerIntent], Never> = .init()
    private var showOrientationSheetSubject: PassthroughSubject<[ProgressTrackerOrientation], Never> = .init()
    private var showSizeSheetSubject: PassthroughSubject<[ProgressTrackerSize], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[ProgressTrackerVariant], Never> = .init()
    private var showContentSheetSubject: PassthroughSubject<[ContentType], Never> = .init()

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.sizeConfigurationItemViewModel,
            self.variantConfigurationItemViewModel,
            self.orientationConfigurationItemViewModel,
            self.contentConfigurationItemViewModel,
            self.disableConfigurationItemViewModel,
            self.touchableConfigurationItemViewModel,
            self.currentPageIndexConfigurationItemViewModel,
            self.labelContentConfigurationItemViewModel,
            self.labelsConfigurationItemViewModel
        ]
    }

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: ProgressTrackerIntent
    @Published var orientation: ProgressTrackerOrientation = .horizontal
    @Published var variant: ProgressTrackerVariant
    @Published var size: ProgressTrackerSize
    @Published var content: ContentType
    @Published var showPageNumber = true
    @Published var isDisabled = false
    @Published var isTouchable = true
    @Published var showLabels = true
    @Published var title: String? = "Lore ipsum"
    @Published var selectedPageIndex: Int = 0

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

    @objc func presentOrientationSheet() {
        self.showOrientationSheetSubject.send(ProgressTrackerOrientation.allCases)
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

    @objc func labelChanged(_ textField: UITextField) {
        if textField.text?.isEmpty == false {
            self.label = textField.text
        } else  {
            self.label = nil
        }
    }

    @objc func showLabelsChanged(_ selected: Any?) {
        self.showLabels = isTrue(selected)
    }

    @objc func touchableChanged(_ selected: Any?) {
        self.isTouchable = isTrue(selected)
    }

    @objc func selectedPageChanged(_ control: NumberSelector) {
        self.selectedPageIndex = control.selectedValue
    }
}
