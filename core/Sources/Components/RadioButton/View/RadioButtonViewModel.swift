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

    let label: String
    let id: ID

    private let useCase: GetRadioButtonColorsUseCaseable
    private let theme: Theme

    var state: SparkSelectButtonState {
        didSet {
            self.updateColors()
        }
    }
    
    @Binding var selectedID: ID {
        didSet {
            self.updateColors()
        }
    }

    // MARK: - Published Properties

    @Published var colors: RadioButtonColorables

    // MARK: - Computed Properties

    var isDisabled: Bool {
        return self.state == .disabled
    }

    var opacity: CGFloat {
        return self.theme.opacity(state: self.state)
    }

    var spacing: CGFloat {
        return self.theme.layout.spacing.medium
    }

    var font: Font {
        return self.theme.typography.body1.font
    }

    var suplemetaryFont: Font {
        return self.theme.typography.caption.font
    }

    var surfaceColor: Color {
        return self.theme.colors.base.onSurface.color
    }

    var suplementaryText: String? {
        return self.state.suplementaryText
    }

    // MARK: - Initialization

    convenience init(theme: Theme,
                     id: ID,
                     label: String,
                     selectedID: Binding<ID>,
                     state: SparkSelectButtonState) {
        let useCase = GetRadioButtonColorsUseCase(theme: theme)
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

        self.colors = useCase.execute(state: state, isSelected: selectedID.wrappedValue == id)
    }

    // MARK: - Functions

    func setSelected() {
        self.selectedID = self.id
    }

    private func updateColors() {
        self.colors = useCase
            .execute(state: self.state, isSelected: selectedID == id)
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
