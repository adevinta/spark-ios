//
//  TextFieldViewModel.swift
//  Spark
//
//  Created by louis.borlee on 01/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class TextFieldViewModel: ObservableObject, Updateable {

    // Colors
    private(set) var textColorSubject: CurrentValueSubject<any ColorToken, Never>
    private(set) var textColor: any ColorToken {
        get { return self.textColorSubject.value }
        set {
            guard newValue.equals(self.textColor) == false else { return }
            self.textColorSubject.send(newValue)
            self.objectWillChange.send()
        }
    }
    private(set) var placeholderColorSubject: CurrentValueSubject<any ColorToken, Never>
    private(set) var placeholderColor: any ColorToken {
        get { return self.placeholderColorSubject.value }
        set {
            guard newValue.equals(self.placeholderColor) == false else { return }
            self.placeholderColorSubject.send(newValue)
            self.objectWillChange.send()
        }
    }
    private(set) var borderColorSubject: CurrentValueSubject<any ColorToken, Never>
    private(set) var borderColor: any ColorToken {
        get { return self.borderColorSubject.value }
        set {
            guard newValue.equals(self.borderColor) == false else { return }
            self.borderColorSubject.send(newValue)
            self.objectWillChange.send()
        }
    }
    private(set) var statusIconColorSubject: CurrentValueSubject<any ColorToken, Never>
    private(set) var statusIconColor: any ColorToken {
        get { return self.statusIconColorSubject.value }
        set {
            guard newValue.equals(self.statusIconColor) == false else { return }
            self.statusIconColorSubject.send(newValue)
            self.objectWillChange.send()
        }
    }
    private(set) var backgroundColorSubject: CurrentValueSubject<any ColorToken, Never>
    var backgroundColor: any ColorToken {
        get { return self.backgroundColorSubject.value }
        set {
            guard newValue.equals(self.backgroundColor) == false else { return }
            self.backgroundColorSubject.send(newValue)
            self.objectWillChange.send()
        }
    }

    // BorderLayout
    private(set) var borderRadiusSubject: CurrentValueSubject<CGFloat, Never>
    private(set) var borderRadius: CGFloat {
        get { return self.borderRadiusSubject.value }
        set {
            guard newValue != self.borderRadius else { return }
            self.borderRadiusSubject.send(newValue)
            self.objectWillChange.send()
        }
    }
    private(set) var borderWidthSubject: CurrentValueSubject<CGFloat, Never>
    private(set) var borderWidth: CGFloat {
        get { return self.borderWidthSubject.value }
        set {
            guard newValue != self.borderWidth else { return }
            self.borderWidthSubject.send(newValue)
            self.objectWillChange.send()
        }
    }

    // Spacings
    private(set) var leftSpacingSubject: CurrentValueSubject<CGFloat, Never>
    private(set) var leftSpacing: CGFloat {
        get { return self.leftSpacingSubject.value }
        set {
            guard newValue != self.leftSpacing else { return }
            self.leftSpacingSubject.send(newValue)
            self.objectWillChange.send()
        }
    }
    private(set) var contentSpacingSubject: CurrentValueSubject<CGFloat, Never>
    private(set) var contentSpacing: CGFloat {
        get { return self.contentSpacingSubject.value }
        set {
            guard newValue != self.contentSpacing else { return }
            self.contentSpacingSubject.send(newValue)
            self.objectWillChange.send()
        }
    }
    private(set) var rightSpacingSubject: CurrentValueSubject<CGFloat, Never>
    private(set) var rightSpacing: CGFloat {
        get { return self.rightSpacingSubject.value }
        set {
            guard newValue != self.rightSpacing else { return }
            self.rightSpacingSubject.send(newValue)
            self.objectWillChange.send()
        }
    }

    private(set) var dimSubject: CurrentValueSubject<CGFloat, Never>
    var dim: CGFloat {
        get { return self.dimSubject.value }
        set {
            guard newValue != self.dim else { return }
            self.dimSubject.send(newValue)
            self.objectWillChange.send()
        }
    }

    private(set) var fontSubject: CurrentValueSubject<any TypographyFontToken, Never>
    private(set) var font: any TypographyFontToken {
        get { return self.fontSubject.value }
        set {
            self.fontSubject.send(newValue)
            self.objectWillChange.send()
        }
    }

    private(set) var statusImageSubject: CurrentValueSubject<Either<UIImage, Image>?, Never>
    private(set) var statusImage: Either<UIImage, Image>? {
        get { return self.statusImageSubject.value }
        set {
            guard newValue != self.statusImage else { return }
            self.statusImageSubject.send(newValue)
            self.objectWillChange.send()
        }
    }

    var successImage: ImageEither //TODO: Add get/set in views
    var alertImage: ImageEither //TODO: Add get/set in views
    var errorImage: ImageEither //TODO: Add get/set in views

    let getColorsUseCase: any TextFieldGetColorsUseCasable
    let getBorderLayoutUseCase: any TextFieldGetBorderLayoutUseCasable
    let getSpacingsUseCase: any TextFieldGetSpacingsUseCasable

    var theme: Theme {
        didSet {
            self.setColors()
            self.setBorderLayout()
            self.setSpacings()
            self.setDim()
            self.setFont()
        }
    }
    var intent: TextFieldIntent {
        didSet {
            guard oldValue != self.intent else { return }
            self.setColors()
            self.setStatusImage()
        }
    }
    var borderStyle: TextFieldBorderStyle {
        didSet {
            guard oldValue != self.borderStyle else { return }
            self.setBorderLayout()
            self.setSpacings()
        }
    }

    var isFocused: Bool = false {
        didSet {
            guard oldValue != self.isFocused else { return }
            self.setColors()
            self.setBorderLayout()
        }
    }

    var isEnabled: Bool = true {
        didSet {
            guard oldValue != self.isEnabled else { return }
            self.setColors()
            self.setDim()
            self.setStatusImage()
        }
    }

    var isUserInteractionEnabled: Bool = true {
        didSet {
            guard oldValue != self.isUserInteractionEnabled else { return }
            self.setColors()
        }
    }

    init(theme: Theme,
         intent: TextFieldIntent,
         borderStyle: TextFieldBorderStyle,
         successImage: ImageEither,
         alertImage: ImageEither,
         errorImage: ImageEither,
         getColorsUseCase: any TextFieldGetColorsUseCasable = TextFieldGetColorsUseCase(),
         getBorderLayoutUseCase: any TextFieldGetBorderLayoutUseCasable = TextFieldGetBorderLayoutUseCase(),
         getSpacingsUseCase: any TextFieldGetSpacingsUseCasable = TextFieldGetSpacingsUseCase()) {
        self.theme = theme
        self.intent = intent
        self.borderStyle = borderStyle

        self.successImage = successImage
        self.alertImage = alertImage
        self.errorImage = errorImage

        self.getColorsUseCase = getColorsUseCase
        self.getBorderLayoutUseCase = getBorderLayoutUseCase
        self.getSpacingsUseCase = getSpacingsUseCase

        // Colors
        let colors = getColorsUseCase.execute(
            theme: theme,
            intent: intent,
            isFocused: self.isFocused,
            isEnabled: self.isEnabled,
            isUserInteractionEnabled: self.isUserInteractionEnabled
        )
        self.textColorSubject = .init(colors.text)
        self.placeholderColorSubject = .init(colors.placeholder)
        self.borderColorSubject = .init(colors.border)
        self.statusIconColorSubject = .init(colors.statusIcon)
        self.backgroundColorSubject = .init(colors.background)

        // BorderLayout
        let borderLayout = getBorderLayoutUseCase.execute(
            theme: theme,
            borderStyle:
                borderStyle,
            isFocused: self.isFocused)
        self.borderWidthSubject = .init(borderLayout.width)
        self.borderRadiusSubject = .init(borderLayout.radius)

        // Spacings
        let spacings = getSpacingsUseCase.execute(theme: theme, borderStyle: borderStyle)
        self.leftSpacingSubject = .init(spacings.left)
        self.contentSpacingSubject = .init(spacings.content)
        self.rightSpacingSubject = .init(spacings.right)

        self.dimSubject = .init(theme.dims.none)

        self.fontSubject = .init(theme.typography.body1)

        self.statusImageSubject = .init(nil)
        self.setStatusImage()
    }

    func setColors() {
        // Colors
        let colors = self.getColorsUseCase.execute(
            theme: self.theme,
            intent: self.intent,
            isFocused: self.isFocused,
            isEnabled: self.isEnabled,
            isUserInteractionEnabled: self.isUserInteractionEnabled
        )
        self.textColor = colors.text
        self.placeholderColor = colors.placeholder
        self.borderColor = colors.border
        self.statusIconColor = colors.statusIcon
        self.backgroundColor = colors.background
    }

    func setBorderLayout() {
        let borderLayout = self.getBorderLayoutUseCase.execute(
            theme: self.theme,
            borderStyle: self.borderStyle, //.none
            isFocused: self.isFocused
        )
        self.borderWidth = borderLayout.width
        self.borderRadius = borderLayout.radius
    }

    func setSpacings() {
        let spacings = self.getSpacingsUseCase.execute(theme: self.theme, borderStyle: self.borderStyle)
        self.leftSpacing = spacings.left
        self.contentSpacing = spacings.content
        self.rightSpacing = spacings.right
    }

    func setDim() {
        self.dim = self.isEnabled ? self.theme.dims.none : self.theme.dims.dim3
    }

    private func setFont() {
        self.font = self.theme.typography.body1
    }

    private func setStatusImage() {
        let image: ImageEither?
        if self.isEnabled {
            switch self.intent {
            case .alert:
                image = self.alertImage
            case .error:
                image = self.errorImage
            case .success:
                image = self.successImage
            default:
                image = nil
            }
        } else {
            image = nil
        }
        guard self.statusImage != image else { return }
        self.statusImage = image
    }
}
