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

    private var cancellables = Set<AnyCancellable>()

    @Published private(set) var backgroundColor: any ColorToken

    // BorderLayout
    @Published private(set) var borderRadius: CGFloat
    @Published private(set) var borderWidth: CGFloat

    // Spacings
    @Published private(set) var leftSpacing: CGFloat
    @Published private(set) var contentSpacing: CGFloat
    @Published private(set) var rightSpacing: CGFloat

    @Published private(set) var dim: CGFloat

    var textFieldViewModel: TextFieldViewModelForAddons

    init(theme: Theme,
         intent: TextFieldIntent,
         successImage: ImageEither,
         alertImage: ImageEither,
         errorImage: ImageEither,
         getColorsUseCase: TextFieldGetColorsUseCasable = TextFieldGetColorsUseCase(),
         getBorderLayoutUseCase: TextFieldGetBorderLayoutUseCasable = TextFieldGetBorderLayoutUseCase(),
         getSpacingsUseCase: TextFieldGetSpacingsUseCasable = TextFieldGetSpacingsUseCase()) {
        let viewModel = TextFieldViewModelForAddons(
            theme: theme,
            intent: intent,
            successImage: successImage,
            alertImage: alertImage,
            errorImage: errorImage,
            getColorsUseCase: getColorsUseCase,
            getBorderLayoutUseCase: getBorderLayoutUseCase,
            getSpacingsUseCase: getSpacingsUseCase
        )
        self.backgroundColor = viewModel.addonsBackgroundColor
        self.borderRadius = viewModel.addonsBorderWidth
        self.borderWidth = viewModel.addonsBorderWidth
        self.leftSpacing = viewModel.addonsLeftSpacing
        self.contentSpacing = viewModel.addonsContentSpacing
        self.rightSpacing = viewModel.addonsRightSpacing
        self.dim = viewModel.addonsDim

        self.textFieldViewModel = viewModel

        self.subscribe()
    }

    private func subscribe() {
        self.textFieldViewModel.$addonsBackgroundColor.subscribe(in: &self.cancellables) { [weak self] backgroundColor in
            guard let self else { return }
            self.updateIfNeeded(keyPath: \.backgroundColor, newValue: backgroundColor)
        }

        self.textFieldViewModel.$addonsLeftSpacing.subscribe(in: &self.cancellables) { [weak self] leftSpacing in
            guard let self else { return }
            self.updateIfNeeded(keyPath: \.leftSpacing, newValue: leftSpacing)
        }

        self.textFieldViewModel.$addonsContentSpacing.subscribe(in: &self.cancellables) { [weak self] contentSpacing in
            guard let self else { return }
            self.updateIfNeeded(keyPath: \.contentSpacing, newValue: contentSpacing)
        }

        self.textFieldViewModel.$addonsRightSpacing.subscribe(in: &self.cancellables) { [weak self] rightSpacing in
            guard let self else { return }
            self.updateIfNeeded(keyPath: \.rightSpacing, newValue: rightSpacing)
        }

        self.textFieldViewModel.$addonsBorderWidth.subscribe(in: &self.cancellables) { [weak self] borderWidth in
            guard let self else { return }
            self.updateIfNeeded(keyPath: \.borderWidth, newValue: borderWidth)
        }

        self.textFieldViewModel.$addonsBorderRadius.subscribe(in: &self.cancellables) { [weak self] borderRadius in
            guard let self else { return }
            self.updateIfNeeded(keyPath: \.borderRadius, newValue: borderRadius)
        }

        self.textFieldViewModel.$addonsDim.subscribe(in: &self.cancellables) { [weak self] dim in
            guard let self else { return }
            self.updateIfNeeded(keyPath: \.dim, newValue: dim)
        }

    }
}
