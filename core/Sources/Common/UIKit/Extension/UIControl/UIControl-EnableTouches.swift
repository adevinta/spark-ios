//
//  UIControl-EnableTouches.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 21.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

extension UIControl {
    //Add a default tap gesture recognizer without any action to detect the action/publisher/target action even if the parent view has a gesture recognizer
    //Why ? UIControl action/publisher/target doesn't work if the parent contains a gesture recognizer.
    //Note: Native UIButton add the same default recognizer to manage this use case.
    func enableTouch() {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(gestureRecognizer)
    }
}
