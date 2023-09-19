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
public struct TabUIItemContent: TitleContaining, Equatable, Updateable {
    public var icon: UIImage?
    public var title: String?

    /// Return true if the title is not nil.
    /// If the title is an empty string, `hasTitle` will return true.
    public var hasTitle: Bool {
        return title != nil
    }

    public init(
        title: String
    ) {
        self.icon = nil
        self.title = title
    }

    public init(
        icon: UIImage
    ) {
        self.icon = icon
        self.title = nil
    }

    public init(
        icon: UIImage? = nil,
        title: String? = nil
    ) {
        self.icon = icon
        self.title = title
    }

}
