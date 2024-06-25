//
// ProgressBarMainViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

// sourcery: AutoPublisherTest, AutoViewModelStub
// sourcery: <GetColorsUseCase> = "ProgressBarMainGetColorsUseCaseableGeneratedMock"
class ProgressBarMainViewModel<
    GetColorsUseCase: ProgressBarMainGetColorsUseCaseable
>: ObservableObject {

    // MARK: - Properties

    private let frameworkType: FrameworkType
    private(set) var theme: Theme
    private(set) var intent: GetColorsUseCase.Intent
    private(set) var shape: ProgressBarShape

    // MARK: - Published Properties

    @Published private (set) var colors: GetColorsUseCase.Return?
    @Published private (set) var cornerRadius: CGFloat?

    // MARK: - Private Properties

    private let getColorsUseCase: GetColorsUseCase
    private let getCornerRadiusUseCase: ProgressBarGetCornerRadiusUseCaseable

    // MARK: - Initialization

    init(
        for frameworkType: FrameworkType,
        theme: Theme,
        intent: GetColorsUseCase.Intent,
        shape: ProgressBarShape,
        getColorsUseCase: GetColorsUseCase,
        getCornerRadiusUseCase: ProgressBarGetCornerRadiusUseCaseable = ProgressBarGetCornerRadiusUseCase()
    ) {
        self.frameworkType = frameworkType

        self.theme = theme
        self.intent = intent
        self.shape = shape

        self.getColorsUseCase = getColorsUseCase
        self.getCornerRadiusUseCase = getCornerRadiusUseCase

        // Load the values directly on init just for SwiftUI
        if frameworkType == .swiftUI {
            self.updateAll()
        }
    }

    // MARK: - Load

    func load() {
        // Update all values when UIKit view is ready to receive published values
        if self.frameworkType == .uiKit {
            self.updateAll()
        }
    }

    // MARK: - Setter

    func set(theme: Theme) {
        self.theme = theme

        self.updateAll()
    }

    func set(intent: GetColorsUseCase.Intent) {
        if self.intent != intent {
            self.intent = intent

            self.colorsDidUpdate()
        }
    }

    func set(shape: ProgressBarShape) {
        if self.shape != shape {
            self.shape = shape

            self.shapeDidUpdate()
        }
    }

    // MARK: - Private Update

    internal func updateAll() {
        self.colorsDidUpdate()
        self.shapeDidUpdate()
    }

    private func colorsDidUpdate() {
        self.colors = self.getColorsUseCase.execute(
            intent: self.intent,
            colors: self.theme.colors,
            dims: self.theme.dims
        )
    }

    private func shapeDidUpdate() {
        self.cornerRadius = self.getCornerRadiusUseCase.execute(
            shape: self.shape,
            border: self.theme.border
        )
    }
}
