//
//  Updateable.swift
//  Spark
//
//  Created by michael.zimmermann on 25.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol Updateable {
    func update<Value>(_ keyPath: WritableKeyPath<Self, Value>, value: Value) -> Self
}

extension Updateable {
    func update<Value>(_ keyPath: WritableKeyPath<Self, Value>, value: Value) -> Self {

        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}
