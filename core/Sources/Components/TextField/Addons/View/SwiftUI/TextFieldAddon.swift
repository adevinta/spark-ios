//
//  TextFieldAddon.swift
//  SparkCore
//
//  Created by louis.borlee on 21/03/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

public struct TextFieldAddon<Content: View>: View {

    public let withPadding: Bool
    public let content: () -> Content

    public init(withPadding: Bool = false, content: @escaping () -> Content) {
        self.withPadding = withPadding
        self.content = content
    }

    public var body: Content {
        content()
    }
}
