//
//  SwitchTextContent.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchTextContentable{
    var text: String? { get }
    var attributedText: SwitchAttributedString? { get }
}

struct SwitchTextContent: SwitchTextContentable {

    // MARK: - Properties

    let text: String?
    let attributedText: SwitchAttributedString?
}
