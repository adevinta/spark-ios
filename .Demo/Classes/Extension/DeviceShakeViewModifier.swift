//
//  DeviceShakeViewModifier.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 08.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

// MARK: - View Modifier
struct DeviceShakeViewModifier: ViewModifier {

    // MARK: - Properties
    let action: () -> Void

    // MARK: - Content
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}
