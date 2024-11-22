//
//  Components.swift
//  SparkDemo
//
//  Created by louis.borlee on 19/09/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

enum Components: String, CaseIterable, Identifiable {
    case animation
    case snackbar
    case snackbarPresentation

    // MARK: - Properties

    var id: String {
        return self.rawValue
    }
}
