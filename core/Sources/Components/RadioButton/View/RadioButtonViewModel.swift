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

    @Published var label: Either<NSAttributedString?, String?>
    let id: ID

    private let useCase: RadioButtonGetAttributesUseCaseable

    var theme: Theme
    var intent: RadioButtonIntent

//    private (set) var groupState: RadioButtonGroupState
    var state = RadioButtonStateAttribute(isSelected: false, isEnabled: true)

    @Binding private (set) var selectedID: ID

    // MARK: - Published Properties

    @Published var colors: RadioButtonColors
    @Published var isDisabled: Bool
    @Published var opacity: CGFloat
    @Published var spacing: CGFloat
    @Published var font: TypographyFontToken
//    @Published var surfaceColor: any ColorToken
    @Published var labelPosition: RadioButtonLabelPosition

    // MARK: - Initialization

    @available(*, deprecated, message: "Use init with intent instead.")
    convenience init(theme: Theme,
                     id: ID,
                     label: Either<NSAttributedString?, String?>,
                     selectedID: Binding<ID>,
                     groupState: RadioButtonGroupState,
                     labelPosition: RadioButtonLabelPosition = .right) {
        let useCase = RadioButtonGetAttributesUseCase()
        self.init(theme: theme,
                  intent: .basic,
                  id: id,
                  label: label,
                  selectedID: selectedID,
                  labelPosition: labelPosition,
                  useCase: useCase)

        if groupState == .disabled {
            self.state = self.state.update(\.isEnabled, value: false)
        }
    }

    convenience init(theme: Theme,
                     intent: RadioButtonIntent,
                     id: ID,
                     label: Either<NSAttributedString?, String?>,
                     selectedID: Binding<ID>,
                     labelPosition: RadioButtonLabelPosition = .right) {

        self.init(theme: theme,
                  intent: intent,
                  id: id,
                  label: label,
                  selectedID: selectedID,
                  labelPosition: labelPosition,
                  useCase: RadioButtonGetAttributesUseCase())
    }

    init(theme: Theme,
         intent: RadioButtonIntent,
         id: ID,
         label: Either<NSAttributedString?, String?>,
         selectedID: Binding<ID>,
         labelPosition: RadioButtonLabelPosition,
         useCase: RadioButtonGetAttributesUseCaseable) {
        self.theme = theme
        self.intent = intent
        self.id = id
        self.label = label
        self._selectedID = selectedID
        self.useCase = useCase
//        self.groupState = groupState
        self.labelPosition = labelPosition

//        self.isDisabled = self.groupState == .disabled

//        self.opacity = self.theme.opacity(state: self.groupState)
//        self.spacing = self.theme.spacing(for: labelPosition)
//        self.font = self.theme.typography.body1
//        self.surfaceColor = self.theme.colors.base.onSurface
//
//        self.colors = useCase
//            .execute(theme: theme, state: self.groupState, isSelected: selectedID.wrappedValue == id)

        let state = RadioButtonStateAttribute(isSelected: false, isEnabled: true)
        let attributes = useCase.execute(
            theme: theme,
            intent: intent,
            state: state,
            labelPosition: labelPosition)

        self.state = state
        self.colors = attributes.colors
        self.opacity = attributes.opacity
        self.spacing = attributes.spacing
        self.font = attributes.font
        self.isDisabled = !state.isEnabled
    }

    // MARK: - Functions

    func setSelected() {
        guard self.selectedID != self.id else { return }

        self.selectedID = self.id
        self.state = self.state.update(\.isSelected, value: true)
        self.updateColors()
    }

    func set(theme: Theme) {
        self.theme = theme
        self.themeDidUpdate()
        self.labelPositionDidUpdate()
    }

    func set(enabled: Bool) {
        guard enabled != self.state.isEnabled else { return }

        self.state = self.state.update(\.isEnabled, value: enabled)
        self.updateColors()
        self.isDisabled = !enabled
    }
//    func set(groupState: RadioButtonGroupState) {
//        if self.groupState != groupState {
//            self.groupState = groupState
//            self.stateDidUpdate()
//        }
//    }
    func set(intent: RadioButtonIntent) {
        guard intent != self.intent else { return }

        self.intent = intent
        self.intentDidUpdate()
    }

    func set(labelPosition: RadioButtonLabelPosition) {
        guard self.labelPosition != labelPosition else { return }

        self.labelPosition = labelPosition
        self.labelPositionDidUpdate()
    }

    func updateColors() {
        let attributes = useCase.execute(
            theme: self.theme,
            intent: self.intent,
            state: self.state,
            labelPosition: self.labelPosition)

        self.colors = attributes.colors
        self.opacity = attributes.opacity
        self.spacing = attributes.spacing
        self.font = attributes.font

//        self.opacity = self.theme.opacity(state: self.groupState)
//        self.colors = useCase
//            .execute(theme: self.theme, state: self.groupState, isSelected: selectedID == id)
    }

    // MARK: - Private Functions

    private func intentDidUpdate() {
        self.updateColors()
    }

    private func themeDidUpdate() {
//        self.font = self.theme.typography.body1
//        self.surfaceColor = self.theme.colors.base.onSurface
        self.updateColors()
    }

    private func labelPositionDidUpdate() {
        self.updateColors()
//        self.spacing = self.theme.spacing(for: self.labelPosition)
    }
}

