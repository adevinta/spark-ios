//
//  DisplayedTextViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol DisplayedTextViewModel {
    var text: String? { get }
    var attributedText: AttributedStringEither? { get }
    var displayedTextType: DisplayedTextType { get }

    func textChanged(_ text: String?) -> Bool
    func attributedTextChanged(_ attributedText: AttributedStringEither?) -> Bool
}

// View model used by a component view model that contains a text/attributed management.
final class DisplayedTextViewModelDefault: DisplayedTextViewModel {

    // MARK: - Internal Properties

    private(set) var text: String?
    private(set) var attributedText: AttributedStringEither?
    private(set) var displayedTextType: DisplayedTextType

    // MARK: - Private Properties

    private let getDisplayedTextTypeUseCase: GetDisplayedTextTypeUseCaseable
    private let getDidDisplayedTextChangeUseCase: GetDidDisplayedTextChangeUseCaseable

    // MARK: - Initialization

    init(
        text: String?,
        attributedText: AttributedStringEither?,
        getDisplayedTextTypeUseCase: GetDisplayedTextTypeUseCaseable = GetDisplayedTextTypeUseCase(),
        getDidDisplayedTextChangeUseCase: GetDidDisplayedTextChangeUseCaseable = GetDidDisplayedTextChangeUseCase()
    ) {
        self.text = text
        self.attributedText = attributedText
        self.displayedTextType = getDisplayedTextTypeUseCase.execute(
            text: text,
            attributedText: attributedText
        )

        self.getDisplayedTextTypeUseCase = getDisplayedTextTypeUseCase
        self.getDidDisplayedTextChangeUseCase = getDidDisplayedTextChangeUseCase
    }

    // MARK: - Internal Methods

    func textChanged(_ text: String?) -> Bool {
        // Displayed text changed ?
        if self.getDidDisplayedTextChangeUseCase.execute(
            currentText: self.text,
            newText: text,
            displayedTextType: self.displayedTextType
        ) {
            self.text = text
            self.displayedTextType = self.getDisplayedTextTypeUseCase.execute(
                text: text
            )

            return true
        }

        return false
    }

    func attributedTextChanged(_ attributedText: AttributedStringEither?) -> Bool {
        // Displayed attributed text changed ?
        if self.getDidDisplayedTextChangeUseCase.execute(
            currentAttributedText: self.attributedText,
            newAttributedText: attributedText,
            displayedTextType: self.displayedTextType
        ) {
            self.attributedText = attributedText
            self.displayedTextType = self.getDisplayedTextTypeUseCase.execute(
                attributedText: attributedText
            )

            return true
        }

        return false
    }
}
