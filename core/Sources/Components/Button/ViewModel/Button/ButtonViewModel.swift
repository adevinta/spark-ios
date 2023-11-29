//
//  ButtonViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 13/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine

// sourcery: AutoPublisherTest, AutoViewModelStub
// sourcery: titleFontToken = "Identical"
final class ButtonViewModel: ButtonMainViewModel {

    // MARK: - Properties

    private(set) var alignment: ButtonAlignment

    // MARK: - Published Properties

    @Published private(set) var spacings: ButtonSpacings?
    @Published private(set) var isImageTrailing: Bool?
    @Published private(set) var titleFontToken: TypographyFontToken?

    // MARK: - Private Properties

    private let getSpacingsUseCase: ButtonGetSpacingsUseCaseable

    // MARK: - Initialization

    init(
        for frameworkType: FrameworkType,
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        alignment: ButtonAlignment,
        getSpacingsUseCase: ButtonGetSpacingsUseCaseable = ButtonGetSpacingsUseCase()
    ) {
        self.alignment = alignment
        self.getSpacingsUseCase = getSpacingsUseCase

        super.init(
            for: frameworkType,
            type: .button,
            theme: theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape
        )
    }

    // MARK: - Setter

    func set(alignment: ButtonAlignment) {
        if self.alignment != alignment {
            self.alignment = alignment

            self.alignmentDidUpdate()
        }
    }

    // MARK: - Update

    override func updateAll() {
        super.updateAll()
        
        self.alignmentDidUpdate()
        self.spacingsDidUpdate()
        self.titleFontDidUpdate()
    }

    private func alignmentDidUpdate() {
        self.isImageTrailing = self.alignment.isTrailingImage
    }

    private func spacingsDidUpdate() {
        self.spacings = self.getSpacingsUseCase.execute(
            spacing: self.theme.layout.spacing
        )
    }

    private func titleFontDidUpdate() {
        self.titleFontToken = self.theme.typography.callout
    }
}
