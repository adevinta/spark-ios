//
//  ControlPropertyState.swift
//  SparkCore
//
//  Created by robin.lemaire on 25/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// Contains the dynamic property for a ControlState.
final class ControlPropertyState<T: Equatable> {

    // MARK: - Properties

    var value: T?
    private let state: ControlState

    // MARK: - Initialization

    /// Init the object with a state. The value is nil by default.
    init(for state: ControlState) {
        self.state = state
    }
}
