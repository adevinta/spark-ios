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

    private(set) var controlStatus = ControlStatus()
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
        self.controlStateImage.updateContent(from: self.controlStatus)
    }

    // MARK: - Setter

    func setImage(_ image: Image?, for state: ControlState) {
        self.controlStateImage.setImage(
            image,
            for: state,
            on: self.controlStatus
        )
    }

    func setIsPressed(_ isPressed: Bool) {
        self.controlStatus.isHighlighted = isPressed

        self.viewModel.pressedAction(isPressed)

        self.controlStateImage.updateContent(from: self.controlStatus)
    }

    func setIsDisabled(_ isDisabled: Bool) {
        self.controlStatus.isEnabled = !isDisabled

        self.viewModel.isEnabled = !isDisabled

        self.controlStateImage.updateContent(from: self.controlStatus)
    }

    func setIsSelected(_ isSelected: Bool) {
        self.controlStatus.isSelected = isSelected

        self.controlStateImage.updateContent(from: self.controlStatus)
    }
}
