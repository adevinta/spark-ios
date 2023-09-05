//
//  OverflowContentViewModifier.swift
//  SparkCore
//
//  Created by michael.zimmermann on 05.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

import SwiftUI

struct HorizontalOverflowContentViewModifier: ViewModifier {
    @State private var contentOverflow: Bool = false
    @Binding var numberOfItems: Int

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
            .background(
                GeometryReader { contentGeometry in
                    Color.clear.onChange(of: self.numberOfItems) { _ in
                        contentOverflow = contentGeometry.size.width > geometry.size.width
                    }
                }
            )
            .wrappedInScrollView(when: contentOverflow)
        }
    }
}

extension View {
    @ViewBuilder
    func wrappedInScrollView(when condition: Bool) -> some View {
        if condition {
            ScrollView(.horizontal, showsIndicators: false) {
                self
            }
        } else {
            self
        }
    }
}

extension View {
    func scrollOnOverflow(numberOfItems: Binding<Int>) -> some View {
        modifier(HorizontalOverflowContentViewModifier(numberOfItems: numberOfItems))
    }
}
