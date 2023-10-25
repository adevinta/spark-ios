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
    @Published var alignment: CheckboxAlignment
    @Published var selectionState: CheckboxSelectionState
    @Published var opacity: CGFloat

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
            self.updateColors()
            self.updateOpacity()
        }
    }

    // MARK: - Private properties
    private let colorsUseCase: CheckboxColorsUseCaseable

    // MARK: - Init

    init(
        text: Either<NSAttributedString?, String?>,
        checkedImage: UIImage,
        theme: Theme,
        intent: CheckboxIntent = .main,
        colorsUseCase: CheckboxColorsUseCaseable = CheckboxColorsUseCase(),
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
}
