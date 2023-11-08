//
//  CheckboxState.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 11.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "isEnabled: Bool parameter will be used instead od this.")
/// "isEnabled" Bool parameter is used instead of this enum.
public enum SelectButtonState: CaseIterable {
    case enabled
    case disabled
}
