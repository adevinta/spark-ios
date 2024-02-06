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
    func updateIfNeeded<Value: Equatable>(keyPath: ReferenceWritableKeyPath<Self, Value>, newValue: Value)
    func updateIfNeeded(keyPath: ReferenceWritableKeyPath<Self, any ColorToken>, newValue: any ColorToken)
}

extension Updateable {
    func update<Value>(_ keyPath: WritableKeyPath<Self, Value>, value: Value) -> Self {

        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }

    func updateIfNeeded<Value: Equatable>(keyPath: ReferenceWritableKeyPath<Self, Value>, newValue: Value) {
        guard self[keyPath: keyPath] != newValue else { return }
        self[keyPath: keyPath] = newValue
    }

    func updateIfNeeded(keyPath: ReferenceWritableKeyPath<Self, any ColorToken>, newValue: any ColorToken) {
        guard self[keyPath: keyPath].equals(newValue) == false else { return }
        self[keyPath: keyPath] = newValue
    }
}
