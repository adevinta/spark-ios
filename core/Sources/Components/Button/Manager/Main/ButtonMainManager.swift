//
//  ButtonMainManager.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// Manage the SwiftUI Button View.
class ButtonMainManager<ViewModel: ButtonMainViewModel>: ObservableObject {

    // MARK: - Properties

    let viewModel: ViewModel

    private(set) var control = Control()
    let controlStateImage: ControlStateImage

    // MARK: - Initialization

    init(
        viewModel: ViewModel,
        controlStateImage: ControlStateImage
    ) {
        self.viewModel = viewModel
        self.controlStateImage = controlStateImage
    }

    // MARK: - Update

    func updateContent() {
        self.controlStateImage.updateContent(from: self.control)
    }

    // MARK: - Setter

    func setImage(_ image: Image?, for state: ControlState) {
        self.controlStateImage.setImage(
            image,
            for: state,
            on: self.control
        )
    }

    func setIsPressed(_ isPressed: Bool) {
        self.control.isPressed = isPressed

        self.viewModel.pressedAction(isPressed)

        self.controlStateImage.updateContent(from: self.control)
    }

    func setIsDisabled(_ isDisabled: Bool) {
        self.control.isDisabled = isDisabled

        self.viewModel.set(isEnabled: !isDisabled)

        self.controlStateImage.updateContent(from: self.control)
    }

    func setIsSelected(_ isSelected: Bool) {
        self.control.isSelected = isSelected

        self.controlStateImage.updateContent(from: self.control)
    }
}
