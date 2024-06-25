//
//  IconButtonViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 13/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

class IconButtonViewModel: ButtonMainViewModel {

    // MARK: - Initialization

    init(
        for frameworkType: FrameworkType,
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape
    ) {
        super.init(
            for: frameworkType,
            type: .iconButton,
            theme: theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape
        )
    }
}
