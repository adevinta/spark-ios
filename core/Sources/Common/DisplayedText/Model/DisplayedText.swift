//
//  DisplayedText.swift
//  SparkCore
//
//  Created by robin.lemaire on 13/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

struct DisplayedText: Equatable {

    // MARK: - Properties

    let text: String?
    let attributedText: AttributedStringEither?

    // MARK: - Initialization

    init?(text: String?, attributedText: AttributedStringEither?) {
        // Both values cannot be nil
        guard text != nil || attributedText != nil else {
            return nil
        }

        self.text = text
        self.attributedText = attributedText
    }

    init(text: String) {
        self.text = text
        self.attributedText = nil
    }

    init(attributedText: AttributedStringEither) {
        self.text = nil
        self.attributedText = attributedText
    }
}
