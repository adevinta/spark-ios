//
//  ButtonManager.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Manage the SwiftUI Button View.
final class ButtonManager: ButtonMainManager<ButtonViewModel> {

    // MARK: - Properties

    let controlStateText: ControlStateText

    // MARK: - Initialization

    init(
        viewModel: ButtonViewModel,
        controlStateText: ControlStateText,
        controlStateImage: ControlStateImage
    ) {
        self.controlStateText = controlStateText
        super.init(
            viewModel: viewModel,
            controlStateImage: controlStateImage
        )
    }

    // MARK: - Update

    override func updateContent() {
        super.updateContent()

        self.controlStateText.updateContent(from: self.controlStatus)
    }

    // MARK: - Setter

    func setTitle(_ title: String?, for state: ControlState) {
        self.controlStateText.setText(
            title,
            for: state,
            on: self.controlStatus
        )
    }

    func setAttributedTitle(_ attributedTitle: AttributedString?, for state: ControlState) {
        self.controlStateText.setAttributedText(
            attributedTitle,
            for: state,
            on: self.controlStatus
        )
    }

    override func setIsPressed(_ isPressed: Bool) {
        super.setIsPressed(isPressed)

        self.controlStateText.updateContent(from: self.controlStatus)
    }

    override func setIsDisabled(_ isDisabled: Bool) {
        super.setIsDisabled(isDisabled)

        self.controlStateText.updateContent(from: self.controlStatus)
    }

    override func setIsSelected(_ isSelected: Bool) {
        super.setIsSelected(isSelected)

        self.controlStateText.updateContent(from: self.controlStatus)
    }
}
