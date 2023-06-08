//
//  UIWindow+Shake.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 08.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

// MARK: - Window override
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}
