//
//  FormfieldTitleUseCase.swift
//  SparkCore
//
//  Created by alican.aycil on 09.04.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

// sourcery: AutoMockable
protocol FormFieldTitleUseCaseable {
    func execute(title: SparkAttributedString?, isTitleRequired: Bool, colors: FormFieldColors, typography: Typography) -> SparkAttributedString?
}

struct FormFieldTitleUseCase: FormFieldTitleUseCaseable {

    func execute(title: SparkAttributedString?, isTitleRequired: Bool, colors: FormFieldColors, typography: Typography) -> SparkAttributedString? {

        let asterisk = NSAttributedString(
            string: " *",
            attributes: [
                NSAttributedString.Key.foregroundColor: colors.asterisk.uiColor,
                NSAttributedString.Key.font : typography.caption.uiFont
            ]
        )

        if let attributedString = title as? NSAttributedString {
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            if isTitleRequired {
                mutableAttributedString.append(asterisk)
            }
            return mutableAttributedString

        } else if var attributedString = title as? AttributedString {
            if isTitleRequired {
                attributedString.append(AttributedString(asterisk))
            }
            return attributedString
        }
        return nil
    }
}
