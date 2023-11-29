//
//  ControlStateImage.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

final class ControlStateImage: ObservableObject {

    // MARK: - Public Published Properties

    @Published var image: Image?

    // MARK: - Private Properties

    private let imageStates = ControlPropertyStates<Image>()

    // MARK: - Setter

    /// Set the image for a state.
    /// - parameter image: new image
    /// - parameter state: state of the image
    /// - parameter control: the parent control
    func setImage(
        _ image: Image?,
        for state: ControlState,
        on control: Control
    ) {
        self.imageStates.setValue(image, for: state)
        self.updateContent(from: control)
    }

    // MARK: - Update UI

    /// Update the label (image or attributed) for a parent control state.
    /// - parameter control: the parent control
    func updateContent(from control: Control) {
        // Create the status from the control
        let status = ControlStatus(
            isHighlighted: control.isPressed,
            isEnabled: !control.isDisabled,
            isSelected: control.isSelected
        )

        self.image = self.imageStates.value(for: status)
    }
}
