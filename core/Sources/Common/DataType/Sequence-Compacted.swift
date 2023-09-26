//
//  Sequence-Compacted.swift
//  SparkCore
//
//  Created by michael.zimmermann on 31.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension Sequence {
    func compacted<ElementOfResult>() -> [ElementOfResult] where Element == ElementOfResult?  {
        return self.compactMap { $0 }
    }
}
