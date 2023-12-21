//
//  Do.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 07.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// Just a small helper to execute code block within a view.
/// This should have a similar effect as onChange.
/// 'onChange(of:initial:_:)' is only available in iOS 17.0 or newer
struct DoAction: ViewModifier {
    init(_ action: @escaping () -> () ) {
        DispatchQueue.main.async {
            action()
        }
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func doAction(_ action: @escaping () -> ()) -> some View {
        return self.modifier(DoAction(action))
    }
}
