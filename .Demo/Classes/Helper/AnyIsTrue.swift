//
//  AnyIsTrue.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 22.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

func isTrue(_ val: Any?) -> Bool {
    guard let val = val else { return false }
    if let bool = val as? Bool {
        return bool
    }
    if let int = val as? Int {
        return int > 0
    }
    return false
}
