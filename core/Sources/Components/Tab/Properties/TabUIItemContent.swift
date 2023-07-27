//
//  TabItemContent.swift
//  SparkCore
//
//  Created by alican.aycil on 25.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// Contents of the tab:
/// - icon: The icon of the tab item
/// - text: The text of the tab item.
/// - attributeText: The text with attributes of the tab item.
/// - badge: The badge of the tab item.
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
