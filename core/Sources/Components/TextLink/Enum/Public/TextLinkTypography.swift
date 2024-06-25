//
//  TextLinkTypography.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The typography of the text link.
public enum TextLinkTypography: CaseIterable {
    /// Use the **display1** typography
    case display1
    /// Use the **display2** typography
    case display2
    /// Use the **display3** typography
    case display3

    /// Use the **headline1** typography
    case headline1
    /// Use the **headline2** typography
    case headline2

    /// Use the **subhead** typography
    case subhead

    /// Use the **body1** and **body1Highlight** typographies
    case body1
    /// Use the **body2** and **body2Highlight** typographies
    case body2

    /// Use the **caption** and **captionHighlight** typographies
    case caption

    /// Use the **small** and **smallHighlight** typographies
    case small

    /// Use the **callout** typography
    case callout
}
