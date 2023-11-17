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
    /// Either a standard title or an attributed title can be set on the UIKit checkbox. If both are set here in the model, then the standard title has precedence.
    /// In SwiftUI only a standard title is accepted. The attributed title will be ignored.
    var title: String? { get set }

    /// The attributed checkbox title.
    /// The attributed title can not be set in the SwiftUI component.
    var attributedTitle: NSAttributedString? { get set }

    /// The checkbox identifier.
    var id: String { get set }

    /// The current selection state of the checkbox.
    var selectionState: CheckboxSelectionState { get set }

    /// The current control state of the checkbox.
    var isEnabled: Bool { get set }
}
