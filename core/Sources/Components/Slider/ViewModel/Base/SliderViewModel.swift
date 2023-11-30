//
//  SliderViewModel.swift
//  SparkCore
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

class SliderViewModel {

    // MARK: - Private Properties
    private let getColorsUseCase: SliderGetColorsUseCasable
    private let getCornerRadiiUseCase: SliderGetCornerRadiiUseCasable
    private let getClosestValueUseCase: SliderGetClosestValueUseCasable

    // MARK: - Internal Properties
    var theme: Theme {
        didSet {
            self.setDim()
            self.setColors()
            self.setRadii()
        }
    }
    var shape: SliderShape {
        didSet {
            guard oldValue != self.shape else { return }
            self.setRadii()
        }
    }
    var intent: SliderIntent {
        didSet {
            guard oldValue != self.intent else { return }
            self.setColors()
        }
    }

    var isEnabled = true {
        didSet {
            guard oldValue != self.isEnabled else { return }
            self.setDim()
        }
    }
    var isContinuous = true

    var steps: Float = 0.0

    // MARK: - Published Colors
    @Published var trackColor: any ColorToken
    @Published var indicatorColor: any ColorToken
    @Published var handleColor: any ColorToken
    @Published var handleActiveIndicatorColor: any ColorToken

    // MARK: - Published Radii
    @Published var trackRadius: CGFloat
    @Published var indicatorRadius: CGFloat

    // MARK: - Published Values
    @Published var minimumValue: Float = .zero
    @Published var maximumValue: Float = 1.0

    // MARK: - Published Dim
    @Published var dim: CGFloat

    required init(theme: Theme,
                  shape: SliderShape,
                  intent: SliderIntent,
                  getColorsUseCase: SliderGetColorsUseCasable = SliderGetColorsUseCase(),
                  getCornerRadiiUseCase: SliderGetCornerRadiiUseCasable = SliderGetCornerRadiiUseCase(),
                  getClosestValueUseCase: SliderGetClosestValueUseCasable = SliderGetClosestValueUseCase()) {
        self.theme = theme
        self.shape = shape
        self.intent = intent
        self.getColorsUseCase = getColorsUseCase
        self.getCornerRadiiUseCase = getCornerRadiiUseCase
        self.getClosestValueUseCase = getClosestValueUseCase

        self.dim = self.theme.dims.none

        let colors = getColorsUseCase.execute(theme: self.theme, intent: self.intent)
        self.trackColor = colors.track
        self.indicatorColor = colors.indicator
        self.handleColor = colors.handle
        self.handleActiveIndicatorColor = colors.handleActiveIndicator

        let radii = getCornerRadiiUseCase.execute(theme: self.theme, shape: self.shape)
        self.trackRadius = radii.trackRadius
        self.indicatorRadius = radii.indicatorRadius
    }

    private func setDim() {
        self.dim = self.isEnabled ? self.theme.dims.none : self.theme.dims.dim3
    }

    private func setColors() {
        let colors = self.getColorsUseCase.execute(theme: self.theme, intent: self.intent)
        self.trackColor = colors.track
        self.indicatorColor = colors.indicator
        self.handleColor = colors.handle
        self.handleActiveIndicatorColor = colors.handleActiveIndicator
    }

    private func setRadii() {
        let radii = getCornerRadiiUseCase.execute(theme: self.theme, shape: self.shape)
        self.trackRadius = radii.trackRadius
        self.indicatorRadius = radii.indicatorRadius
    }

    func getClosestValue(fromValue value: Float) -> Float {
        return self.getClosestValueUseCase.execute(
            from: self.minimumValue,
            to: self.maximumValue,
            withSteps: self.steps,
            fromValue: value
        )
    }
}

final class RangeSliderViewModel: SliderViewModel {

    // MARK: - Published values
    @Published var from: CGFloat = .zero
    @Published var to: CGFloat = 1.0

}
