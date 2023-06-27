//
//  UIDevice+Shake.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 08.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

// MARK: - Notification
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}
