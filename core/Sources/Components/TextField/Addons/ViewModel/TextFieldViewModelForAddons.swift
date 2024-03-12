//
//  TextFieldViewModelForAddons.swift
//  SparkCore
//
//  Created by louis.borlee on 14/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine

// sourcery: AutoMockable
protocol TextFieldViewModelForAddonsDelegate: AnyObject {
    var backgroundColor: any ColorToken { get set }
    var borderWidth: CGFloat { get set }
    var borderRadius: CGFloat { get set }
    var leftSpacing: CGFloat { get set }
    var contentSpacing: CGFloat { get set }
    var rightSpacing: CGFloat { get set }
    var dim: CGFloat { get set }
}

final class TextFieldViewModelForAddons: TextFieldViewModel {

    override var backgroundColor: any ColorToken {
        get {
            return ColorTokenDefault.clear
        }
        set {
            self.backgroundColorForDelegate = newValue
            self.delegate?.backgroundColor = newValue
        }
    }

    override var dim: CGFloat {
        get {
            return 1.0
        }
        set {
            self.dimForDelegate = newValue
            self.delegate?.dim = newValue
        }
    }

    private var backgroundColorForDelegate: any ColorToken = ColorTokenDefault.clear
    private var borderWidthForDelegate: CGFloat = .zero
    private var borderRadiusForDelegate: CGFloat = .zero
    private var leftSpacingForDelegate: CGFloat = .zero
    private var contentSpacingForDelegate: CGFloat = .zero
    private var rightSpacingForDelegate: CGFloat = .zero
    private var dimForDelegate: CGFloat = 1.0

    weak var delegate: TextFieldViewModelForAddonsDelegate? {
        didSet {
            guard let delegate,
                  delegate !== oldValue else { return }
            delegate.backgroundColor = self.backgroundColorForDelegate
            delegate.borderWidth = self.borderWidthForDelegate
            delegate.borderRadius = self.borderRadiusForDelegate
            delegate.leftSpacing = self.leftSpacingForDelegate
            delegate.contentSpacing = self.contentSpacingForDelegate
            delegate.rightSpacing = self.rightSpacingForDelegate
            delegate.dim = self.dimForDelegate
        }
    }

    init(
        theme: Theme,
        intent: TextFieldIntent,
        successImage: ImageEither,
        alertImage: ImageEither,
        errorImage: ImageEither,
        getColorsUseCase: TextFieldGetColorsUseCasable = TextFieldGetColorsUseCase(),
        getBorderLayoutUseCase: TextFieldGetBorderLayoutUseCasable = TextFieldGetBorderLayoutUseCase(),
        getSpacingsUseCase: TextFieldGetSpacingsUseCasable = TextFieldGetSpacingsUseCase()
    ) {
        super.init(
            theme: theme,
            intent: intent,
            borderStyle: .none,
            successImage: successImage,
            alertImage: alertImage,
            errorImage: errorImage,
            getColorsUseCase: getColorsUseCase,
            getBorderLayoutUseCase: getBorderLayoutUseCase,
            getSpacingsUseCase: getSpacingsUseCase)

        self.backgroundColorForDelegate = super.backgroundColor
        self.setBorderLayout()
        self.setSpacings()
        self.dimForDelegate = super.dim
    }

    override func setBorderLayout() {
        let borderLayout = self.getBorderLayoutUseCase.execute(
            theme: self.theme,
            borderStyle: .roundedRect,
            isFocused: self.isFocused)

        self.borderWidthForDelegate = borderLayout.width
        self.borderRadiusForDelegate = borderLayout.radius

        self.delegate?.borderWidth = borderLayout.width
        self.delegate?.borderRadius = borderLayout.radius
    }

    override func setSpacings() {
        let spacings = self.getSpacingsUseCase.execute(
            theme: self.theme,
            borderStyle: .roundedRect)
        self.leftSpacingForDelegate = spacings.left
        self.contentSpacingForDelegate = spacings.content
        self.rightSpacingForDelegate = spacings.right

        self.delegate?.leftSpacing = spacings.left
        self.delegate?.contentSpacing = spacings.content
        self.delegate?.rightSpacing = spacings.right
    }
}
