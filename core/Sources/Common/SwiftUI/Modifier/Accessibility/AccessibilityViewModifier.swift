//
//  AccessibilityViewModifier.swift
//  SparkCore
//
//  Created by robin.lemaire on 04/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct AccessibilityViewModifier: ViewModifier {

    // MARK: - Properties

    private let identifier: String?
    private let label: String?

    // MARK: - Initialization

    init(identifier: String?,
         label: String?) {
        self.identifier = identifier
        self.label = label
    }

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .if(identifier != nil) {
                $0.accessibilityIdentifier(identifier ?? "")
            }
            .if(label != nil) {
                $0.accessibilityLabel(label ?? "")
            }
    }
}
