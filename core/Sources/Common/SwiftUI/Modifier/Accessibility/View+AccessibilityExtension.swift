//
//  View+AccessibilityExtension.swift
//  Spark
//
//  Created by robin.lemaire on 04/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public extension View {

    func accessibility(identifier: String?,
                       label: String?,
                       text: String?) -> some View {
        self.modifier(AccessibilityViewModifier(identifier: identifier,
                                                label: label ?? text))
    }
}
