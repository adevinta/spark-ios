//
//  GetDisplayedTextTypeUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol GetDisplayedTextTypeUseCaseable {
    func execute(text: String?,
                 attributedText: AttributedStringEither?) -> DisplayedTextType

    func execute(text: String?) -> DisplayedTextType
    func execute(attributedText: AttributedStringEither?) -> DisplayedTextType
}

struct GetDisplayedTextTypeUseCase: GetDisplayedTextTypeUseCaseable {

    /// Get the displayed text type from a text and attributedText.
    func execute(
        text: String?,
        attributedText: AttributedStringEither?
    ) -> DisplayedTextType {
        switch (text, attributedText) {
        case (nil, nil):
            return .none
        case (_, nil):
            return .text
        case (nil, _), (_, _):
            return .attributedText
        }
    }

    /// Get the new displayed text type when text changed
    func execute(
        text: String?
    ) -> DisplayedTextType {
        return self.execute(
            text: text,
            attributedText: nil
        )
    }

    /// Get the new displayed text type when attributedText changed
    func execute(
        attributedText: AttributedStringEither?
    ) -> DisplayedTextType {
        return self.execute(
            text: nil,
            attributedText: attributedText
        )
    }
}
