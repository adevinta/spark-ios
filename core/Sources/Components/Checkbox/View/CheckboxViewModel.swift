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

    var text: String?
    var attributedText: NSAttributedString?
    var checkedImage: UIImage

    @Published var state: CheckboxState {
        didSet {
            guard oldValue != state else { return }

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

    @Published var colors: CheckboxStateColors
    @Published var alignment: CheckboxAlignment
    @Published var selectionState: CheckboxSelectionState

    var colorsUseCase: CheckboxStateColorsUseCaseable {
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
        colorsUseCase: CheckboxStateColorsUseCaseable = CheckboxStateColorsUseCase(),
        state: CheckboxState = .enabled,
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
        self.state = state
        self.colorsUseCase = colorsUseCase
        self.colors = colorsUseCase.execute(from: theme.colors, dims: theme.dims, intent: intent)
        self.intent = intent
        self.alignment = alignment
        self.selectionState = selectionState
    }

    // MARK: - Methods

    private func updateColors() {
        self.colors = self.colorsUseCase.execute(from: self.theme.colors, dims: self.theme.dims, intent: self.intent)
    }

    func update(content: Either<NSAttributedString, String>) {
        switch content {
        case .left(let attributedString):
            self.attributedText = attributedString
            self.text = attributedString.string
        case .right(let string):
            self.text = string
            self.attributedText = nil
        }
    }

    // MARK: - Computed properties

    var interactionEnabled: Bool {
        switch state {
        case .disabled:
            return false
        default:
            return true
        }
    }

    var opacity: CGFloat {
        switch self.state {
        case .disabled:
            return self.theme.dims.dim3
        default:
            return 1.0
        }
    }
}
