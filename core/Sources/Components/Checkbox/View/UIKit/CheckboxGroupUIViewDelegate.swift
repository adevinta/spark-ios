//
//  CheckboxGroupUIViewDelegate.swift
//  SparkCore
//
//  Created by michael.zimmermann on 13.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// The checkbox groupe delegate informs about a changes to any of the checkbox selection state.
// sourcery: AutoMockable
public protocol CheckboxGroupUIViewDelegate: AnyObject {
    /// The checkbox group selection was changed.
    /// - Parameters:
    ///   - checkboxGroup: The updated checkbox group.
    ///   - state: The new checkbox state.
    func checkboxGroup(_ checkboxGroup: CheckboxGroupUIView, didChangeSelection states: [any CheckboxGroupItemProtocol])
}
