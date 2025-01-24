//
//  View+ActionExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 23/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

extension View {

    func alertAction(
        _ title: String,
        showAlert: Binding<Bool>
    ) -> some View {
        self.modifier(
            ActionViewModifier(title: title, showIngActionAlert: showAlert)
        )
    }
}

// MARK: - ViewModifier

struct ActionViewModifier: ViewModifier {

    // MARK: - Properties

    var title: String
    @Binding var showIngActionAlert: Bool

    // MARK: - View

    public func body(content: Content) -> some View {
        content
            .alert(self.title, isPresented: self.$showIngActionAlert) {
                Button("OK", role: .cancel) { }
            }
    }
}
