//
//  IfModifier.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 06.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(content(self))
        } else {
            return AnyView(self)
        }
    }

    func `if`<Content: View, Content2: View>(
        _ conditional: Bool,
        then ifHandler: (Self) -> Content,
        else elseHandler: (Self) -> Content2) -> some View {
        if conditional {
            return AnyView(ifHandler(self))
        } else {
            return AnyView(elseHandler(self))
        }
    }
}
