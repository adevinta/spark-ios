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

    private var formerSelecteID: ID?
    private let useCase: RadioButtonGetAttributesUseCaseable

    var theme: Theme
    var intent: RadioButtonIntent

    private(set) var state: RadioButtonStateAttribute

    @Binding private (set) var selectedID: ID?

    // MARK: - Published Properties

    @Published var colors: RadioButtonColors
    @Published var isDisabled: Bool
    @Published var opacity: CGFloat
    @Published var spacing: CGFloat
    @Published var font: TypographyFontToken
    @Published var alignment: RadioButtonLabelAlignment

    // MARK: - Initialization
    convenience init(theme: Theme,
                     intent: RadioButtonIntent,
                     id: ID,
                     label: Either<NSAttributedString?, String?>,
                     selectedID: Binding<ID?>,
                     alignment: RadioButtonLabelAlignment = .trailing) {

        self.init(theme: theme,
                  intent: intent,
                  id: id,
                  label: label,
                  selectedID: selectedID,
                  alignment: alignment,
                  useCase: RadioButtonGetAttributesUseCase())
    }

    init(theme: Theme,
         intent: RadioButtonIntent,
         id: ID,
         label: Either<NSAttributedString?, String?>,
         selectedID: Binding<ID?>,
         alignment: RadioButtonLabelAlignment,
         useCase: RadioButtonGetAttributesUseCaseable) {
        self.theme = theme
        self.intent = intent
        self.id = id
        self.label = label
        self._selectedID = selectedID
        self.useCase = useCase
        self.alignment = alignment
        self.formerSelecteID = selectedID.wrappedValue

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

    func set(selected: Bool) {
        if selected, self.id == self.selectedID {
            return
        } else if !selected, self.id != self.selectedID {
            return
        }

        if selected {
            self.formerSelecteID = self.selectedID
            self.selectedID = self.id
        } else {
            self.selectedID = self.formerSelecteID
        }
        self.updateViewAttributes()
    }

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
    }

    // MARK: - Private Functions

    private func intentDidUpdate() {
        self.updateViewAttributes()
    }

    private func themeDidUpdate() {
        self.updateViewAttributes()
    }

    private func alignmentDidUpdate() {
        self.updateViewAttributes()
    }
}

