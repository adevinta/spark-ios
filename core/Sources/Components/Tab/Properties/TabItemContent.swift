//
//  TabItemContent.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct TabItemContent: Equatable {
    public static func == (lhs: TabItemContent, rhs: TabItemContent) -> Bool {
        return lhs.id == rhs.id 
    }

    public let id = UUID()
    public let image: Image?
    public let title: String?
    public let badge: BadgeView?

    public init(image: Image?, title: String?, badge: BadgeView?) {
        self.image = image
        self.title = title
        self.badge = badge
    }
}
