//
//  TextLinkGetAttributedStringUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 05/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import UIKit
@_spi(SI_SPI) import SparkCommon
import SparkTheming

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
        frameworkType: FrameworkType,
        text: String,
        textColorToken: any ColorToken,
        textHighlightRange: NSRange?,
        isHighlighted: Bool,
        variant: TextLinkVariant,
        typographies: TextLinkTypographies
    ) -> AttributedStringEither {
        let underlineStyle = self.getUnderlineUseCaseable.execute(
            variant: variant,
            isHighlighted: isHighlighted
        )

        // Two possibilities:
        // - Without range: Add highlight font and add underline from variant for all text
        // - With range: Add highlight font and add underline from variant for range text, and normal for other.
        switch frameworkType {
        case .uiKit:
            let attributedString = self.makeNSAttributedString(
                text: text,
                textColorToken: textColorToken,
                textHighlightRange: textHighlightRange,
                underlineStyle: underlineStyle,
                typographies: typographies
            )
            return .left(attributedString)

        case .swiftUI:
            let attributedString = self.makerAttributedString(
                text: text,
                textColorToken: textColorToken,
                textHighlightRange: textHighlightRange,
                underlineStyle: underlineStyle,
                typographies: typographies
            )

            return .right(attributedString)
        }
    }

    // MARK: - Maker

    private func makeNSAttributedString(
        text: String,
        textColorToken: any ColorToken,
        textHighlightRange: NSRange?,
        underlineStyle: NSUnderlineStyle?,
        typographies: TextLinkTypographies
    ) -> NSAttributedString {
        var attributedString: NSMutableAttributedString

        var highlightAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColorToken.uiColor,
            .font: typographies.highlight.uiFont
        ]

        if let underlineStyle {
            highlightAttributes[.underlineStyle] = underlineStyle.rawValue
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

        return attributedString
    }

    private func makerAttributedString(
        text: String,
        textColorToken: any ColorToken,
        textHighlightRange: NSRange?,
        underlineStyle: NSUnderlineStyle?,
        typographies: TextLinkTypographies
    ) -> AttributedString {
        var attributedString = AttributedString(text)
        attributedString.foregroundColor = textColorToken.color

        if let textHighlightRangeTemp = textHighlightRange,
           let textHighlightRange = Range(textHighlightRangeTemp, in: attributedString) {
            attributedString.font = typographies.normal.font

            attributedString[textHighlightRange].font = typographies.highlight.font
            attributedString[textHighlightRange].underlineStyle = underlineStyle

        } else {
            attributedString.font = typographies.highlight.font
            attributedString.underlineStyle = underlineStyle
        }

        return attributedString
    }
}
