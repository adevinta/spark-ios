//
//  View+Shake.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 08.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

// MARK: - View extension
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}

