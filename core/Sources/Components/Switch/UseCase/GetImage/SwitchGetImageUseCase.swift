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
    func execute(forIsOn isOn: Bool,
                 variant: SwitchVariant?) -> SwitchImageable?
}

struct SwitchGetImageUseCase: SwitchGetImageUseCaseable {

    // MARK: - Methods

    func execute(forIsOn isOn: Bool,
                 variant: SwitchVariant?) -> SwitchImageable? {
        guard let variant else {
            return nil
        }

        if isOn {
            return SwitchImage(image: variant.onImage, uiImage: variant.onUIImage)
        } else {
            return SwitchImage(image: variant.offImage, uiImage: variant.offUIImage)
        }
    }
}
