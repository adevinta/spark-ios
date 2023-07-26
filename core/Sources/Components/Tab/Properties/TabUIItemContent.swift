//
//  TabItemContent.swift
//  SparkCore
//
//  Created by alican.aycil on 25.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

struct TabUIItemContent: Equatable, Updateable {
    var icon: UIImage?
    var text: String?
    var attributeText: NSAttributedString?
    var badge: BadgeUIView?
    
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
