//
//  CheckboxSelectionState.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Enum describing Checkbox selection states.
@frozen
public enum CheckboxSelectionState: CaseIterable {
    /// Checkbox is selected.
    case selected

    /// Checkbox is partly selected (indeterminate). (E.g. of a given category only a subset of sub-categories is selected.)
    case indeterminate

    /// Checkbox is unselected.
    case unselected
}
