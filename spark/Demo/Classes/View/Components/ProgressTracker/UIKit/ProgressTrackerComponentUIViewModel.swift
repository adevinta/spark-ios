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

    lazy var interactionConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Interaction* (Size Large)",
            type: .button,
            target: (source: self, action: #selector(self.presentInteractionSheet))
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
            type: .input(text: self.title),
            target: (source: self, action: #selector(self.labelChanged(_:))))
    }()

    lazy var labelsConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Labels",
            type: .checkbox(title: "", isOn: self.showLabels),
            target: (source: self, action: #selector(self.showLabelsChanged(_:))))
    }()

    lazy var completedPageIndicatorConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Completed Page Indicator",
            type: .checkbox(title: "", isOn: self.useCompletedPageIndicator),
            target: (source: self, action: #selector(self.useCompletedPageIndicatorChanged(_:))))
    }()

    lazy var currentPageIndicatorImageConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Current Page Indicator Image",
            type: .checkbox(title: "", isOn: self.useCurrentPageIndicatorImage),
            target: (source: self, action: #selector(self.useCurrentPageIndicatorImageChanged(_:))))
    }()

    lazy var currentPageIndexConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Current Page",
            type: .rangeSelector(
                selected: self.selectedPageIndex,
                range: 0...7
            ),
            target: (source: self, action: #selector(self.selectedPageChanged(_:))))
    }()

    lazy var numberOfPagesPageIndexConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Number of Pages",
            type: .rangeSelector(
                selected: self.numberOfPages,
                range: 2...8
            ),
            target: (source: self, action: #selector(self.numberOfPagesChanged(_:))))
    }()

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

    var showInteractionSheet: AnyPublisher<[ProgressTrackerInteractionState], Never> {
        self.showInteractionSheetSubject
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
    private var showInteractionSheetSubject: PassthroughSubject<[ProgressTrackerInteractionState], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[ProgressTrackerVariant], Never> = .init()
    private var showContentSheetSubject: PassthroughSubject<[ContentType], Never> = .init()

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.sizeConfigurationItemViewModel,
            self.interactionConfigurationItemViewModel,
            self.variantConfigurationItemViewModel,
            self.orientationConfigurationItemViewModel,
            self.contentConfigurationItemViewModel,
            self.disableConfigurationItemViewModel,
            self.completedPageIndicatorConfigurationItemViewModel,
            self.currentPageIndicatorImageConfigurationItemViewModel,
            self.currentPageIndexConfigurationItemViewModel,
            self.numberOfPagesPageIndexConfigurationItemViewModel,
            self.labelContentConfigurationItemViewModel,
            self.labelsConfigurationItemViewModel
        ]
    }

    lazy var checkmarkImage = UIImage(systemName: "checkmark")

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: ProgressTrackerIntent
    @Published var orientation: ProgressTrackerOrientation = .horizontal
    @Published var variant: ProgressTrackerVariant
    @Published var size: ProgressTrackerSize
    @Published var interaction: ProgressTrackerInteractionState
    @Published var contentType: ContentType
    @Published var showPageNumber = true
    @Published var isDisabled = false
    @Published var useCompletedPageIndicator = true
    @Published var useCurrentPageIndicatorImage = false
    @Published var showLabels = true
    @Published var title: String? = "Lore"
    @Published var selectedPageIndex: Int = 0
    @Published var numberOfPages = Constants.numberOfPages

    init(
        theme: Theme,
        intent: ProgressTrackerIntent = .main,
        variant: ProgressTrackerVariant = .tinted,
        size: ProgressTrackerSize = .large
    ) {
        self.theme = theme
        self.intent = intent
        self.size = size
        self.contentType = .none
        self.variant = variant
        self.interaction = size.interaction
        super.init(identifier: "Progress Tracker")
    }

    func title(at index: Int) -> String? {
        return self.title.map{"\($0)-\(index)"}
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

    @objc func presentInteractionSheet() {
        self.showInteractionSheetSubject.send(ProgressTrackerInteractionState.allCases)
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
            self.title = textField.text
        } else  {
            self.title = nil
        }
    }

    @objc func showLabelsChanged(_ selected: Any?) {
        self.showLabels = isTrue(selected)
    }

    @objc func selectedPageChanged(_ control: NumberSelector) {
        self.selectedPageIndex = control.selectedValue
    }

    @objc func numberOfPagesChanged(_ control: NumberSelector) {
        self.numberOfPages = control.selectedValue
    }

    @objc func useCompletedPageIndicatorChanged(_ selected: Any?) {
        self.useCompletedPageIndicator = isTrue(selected)
    }

    @objc func useCurrentPageIndicatorImageChanged(_ selected: Any?) {
        self.useCurrentPageIndicatorImage = isTrue(selected)
    }
}

extension String {
    func character(at index: Int) -> Character {
        self.characters[index]
    }

    var characters: [Character] {
        return Array(self)
    }
}

private extension ProgressTrackerSize {
    var interaction: ProgressTrackerInteractionState {
        switch self {
        case .large: return .discrete
        default: return .none
        }
    }
}
