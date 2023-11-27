//
//  CheckboxGroupItemDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 22/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Default struct extending CheckboxGroupItemProtocol used for items in checkbox groups. It describes a single item within a checkbox group.
public struct CheckboxGroupItemDefault: CheckboxGroupItemProtocol, Hashable {

    /// The checkbox title.
    public var title: String?
    /// The attributed checkbox title.
    public var attributedTitle: NSAttributedString?
    /// The checkbox identifier.
    public var id: String
    /// The current selection state of the checkbox.
    public var selectionState: CheckboxSelectionState
    /// The current control state of the checkbox.
    public var state: SelectButtonState
    /// The current control state of the checkbox.
    public var isEnabled: Bool

    /// CheckboxGroupItemDefault initializer
    /// - Parameters:
    ///   - title: The checkbox title. Default value is `nil`
    ///   - attributedTitle: The attributed checkbox title. Default value is `nil`
    ///   - id: The checkbox identifier.
    ///   - selectionState: The current selection state of the checkbox.
    ///   - state: The current control state of the checkbox.
    @available(*, deprecated, message: "state parameter was changed with isEnabled")
    public init(
        title: String? = nil,
        attributedTitle: NSAttributedString? = nil,
        id: String,
        selectionState: CheckboxSelectionState,
        state: SelectButtonState = .enabled
    ) {
        self.title = title
        self.attributedTitle = attributedTitle
        self.id = id
        self.selectionState = selectionState
        self.state = state
        self.isEnabled = state == .enabled
    }

    /// CheckboxGroupItemDefault initializer
    /// - Parameters:
    ///   - title: The checkbox title. Default value is `nil`
    ///   - attributedTitle: The attributed checkbox title. Default value is `nil`
    ///   - id: The checkbox identifier.
    ///   - selectionState: The current selection state of the checkbox.
    ///   - isEnabled: The current control state of the checkbox.
    public init(
        title: String? = nil,
        attributedTitle: NSAttributedString? = nil,
        id: String,
        selectionState: CheckboxSelectionState,
        isEnabled: Bool = true
    ) {
        self.title = title
        self.attributedTitle = attributedTitle
        self.id = id
        self.selectionState = selectionState
        self.isEnabled = isEnabled
        self.state = isEnabled ? .enabled : .disabled
    }
    
    public static func == (lhs: CheckboxGroupItemDefault, rhs: CheckboxGroupItemDefault) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

