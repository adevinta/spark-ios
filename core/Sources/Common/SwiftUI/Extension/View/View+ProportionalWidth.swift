//
//  View+ProportionalWidth.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

extension View {

    /// Set a proportional width from the parent width
    /// - Parameters:
    ///   - ratio: ratio of the parent view width.
    func proportionalWidth(
        from ratio: CGFloat
    ) -> some View {
        GeometryReader { reader in
            self.frame(width: ratio * reader.size.width)
        }
    }
}
