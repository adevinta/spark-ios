//
//  CheckboxGroupItemProtocol.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// The protocol is used for items in checkbox groups. It describes a single item within a checkbox group.
public protocol CheckboxGroupItemProtocol: Hashable {
    /// The checkbox title.
    var title: String? { get set }

    /// The attributed checkbox title.
    var attributedTitle: NSAttributedString? { get set }

    /// The checkbox identifier.
    var id: String { get set }

    /// The current selection state of the checkbox.
    var selectionState: CheckboxSelectionState { get set }

    /// The current control state of the checkbox.
    var state: SelectButtonState { get set }
}
