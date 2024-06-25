//
//  TabItemContent.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public protocol TitleContaining {
    var hasTitle: Bool { get }
}

/// The content of a tab item.
public struct TabItemContent: TitleContaining, Equatable, Updateable {
    public static func == (lhs: TabItemContent, rhs: TabItemContent) -> Bool {
        return lhs.id == rhs.id
    }

    /// A unique id of each tab item
    public var id = UUID()

    /// An optional icon of a tab item
    public var icon: Image?

    /// An optional title of a tab item
    public var title: String?

    /// An optional attributed title. If a title is set, this will have preference over an attributed title
    public var attributedTitle: AttributedString?

    /// An optional badge
    public var badge: BadgeView?

    /// Return true if either title or attributed title are not nil.
    /// An empty string in either title or attributed title will be treated as having a title and `hasTitle` will return true.
    public var hasTitle: Bool {
        return self.title != nil || self.attributedTitle != nil
    }

    /// Initialization
    /// - Parameters:
    /// - icon: An optional image
    /// - title: An optional title
    public init(icon: Image? = nil, title: String? = nil) {
        self.icon = icon
        self.title = title
    }
}
