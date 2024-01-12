//
//  HorizontalOverflowContentViewModifier.swift
//  SparkCore
//
//  Created by michael.zimmermann on 05.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// Wraps the content in a horizontal scroll view, if the content is too wide to display on screen.
struct HorizontalOverflowContentViewModifier<Value>: ViewModifier where Value: Equatable {
    // MARK: - Properties
    @State private var contentOverflow: Bool = false
    @State private var height: CGFloat = 0
    @Binding var value: Value
    var minWidth: CGFloat

    // MARK: - View
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .overlay(
                    GeometryReader { contentGeometry in
                        Color.clear
                            .onAppear{
                                self.height = contentGeometry.size.height
                                contentOverflow = max(contentGeometry.size.width, self.minWidth) > geometry.size.width
                            }
                            .onChange(of: self.value) { _ in
                                self.height = contentGeometry.size.height
                                contentOverflow = max(contentGeometry.size.width, self.minWidth) > geometry.size.width
                            }
                    }
                )
                .wrappedInScrollView(when: contentOverflow)
        }
        .frame(height: self.height)
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

    func scrollOnOverflow<Value>(value: Binding<Value>, minWidth: CGFloat) -> some View where Value: Equatable {
        modifier(HorizontalOverflowContentViewModifier<Value>(value: value, minWidth: minWidth))
    }
}
