//
//  TabItemContent.swift
//  SparkCore
//
//  Created by alican.aycil on 25.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

struct TabUIItemContent {
    let icon: UIImage?
    let text: String?
    let attributeText: NSAttributedString?
    let badge: BadgeUIView?
    
    init(
        icon: UIImage? = nil,
        text: String? = nil,
        attributeText: NSAttributedString? = nil,
        badge: BadgeUIView? = nil
    ) {
        self.icon = icon
        self.text = text
        self.attributeText = attributeText
        self.badge = badge
    }
}
