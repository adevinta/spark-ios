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

    @State var isPressed: Bool = false

    // MARK: - Private Properties

    @ObservedObject var viewModel: SparkCheckboxViewModel

    // MARK: - Initialization

    init(
        text: String,
        theming: SparkCheckboxTheming,
        colorsUseCase: SparkCheckboxColorsUseCaseable = SparkCheckboxColorsUseCase(),
        state: SparkSelectButtonState = .enabled,
        selectionState: Binding<SparkCheckboxSelectionState>
    ) {
        _selectionState = selectionState
        viewModel = .init(text: text, theming: theming, colorsUseCase: colorsUseCase, state: state)
    }

    public init(
        text: String,
        theming: SparkCheckboxTheming,
        state: SparkSelectButtonState = .enabled,
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
        ZStack {
            switch selectionState {
            case .selected:
                RoundedRectangle(cornerRadius: 4)
                    .fill(tintColor)
                    .frame(width: 20, height: 20)

                theming.theme.iconography.checkmark
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(iconColor)
                    .frame(width: 14, height: 14)

            case .unselected:
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(tintColor, lineWidth: 2)
                    .frame(width: 20, height: 20)

            case .indeterminate:
                RoundedRectangle(cornerRadius: 4)
                    .fill(tintColor)
                    .frame(width: 20, height: 20)

                Capsule()
                    .fill(iconColor)
                    .frame(width: 12, height: 2)
            }

            let lineWidth: CGFloat = isPressed ? 4 : 0
            RoundedRectangle(cornerRadius: 4)
                .inset(by: -lineWidth / 2)
                .stroke(colors.pressedBorderColor.color, lineWidth: lineWidth)
                .frame(width: 20, height: 20)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
        }
    }

    public var body: some View {
        Button(
            action: {
                print("tapped", viewModel.text)
                tapped()
            },
            label: {
                contentView
            }
        )
        .buttonStyle(SparkCheckboxStyle(isPressed: $isPressed))
    }

    @ViewBuilder private var contentView: some View {
        HStack(alignment: .top) {
            checkboxView

            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.text)
                    .font(theming.theme.typography.body1.font)
                    .foregroundColor(colors.textColor.color)
                    .accessibilityIdentifier(AccessibilityIdentifier.text)

                if let message = viewModel.supplementaryMessage {
                    Text(message)
                        .font(theming.theme.typography.caption.font)
                        .foregroundColor(colors.checkboxTintColor.color)
                }
            }
        }
        .padding(.vertical, 2)
        .opacity(viewModel.opacity)
        .allowsHitTesting(viewModel.interactionEnabled)
        .contentShape(Rectangle())
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

struct SparkCheckboxStyle: ButtonStyle
{
    @Binding var isPressed: Bool

    init(isPressed: Binding<Bool>) {
        _isPressed = isPressed
    }

    func makeBody(configuration: Self.Configuration) -> some View
    {
        if configuration.isPressed != isPressed {
                if configuration.isPressed
                {
                    print("Button is pressed")
                }
                else
                {
                    print("Button released")
                }
            DispatchQueue.main.async {
                isPressed = configuration.isPressed
            }
        }

        return configuration.label
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
