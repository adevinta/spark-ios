//
//  TabItemContent.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct TabItemContent: Equatable, Updateable {
    public static func == (lhs: TabItemContent, rhs: TabItemContent) -> Bool {
        return lhs.id == rhs.id 
    }

    public var id = UUID()
    public var image: Image?
    public var title: String?
    public var badge: BadgeView?

    public init(image: Image?, title: String?) {
        self.image = image
        self.title = title
    }
}
