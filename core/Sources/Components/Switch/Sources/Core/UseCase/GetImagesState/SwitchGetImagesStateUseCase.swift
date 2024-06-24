//
//  SwitchGetImagesStateUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchGetImagesStateUseCaseable {
    func execute(isOn: Bool,
                 images: SwitchImagesEither) -> SwitchImagesState
}

struct SwitchGetImagesStateUseCase: SwitchGetImagesStateUseCaseable {

    // MARK: - Methods

    func execute(
        isOn: Bool,
        images: SwitchImagesEither
    ) -> SwitchImagesState {
        let currentImage: ImageEither
        switch images {
        case .left(let images):
            currentImage = .left(isOn ? images.on : images.off)
        case .right(let images):
            currentImage = .right(isOn ? images.on : images.off)
        }

        return .init(
            currentImage: currentImage,
            images: images,
            onImageOpacity: isOn ? 1 : 0,
            offImageOpacity: isOn ? 0 : 1
        )
    }
}
