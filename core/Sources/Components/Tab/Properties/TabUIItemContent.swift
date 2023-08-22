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
struct TabUIItemContent: Equatable, Updateable {
    var icon: UIImage?
    var text: String?

    init(
        text: String
    ) {
        self.icon = nil
        self.text = text
    }

    init(
        icon: UIImage
    ) {
        self.icon = icon
        self.text = nil
    }

    init(
        icon: UIImage? = nil,
        text: String? = nil
    ) {
        self.icon = icon
        self.text = text
    }
}
