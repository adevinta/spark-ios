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

    var state = RadioButtonStateAttribute(isSelected: false, isEnabled: true)

    @Binding private (set) var selectedID: ID

    // MARK: - Published Properties

    @Published var colors: RadioButtonColors
    @Published var isDisabled: Bool
    @Published var opacity: CGFloat
    @Published var spacing: CGFloat
    @Published var font: TypographyFontToken
    @Published var alignment: RadioButtonLabelAlignment

    // MARK: - Initialization

//    @available(*, deprecated, message: "Use init with intent instead.")
//    convenience init(theme: Theme,
//                     id: ID,
//                     label: Either<NSAttributedString?, String?>,
//                     selectedID: Binding<ID>,
//                     groupState: RadioButtonGroupState,
//                     alignment: RadioButtonLabelAlignment = .trailing) {
//        let useCase = RadioButtonGetAttributesUseCase()
//        self.init(theme: theme,
//                  intent: .basic,
//                  id: id,
//                  label: label,
//                  selectedID: selectedID,
//                  labelPosition: labelPosition,
//                  useCase: useCase)
//
//        if groupState == .disabled {
//            self.state = self.state.update(\.isEnabled, value: false)
//        }
//    }

    convenience init(theme: Theme,
                     intent: RadioButtonIntent,
                     id: ID,
                     label: Either<NSAttributedString?, String?>,
                     selectedID: Binding<ID>,
                     alignment: RadioButtonLabelAlignment = .trailing) {

        self.init(theme: theme,
                  intent: intent,
                  id: id,
                  label: label,
                  selectedID: selectedID,
                  alignment: alignment,
                  useCase:RadioButtonGetAttributesUseCase())
    }

    init(theme: Theme,
         intent: RadioButtonIntent,
         id: ID,
         label: Either<NSAttributedString?, String?>,
         selectedID: Binding<ID>,
         alignment: RadioButtonLabelAlignment,
         useCase: RadioButtonGetAttributesUseCaseable) {
        self.theme = theme
        self.intent = intent
        self.id = id
        self.label = label
        self._selectedID = selectedID
        self.useCase = useCase
//        self.groupState = groupState
        self.alignment = alignment

//        self.isDisabled = self.groupState == .disabled

//        self.opacity = self.theme.opacity(state: self.groupState)
//        self.spacing = self.theme.spacing(for: labelPosition)
//        self.font = self.theme.typography.body1
//        self.surfaceColor = self.theme.colors.base.onSurface
//
//        self.colors = useCase
//            .execute(theme: theme, state: self.groupState, isSelected: selectedID.wrappedValue == id)

        let state = RadioButtonStateAttribute(isSelected: selectedID.wrappedValue == id, isEnabled: true)
        let attributes = useCase.execute(
            theme: theme,
            intent: intent,
            state: state,
            alignment: alignment)

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
        self.updateViewAttributes()
    }

    func set(theme: Theme) {
        self.theme = theme
        self.themeDidUpdate()
        self.alignmentDidUpdate()
    }

    func set(enabled: Bool) {
        guard enabled != self.state.isEnabled else { return }

        self.state = self.state.update(\.isEnabled, value: enabled)
        self.updateViewAttributes()
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

    func set(alignment: RadioButtonLabelAlignment) {
        guard self.alignment != alignment else { return }

        self.alignment = alignment
        self.alignmentDidUpdate()
    }

    func updateViewAttributes() {
        self.state = self.state.update(\.isSelected, value: self.id == self.selectedID)
        let attributes = self.useCase.execute(
            theme: self.theme,
            intent: self.intent,
            state: self.state,
            alignment: self.alignment)

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
        self.updateViewAttributes()
    }

    private func themeDidUpdate() {
//        self.font = self.theme.typography.body1
//        self.surfaceColor = self.theme.colors.base.onSurface
        self.updateViewAttributes()
    }

    private func alignmentDidUpdate() {
        self.updateViewAttributes()
//        self.spacing = self.theme.spacing(for: self.alignment)
    }
}

