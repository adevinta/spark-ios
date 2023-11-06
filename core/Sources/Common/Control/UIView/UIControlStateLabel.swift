//
//  UIControlStateLabel.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// The custom UILabel which set the correct text or attributedText from the state of the UIControl.
/// Must be used only on UIControl.
final class UIControlStateLabel: UILabel {

    // MARK: - Properties

    private let textStates = ControlPropertyStates<String>()
    private let attributedTextStates = ControlPropertyStates<NSAttributedString>()
    private let textTypesStates = ControlPropertyStates<DisplayedTextType>()

    private var storedTextFont: UIFont?
    private var storedTextColor: UIColor?

    // MARK: - Published

    @Published var isText: Bool = false

    // MARK: - Override Properties

    override var text: String? {
        didSet {
            self.isText = self.text != nil
        }
    }

    override var attributedText: NSAttributedString? {
        didSet {
            self.isText = self.attributedText != nil
        }
    }

    override var font: UIFont! {
        get {
            return super.font
        }
        set {
            // We need to store this value to put it back when a new text will be set (and not an attributedText)
            self.storedTextFont = newValue

            // Set the font only if the display text is not an attributedText.
            if !self.isAttributedDisplayed {
                super.font = newValue
            }
        }
    }

    override var textColor: UIColor! {
        get {
            return super.textColor
        }
        set {
            // We need to store this value to put it back when a new text will be set (and not an attributedText)
            self.storedTextColor = newValue

            // Set the color only if the display text is not an attributedText
            if !self.isAttributedDisplayed {
                super.textColor = newValue
            }
        }
    }

    // MARK: - Setter & Getter

    /// The text for a state.
    /// - parameter state: state of the text
    func text(for state: ControlState) -> String? {
        return self.textStates.value(forState: state)
    }

    /// Set the text for a state.
    /// - parameter text: new text
    /// - parameter state: state of the text
    /// - parameter control: the parent control
    func setText(
        _ text: String?,
        for state: ControlState,
        on control: UIControl
    ) {
        self.textStates.setValue(text, for: state)
        self.textTypesStates.setValue(
            text != nil ? .text : DisplayedTextType.none,
            for: state
        )
        self.updateContent(from: control)
    }

    /// The attributedText for a state.
    /// - parameter state: state of the attributedText
    func attributedText(for state: ControlState) -> NSAttributedString? {
        return self.attributedTextStates.value(forState: state)
    }

    /// Set the attributedText of the button for a state.
    /// - parameter attributedText: new attributedText of the button
    /// - parameter state: state of the attributedText
    func setAttributedText(
        _ attributedText: NSAttributedString?,
        for state: ControlState,
        on control: UIControl
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
    func updateContent(from control: UIControl) {
        // Create the status from the control
        let status = ControlStatus(
            isHighlighted: control.isHighlighted,
            isEnabled: control.isEnabled,
            isSelected: control.isSelected
        )

        // Get the current textType from status
        let textType = textTypesStates.value(forStatus: status)

        // Reset attributedText & text
        self.attributedText = nil
        self.text = nil

        // Set the text or the attributedText from textType and states
        switch textType {
        case .text:
            self.text = self.textStates.value(forStatus: status)
            if let storedTextFont = self.storedTextFont {
                self.font = storedTextFont
            }
            if let storedTextColor = self.storedTextColor {
                self.textColor = storedTextColor
            }
        case .attributedText:
            self.attributedText = self.attributedTextStates.value(forStatus: status)
        default:
            break
        }
    }

    // MARK: - Helpers

    /// The attributedText is displayed or not.
    private var isAttributedDisplayed: Bool {
        // There is an attributedText ?
        guard let attributedText = self.attributedText else {
            return false
        }
        
        // The attributedText contains attributes ?
        return !attributedText.attributes(at: 0, effectiveRange: nil).isEmpty
    }
}
