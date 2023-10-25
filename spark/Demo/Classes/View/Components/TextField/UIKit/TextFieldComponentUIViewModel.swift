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

    var showIntentSheet: AnyPublisher<[TextFieldIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showRightViewModeSheet: AnyPublisher<[ViewMode], Never> {
        showRightViewModeSheetSubject
            .eraseToAnyPublisher()
    }

    var showLeftViewModeSheet: AnyPublisher<[ViewMode], Never> {
        showLeftViewModeSheetSubject
            .eraseToAnyPublisher()
    }

    var showLeadingAddOnSheet: AnyPublisher<[AddOnOption], Never> {
        showLeadingAddOnSheetSubject
            .eraseToAnyPublisher()
    }

    var showTrailingAddOnSheet: AnyPublisher<[AddOnOption], Never> {
        showTrailingAddOnSheetSubject
            .eraseToAnyPublisher()
    }

    var showClearButtonModeSheet: AnyPublisher<[ViewMode], Never> {
        showClearButtonModeSheetSubject
            .eraseToAnyPublisher()
    }

    let themes = ThemeCellModel.themes

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[TextFieldIntent], Never> = .init()
    private var showLeftViewModeSheetSubject: PassthroughSubject<[ViewMode], Never> = .init()
    private var showRightViewModeSheetSubject: PassthroughSubject<[ViewMode], Never> = .init()
    private var showLeadingAddOnSheetSubject: PassthroughSubject<[AddOnOption], Never> = .init()
    private var showTrailingAddOnSheetSubject: PassthroughSubject<[AddOnOption], Never> = .init()
    private var showClearButtonModeSheetSubject: PassthroughSubject<[ViewMode], Never> = .init()

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: TextFieldIntent
    @Published var leftViewMode: ViewMode
    @Published var rightViewMode: ViewMode
    @Published var leadingAddOnOption: AddOnOption
    @Published var trailingAddOnOption: AddOnOption
    @Published var clearButtonMode: ViewMode
    @Published var text: String?
    @Published var icon: UIImage?
    @Published var component: UIView?
    @Published var action: (()->Void)?

    init(
        theme: Theme,
        intent: TextFieldIntent = .neutral,
        leftViewMode: ViewMode = .never,
        rigthViewMode: ViewMode = .never,
        leadingAddOnOption: AddOnOption = .none,
        trailingAddOnOption: AddOnOption = .none,
        clearButtonMode: ViewMode = .never,
        text: String? = "Label",
        icon: UIImage? = UIImage(imageLiteralResourceName: "alert"),
        component: UIView? = nil,
        action: (()->Void)? = nil
    ) {
        self.theme = theme
        self.intent = intent
        self.text = text
        self.icon = icon
        self.component = component
        self.action = action
        self.leftViewMode = leftViewMode
        self.rightViewMode = rigthViewMode
        self.leadingAddOnOption = leadingAddOnOption
        self.trailingAddOnOption = trailingAddOnOption
        self.clearButtonMode = clearButtonMode
    }
}

// MARK: - Navigation
extension TextFieldComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(TextFieldIntent.allCases)
    }

    @objc func presentLeftViewModeSheet() {
        self.showLeftViewModeSheetSubject.send(ViewMode.allCases)
    }

    @objc func presentRightViewModeSheet() {
        self.showRightViewModeSheetSubject.send(ViewMode.allCases)
    }

    @objc func presentLeadingAddOnSheet() {
        self.showLeadingAddOnSheetSubject.send(AddOnOption.allCases)
    }

    @objc func presentTrailingAddOnSheet() {
        self.showTrailingAddOnSheetSubject.send(AddOnOption.allCases)
    }

    @objc func buttonTapped(_ sender: UIButton) {
        sender.imageView?.transform = sender.imageView?.transform.rotated(by: CGFloat(Double.pi / 2)) ?? CGAffineTransform()
    }

    @objc func presetClearButtonModeSheet() {
        self.showClearButtonModeSheetSubject.send(ViewMode.allCases)
    }
}

public enum ViewMode: Int, CaseIterable {
    case never = 0

    case whileEditing = 1

    case unlessEditing = 2

    case always = 3
}

public enum AddOnOption: CaseIterable {
    case none
    case button
    case shortText
    case longText
}
