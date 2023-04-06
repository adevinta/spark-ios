//
//  SparkCheckboxView.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct SparkCheckboxView: View {

    // MARK: - Type Alias

    private typealias AccessibilityIdentifier = SparkTagAccessibilityIdentifier

    // MARK: - Public Properties

    public var theming: SparkCheckboxTheming {
        viewModel.theming
    }
    var colors: SparkCheckboxColorables {
        viewModel.colors
    }

    public var accessibilityIdentifier: String?
    public var accessibilityLabel: String?

    @Binding public var selectionState: SparkCheckboxSelectionState

    // MARK: - Private Properties

    @ObservedObject var viewModel: SparkCheckboxViewModel

    // MARK: - Initialization

    init(
        text: String,
        theming: SparkCheckboxTheming,
        colorsUseCase: SparkCheckboxColorsUseCaseable = SparkCheckboxColorsUseCase(),
        state: SparkCheckboxState = .enabled,
        selectionState: Binding<SparkCheckboxSelectionState>
    ) {
        self._selectionState = selectionState
        self.viewModel = .init(text: text, theming: theming, colorsUseCase: colorsUseCase, state: state)
    }

    public init(
        text: String,
        theming: SparkCheckboxTheming,
        state: SparkCheckboxState = .enabled,
        selectionState: Binding<SparkCheckboxSelectionState>
    ) {
        self.init(
            text: text,
            theming: theming,
            colorsUseCase: SparkCheckboxColorsUseCase(),
            state: state,
            selectionState: selectionState
        )
    }

    @ViewBuilder private var checkboxView: some View {
        let tintColor = colors.checkboxTintColor.color
        let iconColor = colors.checkboxIconColor.color
        switch selectionState {
        case .selected:
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(tintColor)
                    .frame(width: 20, height: 20)

                Image(systemName: "globe")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(iconColor)
                    .frame(width: 14, height: 14)
            }
        case .unselected:
            RoundedRectangle(cornerRadius: 4)
                .strokeBorder(tintColor, lineWidth: 2)
                .frame(width: 20, height: 20)
        case .indeterminate:
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(tintColor)
                    .frame(width: 20, height: 20)

                Capsule()
                    .fill(iconColor)
                    .frame(width: 12, height: 2)
            }
        }
    }

    public var body: some View {
        HStack(alignment: .top) {
            checkboxView

            Text(viewModel.text)
                .font(self.theming.theme.typography.body1.font)
                .foregroundColor(self.colors.textColor.color)
                .accessibilityIdentifier(AccessibilityIdentifier.text)
        }
        .opacity(viewModel.opacity)
        .allowsHitTesting(viewModel.interactionEnabled)
        .contentShape(Rectangle())
        .onTapGesture {
            print("tapped", viewModel.text)
            tapped()
        }
    }

    func tapped() {
        guard viewModel.interactionEnabled else { return }

        switch selectionState {
        case .selected:
            selectionState = .unselected
        case .unselected:
            selectionState = .selected
        case .indeterminate:
            break
        }
    }
}
