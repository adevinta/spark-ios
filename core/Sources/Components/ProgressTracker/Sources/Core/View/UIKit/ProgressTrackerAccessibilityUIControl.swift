//
//  ProgressTrackerAccessibilityUIControl.swift
//  Spark
//
//  Created by Michael Zimmermann on 15.04.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

final class ProgressTrackerAccessibilityUIControl: UIControl {

    override var isHighlighted: Bool {
        didSet {
            self.subviews
                .compactMap{$0 as? UIControl}
                .forEach { $0.isHighlighted = self.isHighlighted }
        }
    }
}
