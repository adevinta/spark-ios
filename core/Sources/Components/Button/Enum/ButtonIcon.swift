//
//  ButtonIconPosition.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 15.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// Describes the icon position.
public enum ButtonIcon: Equatable {
    /// No icon, text only (default value).
    case none

    /// Icon on the leading edge of the view.
    case leading(icon: UIImage)

    /// Icon on the trailing edge of the view.
    case trailing(icon: UIImage)

    /// Only an icon, no text.
    case iconOnly(icon: UIImage)
}

extension ButtonIcon {
    var image: UIImage? {
        switch self {
        case .leading(let image), .trailing(let image), .iconOnly(let image):
            return image
        case .none:
            return nil
        }
    }
}
