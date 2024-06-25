//
//  ButtonMainSUIViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 15/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

// sourcery: AutoMockable
protocol ButtonMainSUIViewModel {

    // MARK: - Properties

    var controlStatus: ControlStatus { get set }
    var controlStateImage: ControlStateImage { get }
    var controlStateText: ControlStateText? { get }
}

extension ButtonMainSUIViewModel where Self: ButtonMainViewModel {

    // MARK: - Setter

    func setImage(_ image: Image?, for state: ControlState) {
        self.controlStateImage.setImage(
            image,
            for: state,
            on: self.controlStatus
        )
    }

    func setTitle(_ title: String?, for state: ControlState) {
        self.controlStateText?.setText(
            title,
            for: state,
            on: self.controlStatus
        )
    }

    func setAttributedTitle(_ attributedTitle: AttributedString?, for state: ControlState) {
        self.controlStateText?.setAttributedText(
            attributedTitle,
            for: state,
            on: self.controlStatus
        )
    }

    func setIsPressed(_ isPressed: Bool) {
        self.controlStatus.isHighlighted = isPressed

        self.pressedAction(isPressed)

        self.controlStateImage.updateContent(from: self.controlStatus)
        self.controlStateText?.updateContent(from: self.controlStatus)
    }

    func setIsDisabled(_ isDisabled: Bool) {
        self.controlStatus.isEnabled = !isDisabled

        self.isEnabled = !isDisabled

        self.controlStateImage.updateContent(from: self.controlStatus)
        self.controlStateText?.updateContent(from: self.controlStatus)
    }

    func setIsSelected(_ isSelected: Bool) {
        self.controlStatus.isSelected = isSelected

        self.controlStateImage.updateContent(from: self.controlStatus)
        self.controlStateText?.updateContent(from: self.controlStatus)
    }
}
