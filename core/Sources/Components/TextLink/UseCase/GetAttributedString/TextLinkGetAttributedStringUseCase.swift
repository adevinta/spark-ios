//
//  TextLinkGetAttributedStringUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 05/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable, AutoMockTest
protocol TextLinkGetAttributedStringUseCaseable {

    // sourcery: textColorToken = "Identical"
    func execute(frameworkType: FrameworkType,
                 text: String,
                 textColorToken: any ColorToken,
                 textHighlightRange: NSRange?,
                 isHighlighted: Bool,
                 variant: TextLinkVariant,
                 typographies: TextLinkTypographies) -> AttributedStringEither
}

struct TextLinkGetAttributedStringUseCase: TextLinkGetAttributedStringUseCaseable {

    // MARK: - Properties

    private let getUnderlineUseCaseable: TextLinkGetUnderlineUseCaseable

    // MARK: - Initialization

    init(getUnderlineUseCaseable: TextLinkGetUnderlineUseCaseable = TextLinkGetUnderlineUseCase()) {
        self.getUnderlineUseCaseable = getUnderlineUseCaseable
    }

    // MARK: - Methods


    func execute(
        textHighlightRange: NSRange?) -> String? {
            return nil
        }

    func execute(
        frameworkType: FrameworkType,
        text: String,
        textColorToken: any ColorToken,
        textHighlightRange: NSRange?,
        isHighlighted: Bool,
        variant: TextLinkVariant,
        typographies: TextLinkTypographies
    ) -> AttributedStringEither {
        let underline = self.getUnderlineUseCaseable.execute(
            variant: variant,
            isHighlighted: isHighlighted
        )

        // Two possibilities:
        // - Without range: Add highlight font and add underline from variant for all text
        // - With range: Add highlight font and add underline from variant for range text, and normal for other.
        switch frameworkType {
        case .uiKit:
            var attributedString: NSMutableAttributedString

            var highlightAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: textColorToken.uiColor,
                .font: typographies.highlight.uiFont
            ]

            if let underline {
                highlightAttributes[.underlineStyle] = underline.rawValue
                highlightAttributes[.underlineColor] = textColorToken.uiColor
            }

            if let textHighlightRange, text.count > textHighlightRange.upperBound {
                let normalAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: textColorToken.uiColor,
                    .font: typographies.normal.uiFont
                ]

                attributedString = NSMutableAttributedString(
                    string: text,
                    attributes: normalAttributes
                )

                attributedString.addAttributes(
                    highlightAttributes,
                    range: textHighlightRange
                )

            } else {
                attributedString = NSMutableAttributedString(
                    string: text,
                    attributes: highlightAttributes
                )
            }

            return .left(attributedString)

        case .swiftUI:
            var attributedString = AttributedString(text)
            attributedString.foregroundColor = textColorToken.color

            if let textHighlightRangeTemp = textHighlightRange,
               let textHighlightRange = Range(textHighlightRangeTemp, in: attributedString) {
                attributedString.font = typographies.normal.font

                attributedString[textHighlightRange].font = typographies.highlight.font
                attributedString[textHighlightRange].underlineStyle = underline

            } else {
                attributedString.font = typographies.highlight.font
                attributedString.underlineStyle = underline
            }

            return .right(attributedString)
        }
    }
}
