//
//  TextStyle.swift
//  SparkCore
//
//  Created by robin.lemaire on 18/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

/// The TextStyle used by SwiftUI and UIKit
public enum TextStyle {
    /// The font style for large titles.
    case largeTitle
    /// The font used for first level hierarchical headings.
    case title
    /// The font used for second level hierarchical headings.
    case title2
    /// The font used for third level hierarchical headings.
    case title3
    /// The font used for headings.
    case headline
    /// The font used for subheadings.
    case subheadline
    /// The font used for body text.
    case body
    /// The font used for callouts.
    case callout
    /// The font used in footnotes.
    case footnote
    /// The font used for standard captions.
    case caption
    /// The font used for alternate captions.
    case caption2
}
