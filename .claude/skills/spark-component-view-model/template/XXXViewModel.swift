//
//  XXXPreviewViewModel.swift
//  SparkComponentXXX
//
//  Created by robin.lemaire on 24/03/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkTheming

// sourcery: AutoPublisherTest, AutoViewModelStub
final class XXXPreviewViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published private(set) var border = XXXPreviewBorder()
    @Published private(set) var colors = XXXPreviewColors()
    @Published private(set) var content = XXXPreviewContent()
    @Published private(set) var fonts = XXXPreviewFonts()
    @Published private(set) var image: XXXPreviewImage = .file
    @Published private(set) var layout = XXXPreviewLayout()

    // MARK: - Properties

    var theme: (any Theme)? {
        didSet {
            guard !oldValue.equals(self.theme), self.alreadyUpdateAll else { return }

            self.setBorder()
            self.setColors()
            self.setFonts()
            self.setLayout()
        }
    }

    var file: XXX? {
        didSet {
            guard oldValue != self.file, self.alreadyUpdateAll else { return }

            self.setBorder()
            self.setColors()
            self.setContent()
            self.setImage()
        }
    }

    var isPressed: Bool = false {
        didSet {
            guard oldValue != self.isPressed, self.alreadyUpdateAll else { return }

            self.setColors()
        }
    }

    // MARK: - Private Properties

    private var alreadyUpdateAll = false

    // MARK: - Use Case Properties

    private let getBorderUseCase: any XXXPreviewGetBorderUseCaseable
    private let getColorsUseCase: any XXXPreviewGetColorsUseCaseable
    private let getContentUseCase: any XXXPreviewGetContentUseCaseable
    private let getFontsUseCase: any XXXPreviewGetFontsUseCaseable
    private let getImageUseCase: any XXXPreviewGetImageUseCaseable
    private let getLayoutUseCase: any XXXPreviewGetLayoutUseCaseable

    // MARK: - Initialization

    init(
        getBorderUseCase: any XXXPreviewGetBorderUseCaseable = XXXPreviewGetBorderUseCase(),
        getColorsUseCase: any XXXPreviewGetColorsUseCaseable = XXXPreviewGetColorsUseCase(),
        getContentUseCase: any XXXPreviewGetContentUseCaseable = XXXPreviewGetContentUseCase(),
        getFontsUseCase: any XXXPreviewGetFontsUseCaseable = XXXPreviewGetFontsUseCase(),
        getImageUseCase: any XXXPreviewGetImageUseCaseable = XXXPreviewGetImageUseCase(),
        getLayoutUseCase: any XXXPreviewGetLayoutUseCaseable = XXXPreviewGetLayoutUseCase()
    ) {
        self.getBorderUseCase = getBorderUseCase
        self.getColorsUseCase = getColorsUseCase
        self.getContentUseCase = getContentUseCase
        self.getFontsUseCase = getFontsUseCase
        self.getImageUseCase = getImageUseCase
        self.getLayoutUseCase = getLayoutUseCase
    }

    // MARK: - Setup

    func setup(
        theme: any Theme,
        file: XXX
    ) {
        self.theme = theme
        self.file = file

        self.setBorder()
        self.setColors()
        self.setContent()
        self.setFonts()
        self.setImage()
        self.setLayout()

        self.alreadyUpdateAll = true
    }

    // MARK: - Private Setter

    private func setBorder() {
        guard let theme, let file else { return }

        self.border = self.getBorderUseCase.execute(
            theme: theme,
            file: file
        )
    }

    private func setColors() {
        guard let theme, let file else { return }

        self.colors = self.getColorsUseCase.execute(
            theme: theme,
            file: file,
            isPressed: self.isPressed
        )
    }

    private func setContent() {
        guard let file else { return }

        self.content = self.getContentUseCase.execute(
            file: file
        )
    }

    private func setFonts() {
        guard let theme else { return }

        self.fonts = self.getFontsUseCase.execute(theme: theme)
    }

    private func setImage() {
        guard let file else { return }

        self.image = self.getImageUseCase.execute(
            file: file
        )
    }

    private func setLayout() {
        guard let theme else { return }

        self.layout = self.getLayoutUseCase.execute(theme: theme)
    }
}
