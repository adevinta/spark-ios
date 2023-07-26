//
//  Image+Extension.swift
//  SparkCore
//
//  Created by robin.lemaire on 26/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

extension Optional where Wrapped == Image {

    // MARK: - Conversion

    var either: ImageEither? {
        guard let self else {
            return nil
        }

        return .right(self)
    }
}
