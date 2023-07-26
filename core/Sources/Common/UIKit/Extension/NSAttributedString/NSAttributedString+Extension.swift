//
//  NSAttributedString+Extension.swift
//  SparkCore
//
//  Created by robin.lemaire on 26/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension Optional where Wrapped == NSAttributedString {

    // MARK: - Conversion

    var either: AttributedStringEither? {
        guard let self else {
            return nil
        }

        return .left(self)
    }
}
