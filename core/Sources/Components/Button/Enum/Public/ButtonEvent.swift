//
//  ButtonEvent.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 24.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// All button touch events supported by this control.
@available(*, deprecated, message: "Use native **action** or **target** on UIControl or publisher instead")
public enum ButtonTouchEvent {
    /// Event triggered directly when the view is touched.
    /// - warning: This should not trigger a user action and should only be used for things like tracking.
    case touchDown

    /// Touch up inside is the default behavior to trigger an action.
    case touchUpInside

    /// Touch began inside the view but was concluded outside.
    case touchUpOutside

    /// The touch was canceled (e.g. by a system event).
    case touchCancel
}

public extension ButtonTouchEvent {
    var controlEvent: UIControl.Event {
        switch self {
        case .touchDown:
            return .touchDown
        case .touchUpInside:
            return .touchUpInside
        case .touchUpOutside:
            return .touchUpOutside
        case .touchCancel:
            return .touchCancel
        }
    }
}
