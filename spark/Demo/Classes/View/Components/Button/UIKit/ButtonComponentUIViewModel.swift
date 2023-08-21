//
//  ButtonComponentUIViewModel.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class ButtonComponentUIViewModel: ObservableObject {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[ButtonIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showVariantSheet: AnyPublisher<[ButtonVariant], Never> {
        showVariantSheetSubject
            .eraseToAnyPublisher()
    }

    var showSizeSheet: AnyPublisher<[ButtonSize], Never> {
        showSizeSheetSubject
            .eraseToAnyPublisher()
    }

    var showShapeSheet: AnyPublisher<[ButtonShape], Never> {
        showShapeSheetSubject
            .eraseToAnyPublisher()
    }

    var showAlignmentSheet: AnyPublisher<[ButtonAlignment], Never> {
        showAlignmentSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentSheet: AnyPublisher<[ButtonContentDefault], Never> {
        showContentSheetSubject
            .eraseToAnyPublisher()
    }

    var themes: [ThemeCellModel] = [
        .init(title: "Spark", theme: SparkTheme()),
        .init(title: "Purple", theme: PurpleTheme())
    ]

    @Published var theme: Theme
    @Published var intent: ButtonIntent
    @Published var variant: ButtonVariant
    @Published var size: ButtonSize
    @Published var shape: ButtonShape
    @Published var alignment: ButtonAlignment
    @Published var content: ButtonContentDefault
    @Published var isEnabled: Bool
    let text: String
    let iconImage: UIImage
    let attributedText: NSAttributedString

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ButtonIntent], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[ButtonVariant], Never> = .init()
    private var showSizeSheetSubject: PassthroughSubject<[ButtonSize], Never> = .init()
    private var showShapeSheetSubject: PassthroughSubject<[ButtonShape], Never> = .init()
    private var showAlignmentSheetSubject: PassthroughSubject<[ButtonAlignment], Never> = .init()
    private var showContentSheetSubject: PassthroughSubject<[ButtonContentDefault], Never> = .init()

    // MARK: - Initialization
    init(
        text: String = "Button",
        iconImageNamed: String = "Arrow",
        theme: Theme,
        intent: ButtonIntent = .main,
        variant: ButtonVariant = .filled,
        size: ButtonSize = .medium,
        shape: ButtonShape = .rounded,
        alignment: ButtonAlignment = .leadingIcon,
        content: ButtonContentDefault = .text,
        isEnabled: Bool = true
    ) {
        self.text = text
        self.iconImage = .init(named: iconImageNamed) ?? UIImage()
        self.attributedText = .init(
            string: text,
            attributes: [
                .foregroundColor: UIColor.purple,
                .font: SparkTheme.shared.typography.body2Highlight.uiFont
            ]
        )
        self.theme = theme
        self.intent = intent
        self.variant = variant
        self.size = size
        self.shape = shape
        self.alignment = alignment
        self.content = content
        self.isEnabled = isEnabled
    }
}

// MARK: - Navigation
extension ButtonComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(ButtonIntent.allCases)
    }

    @objc func presentVariantSheet() {
        self.showVariantSheetSubject.send(ButtonVariant.allCases)
    }

    @objc func presentSizeSheet() {
        self.showSizeSheetSubject.send(ButtonSize.allCases)
    }

    @objc func presentShapeSheet() {
        self.showShapeSheetSubject.send(ButtonShape.allCases)
    }

    @objc func presentAlignmentSheet() {
        self.showAlignmentSheetSubject.send(ButtonAlignment.allCases)
    }

    @objc func presentContentSheet() {
        self.showContentSheetSubject.send(ButtonContentDefault.allCases)
    }
}

