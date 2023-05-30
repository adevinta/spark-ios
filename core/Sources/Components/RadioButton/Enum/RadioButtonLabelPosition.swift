//
//  RadioButtonPosition.swift
//  SparkCore
//
//  Created by michael.zimmermann on 30.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
//Hashable & Equatable & CustomStringConvertible
/// The checkbox can be either on the leading or trailing edge of the view.
@frozen
public enum RadioButtonLabelPosition: CustomStringConvertible {
    public var description: String {
        switch self {
        case .left: return "left"
        case .right: return "right"
        }
    }

    /// Radiobutton label on leading edge.
    case left

    /// RadioButton label on trailing edge.
    case right
}
