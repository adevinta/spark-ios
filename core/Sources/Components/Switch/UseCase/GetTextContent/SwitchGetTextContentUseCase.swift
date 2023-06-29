//
//  SwitchGetTextContentUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol SwitchGetTextContentUseCaseable {
    func execute(text: String?,
                 attributedText: SwitchAttributedString?) -> SwitchTextContentable
}

struct SwitchGetTextContentUseCase: SwitchGetTextContentUseCaseable {

    // MARK: - Methods

    func execute(
        text: String?,
        attributedText: SwitchAttributedString?
    ) -> SwitchTextContentable {
        return SwitchTextContent(
            text: text,
            attributedText: attributedText
        )
    }
}
