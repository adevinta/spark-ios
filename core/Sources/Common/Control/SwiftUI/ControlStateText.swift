//
//  ControlStateText.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

final class ControlStateText: ObservableObject {

    // MARK: - Public Published Properties

    @Published var text: String?
    @Published var attributedText: AttributedString?

    // MARK: - Private Properties

    private let textStates = ControlPropertyStates<String>()
    private let attributedTextStates = ControlPropertyStates<AttributedString>()
    private let textTypesStates = ControlPropertyStates<DisplayedTextType>()

    // MARK: - Setter

    /// Set the text for a state.
    /// - parameter text: new text
    /// - parameter state: state of the text
    /// - parameter control: the parent control
    func setText(
        _ text: String?,
        for state: ControlState,
        on control: Control
    ) {
        self.textStates.setValue(text, for: state)
        self.textTypesStates.setValue(
            text != nil ? .text : DisplayedTextType.none,
            for: state
        )
        self.updateContent(from: control)
    }

    /// Set the attributed text for a state.
    /// - parameter text: new attributed text
    /// - parameter state: state of the attributed text
    /// - parameter control: the parent control
    func setAttributedText(
        _ attributedText: AttributedString?,
        for state: ControlState,
        on control: Control
    ) {
        self.attributedTextStates.setValue(attributedText, for: state)
        self.textTypesStates.setValue(
            attributedText != nil ? .attributedText : DisplayedTextType.none,
            for: state
        )
        self.updateContent(from: control)
    }

    // MARK: - Update UI

    /// Update the label (text or attributed) for a parent control state.
    /// - parameter control: the parent control
    func updateContent(from control: Control) {
        // Create the status from the control
        let status = ControlStatus(
            isHighlighted: control.isPressed,
            isEnabled: !control.isDisabled,
            isSelected: control.isSelected
        )

        // Get the current textType from status
        let textType = self.textTypesStates.value(for: status)

        // Set the text or the attributedText from textType and states
        if let text = self.textStates.value(for: status),
           textType == .text {
            self.attributedText = nil
            self.text = text

        } else if let attributedText = self.attributedTextStates.value(for: status),
                  textType == .attributedText {
            self.text = nil
            self.attributedText = attributedText

        } else { // No text to displayed
            self.text = nil
            self.attributedText = nil
        }
    }
}
