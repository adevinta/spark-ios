//
//  View-popover.swift
//  SparkCore
//
//  Created by louis.borlee on 27/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

public extension View {
    @available(iOS 16.4, *)
    /// Presents a Spark popover when a given condition is true.
    /// - Parameters:
    ///   - theme: The Spark theme of the Spark popover.
    ///   - intent: The Spark intent of the Spark popover.
    ///   - isPresented: A binding to a Boolean value that determines whether
    ///     to present the popover content that you return from the modifier's
    ///     `content` closure.
    ///   - attachmentAnchor: The positioning anchor that defines the
    ///     attachment point of the popover. The default is
    ///     ``Anchor/Source/bounds``.
    ///   - arrowEdge: The edge of the `attachmentAnchor` that defines the
    ///     location of the popover's arrow in macOS. The default is ``Edge/top``.
    ///     iOS ignores this parameter.
    ///   - content: A closure returning the content of the popover.
    ///     It has a `PopoverColors` as a parameter.
    func popover<Content>(
        theme: Theme,
        intent: PopoverIntent,
        isPresented: Binding<Bool>,
        attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds),
        arrowEdge: Edge = .top,
        @ViewBuilder content: @escaping (PopoverColors) -> Content
    ) -> some View where Content : View {
        self.popover(isPresented: isPresented,
                     attachmentAnchor: attachmentAnchor,
                     arrowEdge: arrowEdge,
                     content: {
            PopoverView(
                theme: theme,
                intent: intent,
                showArrow: true // There's no way to hide the arrow for now.
            ) { colors in
                content(colors)
            }
        })
    }
}
