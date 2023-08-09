//
//  Array-Safe.swift
//  SparkCore
//
//  Created by michael.zimmermann on 09.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < self.endIndex else {
            return nil
        }

        return self[index]
    }
}
