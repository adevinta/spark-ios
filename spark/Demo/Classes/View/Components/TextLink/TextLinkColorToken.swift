//
//  TextLinkColorToken.swift
//  SparkDemo
//
//  Created by robin.lemaire on 18/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore

enum TextLinkColorToken: CaseIterable {
    case main
    case support
    case success
    case error
    case info

    // MARK: - Getter

    func getColorToken(from theme: any Theme) -> any ColorToken {
        switch self {
        case .main:
            return theme.colors.main.main
        case .support:
            return theme.colors.support.support
        case .success:
            return theme.colors.feedback.success
        case .error:
            return theme.colors.feedback.error
        case .info:
            return theme.colors.feedback.info
        }
    }
}
