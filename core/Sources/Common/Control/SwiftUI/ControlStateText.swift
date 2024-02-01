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
    /// - parameter status: the status of the parent control
    func setText(
        _ text: String?,
        for state: ControlState,
        on status: ControlStatus
    ) {
        self.textStates.setValue(text, for: state)
        self.textTypesStates.setValue(
            text != nil ? .text : DisplayedTextType.none,
            for: state
        )
        self.updateContent(from: status)
    }

    /// Set the attributed text for a state.
    /// - parameter text: new attributed text
    /// - parameter state: state of the attributed text
    /// - parameter status: the status of the parent control 
    func setAttributedText(
        _ attributedText: AttributedString?,
        for state: ControlState,
        on status: ControlStatus
    ) {
        self.attributedTextStates.setValue(attributedText, for: state)
        self.textTypesStates.setValue(
            attributedText != nil ? .attributedText : DisplayedTextType.none,
            for: state
        )
        self.updateContent(from: status)
    }

    // MARK: - Update UI

    /// Update the label (text or attributed) for a parent control state.
    /// - parameter status: the status of the parent control
    func updateContent(from status: ControlStatus) {
        // Get the current textType from status
        let textType = self.textTypesStates.value(for: status)
        let textTypeContainsText = textType?.containsText ?? false

        // Set the text or the attributedText from textType and states
        if let text = self.textStates.value(for: status),
           textType == .text || !textTypeContainsText {
            self.attributedText = nil
            self.text = text

        } else if let attributedText = self.attributedTextStates.value(for: status),
                  textType == .attributedText || !textTypeContainsText {
            self.text = nil
            self.attributedText = attributedText

        } else { // No text to displayed
            self.text = nil
            self.attributedText = nil
        }
    }
}
