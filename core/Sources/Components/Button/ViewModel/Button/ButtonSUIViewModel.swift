//
//  ButtonSUIViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 15/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

final class ButtonSUIViewModel: ButtonViewModel, ButtonMainSUIViewModel {

    // MARK: - Properties

    var controlStatus: ControlStatus = .init()

    // MARK: - Published Properties

    @Published private(set) var controlStateImage: ControlStateImage = .init()
    @Published private(set) var controlStateText: ControlStateText? = .init()
    @Published var maxWidth: CGFloat?
    @Published var frameAlignment: Alignment = .center

    // MARK: - Initialization

    init(
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        alignment: ButtonAlignment
    ) {
        super.init(
            for: .swiftUI,
            theme: theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape,
            alignment: alignment
        )
    }
}
