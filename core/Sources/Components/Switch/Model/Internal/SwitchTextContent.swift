//
//  SwitchTextContent.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchTextContent {
    var text: String? { get }
    var attributedText: SwitchAttributedStringEither? { get }
}

struct SwitchTextContentDefault: SwitchTextContent {

    // MARK: - Properties

    let text: String?
    let attributedText: SwitchAttributedStringEither?
}
