//
//  RadioButtonViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 11.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
/// The RadioButtonViewModel is a view model used by the ``RadioButtonView`` to handle theming logic and state changes.
final class RadioButtonViewModel<ID: Equatable & CustomStringConvertible>: ObservableObject {
    // MARK: - Injected Properties

    @Published var label: String
    let id: ID

    private let useCase: GetRadioButtonColorsUseCaseable

    private (set) var theme: Theme
    private (set) var state: SparkSelectButtonState

    @Binding private (set) var selectedID: ID

    // MARK: - Published Properties

    @Published var colors: RadioButtonColors
    @Published var isDisabled: Bool
    @Published var supplementaryText: String?
    @Published var opacity: CGFloat
    @Published var spacing: CGFloat
    @Published var font: TypographyFontToken
    @Published var supplemetaryFont: TypographyFontToken
    @Published var surfaceColor: ColorToken
    @Published var labelPosition: RadioButtonLabelPosition

    // MARK: - Initialization

    convenience init(theme: Theme,
                     id: ID,
                     label: String,
                     selectedID: Binding<ID>,
                     state: SparkSelectButtonState,
                     labelPosition: RadioButtonLabelPosition = .right) {
        let useCase = GetRadioButtonColorsUseCase()
        self.init(theme: theme,
                  id: id,
                  label: label,
                  selectedID: selectedID,
                  state: state,
                  labelPosition: labelPosition,
                  useCase: useCase)
        }

    init(theme: Theme,
         id: ID,
         label: String,
         selectedID: Binding<ID>,
         state: SparkSelectButtonState,
         labelPosition: RadioButtonLabelPosition,
         useCase: GetRadioButtonColorsUseCase) {
        self.theme = theme
        self.id = id
        self.label = label
        self._selectedID = selectedID
        self.useCase = useCase
        self.state = state
        self.labelPosition = labelPosition

        self.isDisabled = self.state == .disabled
        self.supplementaryText = self.state.supplementaryText

        self.opacity = self.theme.opacity(state: self.state)
        self.spacing = self.theme.spacing(for: labelPosition)
        self.font = self.theme.typography.body1
        self.supplemetaryFont = self.theme.typography.caption
        self.surfaceColor = self.theme.colors.base.onSurface

        self.colors = useCase
            .execute(theme: theme, state: self.state, isSelected: selectedID.wrappedValue == id)
    }

    // MARK: - Functions

    func setSelected() {
        if self.selectedID != self.id {
            self.selectedID = self.id
            self.updateColors()
        }
    }

    func set(theme: Theme) {
        self.theme = theme
        self.themeDidUpdate()
        self.labelPositionDidUpdate()
    }

    func set(state: SparkSelectButtonState) {
        if self.state != state {
            self.state = state
            self.stateDidUpdate()
        }
    }

    func set(labelPosition: RadioButtonLabelPosition) {
        guard self.labelPosition != labelPosition else { return }

        self.labelPosition = labelPosition
        self.labelPositionDidUpdate()
    }

    func updateColors() {
        self.colors = useCase
            .execute(theme: self.theme, state: self.state, isSelected: selectedID == id)
    }

    // MARK: - Private Functions

    private func stateDidUpdate() {
        self.isDisabled = self.state == .disabled
        self.supplementaryText = self.state.supplementaryText
        self.updateColors()
    }

    private func themeDidUpdate() {
        self.opacity = self.theme.opacity(state: self.state)
        self.font = self.theme.typography.body1
        self.supplemetaryFont = self.theme.typography.caption
        self.surfaceColor = self.theme.colors.base.onSurface
        self.updateColors()
    }

    private func labelPositionDidUpdate() {
        self.spacing = self.theme.spacing(for: self.labelPosition)
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

    func spacing(for labelPosition: RadioButtonLabelPosition) -> CGFloat {
        return labelPosition == .right ? self.layout.spacing.medium : self.layout.spacing.xxxLarge
    }
}

private extension SparkSelectButtonState {
    var supplementaryText: String? {
        switch self {
        case let .warning(message: message),
            let .error(message: message),
            let .success(message: message): return message
        case .disabled, .enabled: return nil
        }
    }
}
