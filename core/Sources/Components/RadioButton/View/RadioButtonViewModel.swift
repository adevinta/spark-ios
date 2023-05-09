//
//  RadioButtonViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 11.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
/// The RadioButtonViewModel is a view model used by the ``RadioButtonView`` to handle theming logic and state changes.
/// The model is created providing:
/// -
/// - theming: A struct containg `state` and `theme` of the radion button.
/// -
final class RadioButtonViewModel<ID: Equatable & CustomStringConvertible>: ObservableObject {
    // MARK: - Injected Properties

    @Published var label: String
    let id: ID

    private let useCase: GetRadioButtonColorsUseCaseable

    var theme: Theme {
        didSet {
            self.themeDidUpdate()
        }
    }
    var state: SparkSelectButtonState {
        didSet {
            self.stateDidUpdate()
        }
    }
    
    @Binding var selectedID: ID {
        didSet {
            self.updateColors()
        }
    }

    // MARK: - Published Properties

    @Published var colors: RadioButtonColorables
    @Published var isDisabled: Bool
    @Published var suplementaryText: String?
    @Published var opacity: CGFloat
    @Published var spacing: CGFloat
    @Published var font: TypographyFontToken
    @Published var suplemetaryFont: TypographyFontToken
    @Published var surfaceColor: ColorToken

    // MARK: - Initialization

    convenience init(theme: Theme,
                     id: ID,
                     label: String,
                     selectedID: Binding<ID>,
                     state: SparkSelectButtonState) {
        let useCase = GetRadioButtonColorsUseCase()
        self.init(theme: theme,
                  id: id,
                  label: label,
                  selectedID: selectedID,
                  state: state,
                  useCase: useCase)
        }

    init(theme: Theme,
         id: ID,
         label: String,
         selectedID: Binding<ID>,
         state: SparkSelectButtonState,
         useCase: GetRadioButtonColorsUseCase) {
        self.theme = theme
        self.id = id
        self.label = label
        self._selectedID = selectedID
        self.useCase = useCase
        self.state = state

        self.isDisabled = self.state == .disabled
        self.suplementaryText = self.state.suplementaryText

        self.opacity = self.theme.opacity(state: self.state)
        self.spacing = self.theme.layout.spacing.medium
        self.font =  self.theme.typography.body1
        self.suplemetaryFont = self.theme.typography.caption
        self.surfaceColor = self.theme.colors.base.onSurface

        self.colors = useCase
            .execute(theme: theme, state: self.state, isSelected: selectedID.wrappedValue == id)
    }

    // MARK: - Functions

    func setSelected() {
        self.selectedID = self.id
    }

    // MARK: - Private Functions

    private func updateColors() {
        self.colors = useCase
            .execute(theme: self.theme, state: self.state, isSelected: selectedID == id)
    }

    private func stateDidUpdate() {
        self.isDisabled = self.state == .disabled
        self.suplementaryText = self.state.suplementaryText
        self.updateColors()
    }

    private func themeDidUpdate() {
        self.opacity = self.theme.opacity(state: self.state)
        self.spacing = self.theme.layout.spacing.medium
        self.font =  self.theme.typography.body1
        self.suplemetaryFont = self.theme.typography.caption
        self.surfaceColor = self.theme.colors.base.onSurface
        self.updateColors()
    }

}

// MARK: - Private Helpers
private extension Theme {
    func opacity(state: SparkSelectButtonState) -> CGFloat {
        switch state {
        case .disabled: return self.dims.dim3
        case .warning, .error, .success, .enabled: return 1
        }
    }
}

private extension SparkSelectButtonState {
    var suplementaryText: String? {
        switch self {
        case let .warning(message: message),
            let .error(message: message),
            let .success(message: message): return message
        case .disabled, .enabled: return nil
        }
    }
}
