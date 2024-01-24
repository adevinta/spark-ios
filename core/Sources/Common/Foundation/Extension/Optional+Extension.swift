//
//  Optional+Extension.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Collection {

    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}
