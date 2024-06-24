//
//  SliderViewModel.swift
//  SparkCore
//
//  Created by louis.borlee on 19/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

class SliderViewModel<V>: ObservableObject where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint  {

    // MARK: - Private Properties
    private let getColorsUseCase: SliderGetColorsUseCasable
    private let getCornerRadiiUseCase: SliderGetCornerRadiiUseCasable
    private let getStepValuesInBoundsUseCase: SliderGetStepValuesInBoundsUseCasable
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

    // TODO: var numberOfSteps

    var step: V.Stride? {
        didSet {
            guard self.step != oldValue else { return }
            self.setStepValues()
        }
    }
    private(set) var stepValues: [V]?

    // MARK: - Published Colors
    @Published var trackColor: any ColorToken
    @Published var indicatorColor: any ColorToken
    @Published var handleColor: any ColorToken
    @Published var handleActiveIndicatorColor: any ColorToken

    // MARK: - Published Radii
    @Published var trackRadius: CGFloat
    @Published var indicatorRadius: CGFloat

    // MARK: - Published Bounds
    @Published var bounds: ClosedRange<V> = 0...1 {
        didSet {
            guard self.bounds != oldValue else { return }
            self.setStepValues()
        }
    }

    // MARK: - Published Dim
    @Published var dim: CGFloat

    required init(theme: Theme,
                  shape: SliderShape,
                  intent: SliderIntent,
                  getColorsUseCase: SliderGetColorsUseCasable = SliderGetColorsUseCase(),
                  getCornerRadiiUseCase: SliderGetCornerRadiiUseCasable = SliderGetCornerRadiiUseCase(),
                  getStepValuesInBoundsUseCase: SliderGetStepValuesInBoundsUseCasable = SliderGetStepValuesInBoundsUseCase(),
                  getClosestValueUseCase: SliderGetClosestValueUseCasable = SliderGetClosestValueUseCase()) {
        self.theme = theme
        self.shape = shape
        self.intent = intent
        self.getColorsUseCase = getColorsUseCase
        self.getCornerRadiiUseCase = getCornerRadiiUseCase
        self.getStepValuesInBoundsUseCase = getStepValuesInBoundsUseCase
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

    private func setStepValues() {
        if let step {
            self.stepValues = self.getStepValuesInBoundsUseCase.execute(bounds: self.bounds, step: step)
        } else {
            self.stepValues = nil
        }
    }

    func resetBoundsIfNeeded() {
        guard let lastValue = self.stepValues?.last,
              lastValue < self.bounds.upperBound else {
            return
        }
        self.bounds = self.bounds.lowerBound...lastValue
    }

    func getClosestValue(fromValue value: V) -> V {
        let boundedValue = max(self.bounds.lowerBound, min(self.bounds.upperBound, value))
        guard let stepValues else {
            return boundedValue
        }
        return self.getClosestValueUseCase.execute(value: boundedValue, in: stepValues)
    }
}
