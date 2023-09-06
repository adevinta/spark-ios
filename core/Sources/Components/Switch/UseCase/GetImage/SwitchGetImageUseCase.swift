//
//  SwitchGetImageUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 13/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchGetImageUseCaseable {
    func execute(isOn: Bool,
                 images: SwitchImagesEither) -> ImageEither
}

struct SwitchGetImageUseCase: SwitchGetImageUseCaseable {

    // MARK: - Methods

    func execute(
        isOn: Bool,
        images: SwitchImagesEither
    ) -> ImageEither {
        switch images {
        case .left(let images):
            return .left(isOn ? images.on : images.off)
        case .right(let images):
            return .right(isOn ? images.on : images.off)
        }
    }
}
