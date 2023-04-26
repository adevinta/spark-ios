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
        if let identifier = self.identifier {
            content.accessibilityIdentifier(identifier)
        }
        if let label = self.label {
            content.accessibilityLabel(label)
        }
    }
}
