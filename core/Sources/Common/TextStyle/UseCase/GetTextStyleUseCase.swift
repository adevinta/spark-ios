//
//  GetTextStyleUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 18/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

// sourcery: AutoMockable
protocol GetTextStyleUseCaseable {
    func execute(from textStyle: TextStyle) -> Font.TextStyle
    func executeForUIFont(from textStyle: TextStyle) -> UIFont.TextStyle
}

struct GetTextStyleUseCase: GetTextStyleUseCaseable {
    
    // MARK: - Methods
    
    func execute(from textStyle: TextStyle) -> Font.TextStyle {
        switch textStyle {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .footnote:
            return .footnote
        case .caption:
            return .caption
        case .caption2:
            return .caption2
        }
    }

    func executeForUIFont(from textStyle: TextStyle) -> UIFont.TextStyle {
        switch textStyle {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title1
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .footnote:
            return .footnote
        case .caption:
            return .caption1
        case .caption2:
            return .caption2
        }
    }
}
