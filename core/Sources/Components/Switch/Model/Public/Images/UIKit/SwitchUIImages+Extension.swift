//
//  SwitchUIImages+Extension.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 26/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

extension Optional where Wrapped == SwitchUIImages {

    // MARK: - Conversion

    var either: SwitchImagesEither? {
        guard let self else {
            return nil
        }

        return .left(self)
    }
}
