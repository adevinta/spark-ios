//
//  CheckboxViewModel.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 05.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

final class CheckboxViewModel: ObservableObject {
    
    // MARK: - Internal properties
    @Published var text: Either<NSAttributedString?, String?>
    @Published var checkedImage: UIImage
    @Published var colors: CheckboxColors
    @Published var alignment: CheckboxAlignment {
        didSet {
            self.updateSpacing()
        }
    }
    
    @Published var selectionState: CheckboxSelectionState
    @Published var opacity: CGFloat
    @Published var spacing: CGFloat
    @Published var font: TypographyFontToken

    @Published var intent: CheckboxIntent {
        didSet {
            guard oldValue != intent else { return }
            self.updateColors()
        }
    }

    var isEnabled: Bool {
        didSet {
            self.updateOpacity()
        }
    }

    var theme: Theme {
        didSet {
            self.font = self.theme.typography.body1
            self.updateColors()
            self.updateOpacity()
            self.updateSpacing()
        }
    }

    // MARK: - Private properties
    private let colorsUseCase: CheckboxColorsUseCaseable
    private let spacingUseCase: CheckboxGetSpacingUseCaseable

    // MARK: - Init

    init(
        text: Either<NSAttributedString?, String?>,
        checkedImage: UIImage,
        theme: Theme,
        intent: CheckboxIntent = .main,
        colorsUseCase: CheckboxColorsUseCaseable = CheckboxColorsUseCase(),
        spacingUseCase: CheckboxGetSpacingUseCaseable = CheckboxGetSpacingUseCase(),
        isEnabled: Bool = true,
        alignment: CheckboxAlignment = .left,
        selectionState: CheckboxSelectionState
    ) {
        self.text = text
        self.checkedImage = checkedImage
        self.theme = theme
        self.isEnabled = isEnabled
        self.colorsUseCase = colorsUseCase
        self.colors = colorsUseCase.execute(
            from: theme.colors,
            intent: intent
        )
        self.intent = intent
        self.alignment = alignment
        self.selectionState = selectionState
        self.opacity = self.isEnabled ? self.theme.dims.none : self.theme.dims.dim3
        self.spacing = spacingUseCase.execute(layoutSpacing: theme.layout.spacing, alignment: alignment)
        self.spacingUseCase = spacingUseCase
        self.font = self.theme.typography.body1
    }

    // MARK: - Methods

    private func updateColors() {
        self.colors = self.colorsUseCase.execute(
            from: self.theme.colors,
            intent: self.intent
        )
    }

    private func updateOpacity() {
        self.opacity = self.isEnabled ? self.theme.dims.none : self.theme.dims.dim3
    }
    
    private func updateSpacing() {
        self.spacing = spacingUseCase.execute(layoutSpacing: self.theme.layout.spacing, alignment: self.alignment)
    }
}
