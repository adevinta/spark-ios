//
//  TextFieldAddon.swift
//  SparkCore
//
//  Created by louis.borlee on 21/03/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

public struct TextFieldAddon<Content: View>: View {

    let withPadding: Bool
    let layoutPriority: Double
    private let content: () -> Content

    public init(
        withPadding: Bool = false,
        layoutPriority: Double = 1.0,
        content: @escaping () -> Content) {
        self.withPadding = withPadding
        self.layoutPriority = layoutPriority
        self.content = content
    }

    public var body: Content {
        content()
    }
}
