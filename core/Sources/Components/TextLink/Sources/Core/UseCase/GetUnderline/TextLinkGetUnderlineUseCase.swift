//
//  TextLinkGetUnderlineUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import UIKit

// sourcery: AutoMockable, AutoMockTest
protocol TextLinkGetUnderlineUseCaseable {

    func execute(variant: TextLinkVariant,
                 isHighlighted: Bool) -> NSUnderlineStyle?
}

struct TextLinkGetUnderlineUseCase: TextLinkGetUnderlineUseCaseable {

    // MARK: - Methods

    func execute(
        variant: TextLinkVariant,
        isHighlighted: Bool
    ) -> NSUnderlineStyle? {
        // Always single line when the textlink is highlighted
        guard !isHighlighted else {
            return .single
        }

        switch variant {
        case .underline:
            return .single
        case .none:
            return nil
        }
    }
}
