//
//  TextLinkVariant.swift
//  SparkCore
//
//  Created by robin.lemaire on 05/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// A text link variant is used to distinguish between different design and appearance options.
public enum TextLinkVariant: CaseIterable {
    /// A text link with an underline.
    case underline

    /// A text link without any variant (underline).
    /// *Not recommended, please use it carefully.*
    case none
}
