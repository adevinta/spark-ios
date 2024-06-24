//
//  RadioButtonPosition.swift
//  SparkCore
//
//  Created by michael.zimmermann on 30.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
/// The checkbox can be either on the leading or trailing edge of the view.
@frozen
@available(*, deprecated, renamed: "RadioButtonLabelAlignment", message: "Please use RadioButtonLabelAlignment instead")
public enum RadioButtonLabelPosition {
    /// Radiobutton label on leading edge.
    case left

    /// RadioButton label on trailing edge.
    case right

    var alignment: RadioButtonLabelAlignment {
        switch self {
        case .left: return .leading
        case .right: return .trailing
        }
    }
}

@frozen
public enum RadioButtonLabelAlignment: String, CaseIterable {
    /// Radiobutton label on leading edge.
    case leading

    /// RadioButton label on trailing edge.
    case trailing

    var position: RadioButtonLabelPosition {
        switch self {
        case .leading: return .left
        case .trailing: return .right
        }
    }
}
