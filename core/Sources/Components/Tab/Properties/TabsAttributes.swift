//
//  TabAttributes.swift
//  SparkCore
//
//  Created by michael.zimmermann on 30.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct TabsAttributes: Equatable {
    let lineHeight: CGFloat
    let lineColor: any ColorToken
    let backgroundColor: any ColorToken

    static func == (lhs: TabsAttributes, rhs: TabsAttributes) -> Bool {
        return lhs.backgroundColor.equals(rhs.backgroundColor) &&
        lhs.lineColor.equals(rhs.lineColor) &&
        lhs.lineHeight == rhs.lineHeight
    }
}
