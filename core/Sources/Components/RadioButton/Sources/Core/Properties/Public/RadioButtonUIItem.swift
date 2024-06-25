//
//  RadioButtonItem.swift
//  SparkCore
//
//  Created by michael.zimmermann on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// A simple struct for defining radio buttons using the ``RadioButtonGroupView``.
public struct RadioButtonUIItem<ID: Equatable & Hashable>: Equatable & Hashable {

    // MARK: - Properties

    public let id: ID
    public let label: NSAttributedString

    // MARK: - Initialization
    /// Parameters:
    /// - id: A unique ID bound to a generic type which has the constraints that it need be ``Equatable`` & ``Hashable``.
    /// - label: The label of the radio button
    public init(id: ID, label: String) {
        self.id = id
        self.label = NSAttributedString(string: label)
    }

    /// Parameters:
    /// - id: A unique ID bound to a generic type which has the constraints that it need be ``Equatable`` & ``Hashable``.
    /// - label: The label of the radio button
    public init(id: ID, label: NSAttributedString) {
        self.id = id
        self.label = label
    }
}
