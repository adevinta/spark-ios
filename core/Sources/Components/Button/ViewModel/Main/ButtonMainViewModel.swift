//
//  ButtonMainViewModel.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 09.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine

/// This ButtonMainViewModel view contains all communs properties and rules for all buttons viewModel.
// sourcery: AutoPublisherTest, AutoViewModelStub
// sourcery: titleFontToken = "Identical"
class ButtonMainViewModel: ObservableObject {

    // MARK: - Properties

    private(set) var theme: Theme
    private(set) var intent: ButtonIntent
    private(set) var variant: ButtonVariant
    private(set) var size: ButtonSize
    private(set) var shape: ButtonShape
    private(set) var isEnabled: Bool = true

    // MARK: - Published Properties

    @Published private(set) var state: ButtonState?

    @Published private(set) var currentColors: ButtonCurrentColors?

    @Published private(set) var sizes: ButtonSizes?
    @Published private(set) var border: ButtonBorder?

    // MARK: - Private Properties

    private let frameworkType: FrameworkType
    private let type: ButtonType

    private var colors: ButtonColors?

    private var isPressed: Bool = false

    // MARK: - UseCases

    let getBorderUseCase: ButtonGetBorderUseCaseable
    let getColorsUseCase: ButtonGetColorsUseCaseable
    let getCurrentColorsUseCase: ButtonGetCurrentColorsUseCaseable
    let getSizesUseCase: ButtonGetSizesUseCaseable
    let getStateUseCase: ButtonGetStateUseCaseable

    // MARK: - Initialization

    init(
        for frameworkType: FrameworkType,
        type: ButtonType,
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        getBorderUseCase: ButtonGetBorderUseCaseable = ButtonGetBorderUseCase(),
        getColorsUseCase: ButtonGetColorsUseCaseable = ButtonGetColorsUseCase(),
        getCurrentColorsUseCase: ButtonGetCurrentColorsUseCaseable = ButtonGetCurrentColorsUseCase(),
        getSizesUseCase: ButtonGetSizesUseCaseable = ButtonGetSizesUseCase(),
        getStateUseCase: ButtonGetStateUseCaseable = ButtonGetStateUseCase()
    ) {
        self.frameworkType = frameworkType
        self.type = type
        self.theme = theme
        self.intent = intent
        self.variant = variant
        self.size = size
        self.shape = shape
        
        self.getBorderUseCase = getBorderUseCase
        self.getColorsUseCase = getColorsUseCase
        self.getCurrentColorsUseCase = getCurrentColorsUseCase
        self.getSizesUseCase = getSizesUseCase
        self.getStateUseCase = getStateUseCase

        // Load the values directly on init just for SwiftUI
        if frameworkType == .swiftUI {
            self.updateAll()
        }
    }

    // MARK: - Load

    /// Load all published values. Should be called when all published values are subscribed by the view
    func load() {
        // Update all values when view is ready to receive published values
        self.updateAll()
    }

    // MARK: - Actions

    func pressedAction(_ isPressed: Bool) {
        if self.isPressed != isPressed {
            self.isPressed.toggle()

            self.colorsDidUpdate(reloadColorsFromUseCase: false)
        }
    }

    // MARK: - Setter

    func set(theme: Theme) {
        self.theme = theme

        self.updateAll()
    }

    func set(intent: ButtonIntent) {
        if self.intent != intent {
            self.intent = intent

            self.colorsDidUpdate(reloadColorsFromUseCase: true)
        }
    }

    func set(variant: ButtonVariant) {
        if self.variant != variant {
            self.variant = variant

            self.colorsDidUpdate(reloadColorsFromUseCase: true)
            self.borderDidUpdate()
        }
    }

    func set(size: ButtonSize) {
        if self.size != size {
            self.size = size

            self.sizesDidUpdate()
        }
    }

    func set(shape: ButtonShape) {
        if self.shape != shape {
            self.shape = shape

            self.borderDidUpdate()
        }
    }

    func set(isEnabled: Bool) {
        if self.isEnabled != isEnabled {
            self.isEnabled = isEnabled

            self.stateDidUpdate()
        }
    }

    // MARK: - Update

    internal func updateAll() {
        self.stateDidUpdate()
        self.colorsDidUpdate(reloadColorsFromUseCase: true)
        self.sizesDidUpdate()
        self.borderDidUpdate()
    }

    private func stateDidUpdate() {
        self.state = self.getStateUseCase.execute(
            isEnabled: self.isEnabled,
            dims: self.theme.dims
        )
    }

    private func colorsDidUpdate(
        reloadColorsFromUseCase: Bool
    ) {
        if reloadColorsFromUseCase {
            self.colors = self.getColorsUseCase.execute(
                theme: self.theme,
                intent: self.intent,
                variant: self.variant
            )
        }

        guard let colors = self.colors else {
            return
        }

        self.currentColors = self.getCurrentColorsUseCase.execute(
            colors: colors,
            isPressed: self.isPressed
        )
    }

    private func sizesDidUpdate() {
        self.sizes = self.getSizesUseCase.execute(
            size: self.size,
            type: self.type
        )
    }

    private func borderDidUpdate() {
        self.border = self.getBorderUseCase.execute(
            shape: self.shape,
            border: self.theme.border,
            variant: self.variant
        )
    }
}
