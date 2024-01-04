//
//  NoButtonStyle.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 04.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

struct NoButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
    }
}
