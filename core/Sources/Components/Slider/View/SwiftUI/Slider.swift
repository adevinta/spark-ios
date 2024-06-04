//
//  Slider.swift
//  SparkCore
//
//  Created by louis.borlee on 15/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Combine
@_spi(SI_SPI) import SparkCommon
import SparkTheming

public struct Slider<V>: View where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {

    @ObservedObject private var viewModel: SingleSliderViewModel<V>

    @State private var isEditing: Bool = false

    @Binding var value: V

    private var onEditingChanged: (Bool) -> Void

    private init(value: Binding<V>,
                 in bounds: ClosedRange<V>,
                 step: V.Stride?,
                 theme: Theme,
                 shape: SliderShape,
                 intent: SliderIntent,
                 onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self._value = value

        let viewModel = SingleSliderViewModel<V>(theme: theme, shape: shape, intent: intent)
        viewModel.bounds = bounds
        viewModel.step = step
        viewModel.resetBoundsIfNeeded()
        viewModel.setValue(value.wrappedValue)

        self.viewModel = viewModel

        self.onEditingChanged = onEditingChanged
    }

    public init(theme: Theme,
                shape: SliderShape,
                intent: SliderIntent,
                value: Binding<V>,
                in bounds: ClosedRange<V> = 0...1,
                onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value,
                  in: bounds,
                  step: nil,
                  theme: theme,
                  shape: shape,
                  intent: intent,
                  onEditingChanged: onEditingChanged)
    }

    public init(theme: Theme,
                shape: SliderShape,
                intent: SliderIntent,
                value: Binding<V>,
                in bounds: ClosedRange<V> = 0...1,
                step: V.Stride = 1,
                onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value,
                  in: bounds,
                  step: step != .zero ? step : nil,
                  theme: theme,
                  shape: shape,
                  intent: intent,
                  onEditingChanged: onEditingChanged)
    }

    public var body: some View {
        GeometryReader(content: { geometry in
            let sliderHandleCenterX = self.getHandleXPosition(frameWidth: geometry.size.width)
            ZStack {
                HStack(spacing: .zero) {
                    RoundedRectangle(cornerRadius: self.viewModel.indicatorRadius)
                        .foregroundColor(self.viewModel.indicatorColor.color)
                        .frame(width: sliderHandleCenterX)
                    RoundedRectangle(cornerRadius: self.viewModel.trackRadius)
                        .foregroundColor(self.viewModel.trackColor.color)
                }
                .frame(height: SliderConstants.barHeight)
                SliderHandle(
                    viewModel: .init(color: self.viewModel.handleColor, activeIndicatorColor: self.viewModel.handleActiveIndicatorColor),
                    isEditing: self.$isEditing)
                .position(x: sliderHandleCenterX,
                          y: geometry.size.height / 2.0)
            }
            .gesture(
                DragGesture(minimumDistance: .zero)
                    .onChanged({ value in
                        self.isEditing = true
                        self.moveHandle(to: value.location.x, width: geometry.size.width)
                    })
                    .onEnded({ value in
                        self.isEditing = false
                    })
            )
        })
        .compositingGroup()
        .opacity(self.viewModel.dim)
        .frame(height: SliderConstants.handleSize.height)
        .onChange(of: self.isEditing, perform: { value in
            self.onEditingChanged(value)
        })
        .onChange(of: self.viewModel.value, perform: { value in
            self.value = value
        })
        .isEnabledChanged { isEnabled in
            self.viewModel.isEnabled = isEnabled
        }
        .accessibilityElement()
        .accessibilityIdentifier(SliderAccessibilityIdentifier.slider)
        .accessibilityValue(self.getAccessibilityValue())
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .decrement:
                self.viewModel.decrementValue()
            case .increment:
                self.viewModel.incrementValue()
            @unknown default:
                break
            }
        }
    }

    private func moveHandle(to: CGFloat, width: CGFloat) {
        let absoluteX = max(SliderConstants.handleSize.width / 2, min(to, width - SliderConstants.handleSize.width / 2))
        let relativeX = (absoluteX - SliderConstants.handleSize.width / 2) / (width - SliderConstants.handleSize.width)
        let newValue = V(relativeX) * (self.viewModel.bounds.upperBound - self.viewModel.bounds.lowerBound) + self.viewModel.bounds.lowerBound
        self.viewModel.setValue(newValue)
    }

    private func getHandleXPosition(frameWidth: CGFloat) -> CGFloat {
        guard self.viewModel.bounds.lowerBound != self.viewModel.bounds.upperBound else {
            return SliderConstants.handleSize.width / 2
        }
        let value = (max(self.viewModel.bounds.lowerBound, self.value) - self.viewModel.bounds.lowerBound) / (self.viewModel.bounds.upperBound - self.viewModel.bounds.lowerBound)
        return (frameWidth - SliderConstants.handleSize.width) * CGFloat(value) + SliderConstants.handleSize.width / 2
    }

    private func getAccessibilityValue() -> String {
        let percentage = ((self.value - self.viewModel.bounds.lowerBound) * 100) / (self.viewModel.bounds.upperBound - self.viewModel.bounds.lowerBound)
        return "\(Int(round(percentage)))%"
    }
}
