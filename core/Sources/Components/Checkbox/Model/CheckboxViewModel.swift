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

    @Published var text: String?
    @Published var attributedText: NSAttributedString?
    @Published var checkedImage: UIImage
    @Published var colors: CheckboxColors
    @Published var alignment: CheckboxAlignment

    @Published var selectionState: CheckboxSelectionState {
        didSet {
            self.updateColors()
        }
    }

    @Published var isEnabled: Bool {
        didSet {
            self.updateColors()
        }
    }

    @Published var theme: Theme {
        didSet {
            self.updateColors()
        }
    }

    @Published var intent: CheckboxIntent {
        didSet {
            self.updateColors()
        }
    }


    var colorsUseCase: CheckboxColorsUseCaseable {
        didSet {
            self.updateColors()
        }
    }

    // MARK: - Init

    init(
        text: Either<NSAttributedString, String>,
        checkedImage: UIImage,
        theme: Theme,
        intent: CheckboxIntent = .main,
        colorsUseCase: CheckboxColorsUseCaseable = CheckboxColorsUseCase(),
        isEnabled: Bool = true,
        alignment: CheckboxAlignment = .left,
        selectionState: CheckboxSelectionState
    ) {
        switch text {
        case .left(let attributedString):
            self.attributedText = attributedString
            self.text = attributedString.string
        case .right(let string):
            self.attributedText = nil
            self.text = string
        }
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
    }

    // MARK: - Methods

    private func updateColors() {
        self.colors = self.colorsUseCase.execute(
            from: self.theme.colors,
            intent: self.intent
        )
    }

    func update(content: Either<NSAttributedString, String>) {
        switch content {
        case .left(let attributedString):
            self.attributedText = attributedString
        case .right(let string):
            self.text = string
        }
    }
}
