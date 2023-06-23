//
//  ButtonUIViewDelegate.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Implement the delegate to receive tap and touch events.
public protocol ButtonUIViewDelegate: AnyObject {
    /// Optionally implement this method to receive tap events and perform actions.
    /// - Parameter button: the button that was tapped
    /// - note: This is equivalent to receiving `button(button, didReceive: .touchUpInside)`.
    func buttonWasTapped(_ button: ButtonUIView)

    /// Optionally implement this method to receive touch events.
    /// - Parameters:
    ///   - button: the button receiving the touch event.
    ///   - touchEvent: the control event type.
    /// - note: When receiving touch-event `.touchUpInside`, `buttonWasTapped()` is called as well.
    func button(_ button: ButtonUIView, didReceive touchEvent: ButtonTouchEvent)
}

// MARK: - Default implementation
public extension ButtonUIViewDelegate {
    // Tap handlers are optional.
    func buttonWasTapped(_ button: ButtonUIView) {}

    // Touch events are optional.
    func button(_ button: ButtonUIView, didReceive touchEvent: ButtonTouchEvent) {}
}
