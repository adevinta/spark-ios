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

    let themes = ThemeCellModel.themes

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[TextFieldIntent], Never> = .init()
    private var showLeftViewModeSheetSubject: PassthroughSubject<[ViewMode], Never> = .init()
    private var showRightViewModeSheetSubject: PassthroughSubject<[ViewMode], Never> = .init()

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: TextFieldIntent
    @Published var leftViewMode: ViewMode
    @Published var rightViewMode: ViewMode
    @Published var text: String?
    @Published var icon: UIImage?
    @Published var component: UIView?
    @Published var action: (()->Void)?

    init(
        theme: Theme,
        intent: TextFieldIntent = .neutral,
        leftViewMode: ViewMode = .never,
        rigthViewMode: ViewMode = .never,
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
}

public enum ViewMode: Int, CaseIterable {
    case never = 0

    case whileEditing = 1

    case unlessEditing = 2

    case always = 3
}
