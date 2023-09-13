//
//  TabItemContent.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public protocol ContainsTitle {
    var hasTitle: Bool { get }
}

public struct TabItemContent: ContainsTitle, Equatable, Updateable {
    public static func == (lhs: TabItemContent, rhs: TabItemContent) -> Bool {
        return lhs.id == rhs.id 
    }

    public var id = UUID()
    public var icon: Image?
    public var title: String?
    public var attributedTitle: AttributedString?
    public var badge: BadgeView?

    public var hasTitle: Bool {
        self.title != nil || self.attributedTitle != nil
    }

    public init(icon: Image? = nil, title: String? = nil) {
        self.icon = icon
        self.title = title
    }
}
