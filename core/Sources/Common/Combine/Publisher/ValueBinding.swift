//
//  PublishingBinding.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 24.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI

final class ValueBinding<ID: Equatable & CustomStringConvertible> {
    var selectedID: ID?

    lazy var binding = Binding<ID?>(
        get: { self.selectedID },
        set: { newValue in
            self.selectedID = newValue
        }
    )

    init(selectedID: ID?) {
        self.selectedID = selectedID
    }
}
