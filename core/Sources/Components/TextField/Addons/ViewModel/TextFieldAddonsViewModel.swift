//
//  TextFieldAddonsViewModel.swift
//  SparkCore
//
//  Created by louis.borlee on 14/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import Combine

final class TextFieldAddonsViewModel: ObservableObject, Updateable {

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
    var borderRadius: CGFloat {
        get { return self.borderRadiusSubject.value }
        set {
            guard newValue != self.borderRadius else { return }
            self.borderRadiusSubject.send(newValue)
            self.objectWillChange.send()
        }
    }
    private(set) var borderWidthSubject: CurrentValueSubject<CGFloat, Never>
    var borderWidth: CGFloat {
        get { return self.borderWidthSubject.value }
        set {
            guard newValue != self.borderWidth else { return }
            self.borderWidthSubject.send(newValue)
            self.objectWillChange.send()
        }
    }

    // Spacings
    private(set) var leftSpacingSubject: CurrentValueSubject<CGFloat, Never>
    var leftSpacing: CGFloat {
        get { return self.leftSpacingSubject.value }
        set {
            guard newValue != self.leftSpacing else { return }
            self.leftSpacingSubject.send(newValue)
            self.objectWillChange.send()
        }
    }
    private(set) var contentSpacingSubject: CurrentValueSubject<CGFloat, Never>
    var contentSpacing: CGFloat {
        get { return self.contentSpacingSubject.value }
        set {
            guard newValue != self.contentSpacing else { return }
            self.contentSpacingSubject.send(newValue)
            self.objectWillChange.send()
        }
    }
    private(set) var rightSpacingSubject: CurrentValueSubject<CGFloat, Never>
    var rightSpacing: CGFloat {
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

    var textFieldViewModel: TextFieldViewModelForAddons

    init(theme: Theme,
         intent: TextFieldIntent,
         successImage: ImageEither,
         alertImage: ImageEither,
         errorImage: ImageEither,
         getColorsUseCase: TextFieldGetColorsUseCasable = TextFieldGetColorsUseCase(),
         getBorderLayoutUseCase: TextFieldGetBorderLayoutUseCasable = TextFieldGetBorderLayoutUseCase(),
         getSpacingsUseCase: TextFieldGetSpacingsUseCasable = TextFieldGetSpacingsUseCase()) {
        self.textFieldViewModel = .init(
            theme: theme,
            intent: intent,
            successImage: successImage,
            alertImage: alertImage,
            errorImage: errorImage,
            getColorsUseCase: getColorsUseCase,
            getBorderLayoutUseCase: getBorderLayoutUseCase,
            getSpacingsUseCase: getSpacingsUseCase
        )

        // Will be set by delegation
        self.backgroundColorSubject = .init(ColorTokenDefault.clear)
        self.borderWidthSubject = .init(0)
        self.borderRadiusSubject = .init(0)
        self.leftSpacingSubject = .init(0)
        self.contentSpacingSubject = .init(0)
        self.rightSpacingSubject = .init(0)
        self.dimSubject = .init(1.0)

        self.textFieldViewModel.delegate = self
    }
}

extension TextFieldAddonsViewModel: TextFieldViewModelForAddonsDelegate {}
