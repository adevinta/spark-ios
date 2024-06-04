//
//  RadioButtonGroupState-Extension.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 05.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SwiftUI

extension RadioButtonGroupState {
    var description: String {
        switch self {
        case .disabled: return "Disabled"
        case .enabled: return "Enabled"
        case .error: return "Error"
        case .success: return "Success"
        case .warning: return "Warning"
        case .accent: return "Accent"
        case .basic: return "Basic"
        }
    }

    var supplementaryLabel: String? {
        switch self {
        case .disabled: return nil
        case .enabled: return nil
        case .error: return "Error"
        case .success: return "Success"
        case .warning: return "Warning"
        case .accent: return nil
        case .basic: return nil
        }
    }

    func color(theme: Theme) -> Color {
        switch self {
        case .warning: return theme.colors.feedback.alert.color
        case .error: return theme.colors.feedback.error.color
        case .success: return theme.colors.feedback.success.color
        case .enabled: return theme.colors.main.main.color
        case .disabled: return theme.colors.base.outline.color
        case .accent: return theme.colors.accent.accent.color
        case .basic: return theme.colors.basic.basic.color
        }
    }
}
