//
//  CheckboxUIViewDelegate.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 18.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// The checkbox delegate informs about a new checkbox selection state.
public protocol CheckboxUIViewDelegate: AnyObject {
    /// The checkbox selection was changed.
    /// - Parameters:
    ///   - checkbox: The updated checkbox.
    ///   - state: The new checkbox state.
    func checkbox(_ checkbox: CheckboxUIView, didChangeSelection state: CheckboxSelectionState)
}
