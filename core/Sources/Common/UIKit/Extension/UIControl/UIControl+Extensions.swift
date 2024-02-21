//
//  UIControl+Extensions.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 21.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

extension UIControl {
<<<<<<< HEAD

    // Add a default tap gesture recognizer without any action to detect the action/publisher/target action even if the parent view has a gesture recognizer
    // Why? UIControl action/publisher/target doesn't work if the parent contains a gesture recognizer.
    // Note: Native UIButton add the same default recognizer to manage this use case.
=======
    //Add a default tap gesture recognizer without any action to detect the action/publisher/target action even if the parent view has a gesture recognizer
    //Why ? UIControl action/publisher/target doesn't work if the parent contains a gesture recognizer.
    //Note: Native UIButton add the same default recognizer to manage this use case.
>>>>>>> 7963ca03 ([ProgressTracker#824] Fix touch when parent has gesture recognizer.)
    func enableTouch() {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(gestureRecognizer)
    }

    /// Fixes conflict with other swipes (scrollViews, bottomSheets...) by adding a panGesture to prevent cancelTracking from being called
    @discardableResult
    func addPanGestureToPreventCancelTracking() -> UIPanGestureRecognizer {
        let panGesture = UIPanGestureRecognizer(target: nil, action: nil)
        panGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(panGesture)
        return panGesture
    }
}
