//
//  ButtonGetIsOnlyIconUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 30/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol ButtonGetIsOnlyIconUseCaseable {
    func execute(iconImage: ImageEither?,
                 containsTitle: Bool) -> Bool
}

struct ButtonGetIsOnlyIconUseCase: ButtonGetIsOnlyIconUseCaseable {

    // MARK: - Methods

    func execute(
        iconImage: ImageEither?,
        containsTitle: Bool
    ) -> Bool {
        return iconImage != nil && !containsTitle
    }
}
