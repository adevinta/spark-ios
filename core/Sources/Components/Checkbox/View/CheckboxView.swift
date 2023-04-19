//
//  CheckboxView.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct CheckboxView: View {

    // MARK: - Type Alias

    private typealias AccessibilityIdentifier = CheckboxAccessibilityIdentifier

    // MARK: - Public Properties

    public var theming: CheckboxTheming {
        viewModel.theming
    }
    var colors: CheckboxColorables {
        viewModel.colors
    }

    public var accessibilityIdentifier: String?
    public var accessibilityLabel: String?

    @Binding public var selectionState: CheckboxSelectionState

    @State var isPressed: Bool = false

    // MARK: - Private Properties

    @ObservedObject var viewModel: CheckboxViewModel

    @Namespace private var namespace

    private let checkboxPosition: CheckboxPosition

    @ScaledMetric private var checkboxWidth: CGFloat = 20
    @ScaledMetric private var checkboxHeight: CGFloat = 20

    @ScaledMetric private var checkboxSelectedWidth: CGFloat = 14
    @ScaledMetric private var checkboxSelectedHeight: CGFloat = 14

    @ScaledMetric private var checkboxIndeterminateWidth: CGFloat = 12
    @ScaledMetric private var checkboxIndeterminateHeight: CGFloat = 2

    // MARK: - Initialization

    init(
        text: String,
        checkboxPosition: CheckboxPosition = .left,
        theming: CheckboxTheming,
        colorsUseCase: CheckboxColorsUseCaseable = CheckboxColorsUseCase(),
        state: SelectButtonState = .enabled,
        selectionState: Binding<CheckboxSelectionState>,
        accessibilityIdentifier: String? = nil
    ) {
        _selectionState = selectionState
        self.checkboxPosition = checkboxPosition
        viewModel = .init(text: text, theming: theming, colorsUseCase: colorsUseCase, state: state)
        self.accessibilityIdentifier = accessibilityIdentifier
    }

    public init(
        text: String,
        checkboxPosition: CheckboxPosition = .left,
        theming: CheckboxTheming,
        state: SelectButtonState = .enabled,
        selectionState: Binding<CheckboxSelectionState>,
        accessibilityIdentifier: String? = nil
    ) {
        self.init(
            text: text,
            checkboxPosition: checkboxPosition,
            theming: theming,
            colorsUseCase: CheckboxColorsUseCase(),
            state: state,
            selectionState: selectionState,
            accessibilityIdentifier: accessibilityIdentifier
        )
    }

    @ViewBuilder private var checkboxView: some View {
        let tintColor = colors.checkboxTintColor.color
        let iconColor = colors.checkboxIconColor.color
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .if(selectionState == .selected || selectionState == .indeterminate) {
                    $0.fill(tintColor)
                } else: {
                    $0.strokeBorder(tintColor, lineWidth: 2)
                }
                .frame(width: checkboxWidth, height: checkboxHeight)

            switch selectionState {
            case .selected:
                theming.theme.iconography.checkmark
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(iconColor)
                    .frame(width: checkboxSelectedWidth, height: checkboxSelectedHeight)

            case .unselected:
                EmptyView()
            case .indeterminate:
                Capsule()
                    .fill(iconColor)
                    .frame(width: checkboxIndeterminateWidth, height: checkboxIndeterminateHeight)
            }

            let lineWidth: CGFloat = isPressed ? 4 : 0
            RoundedRectangle(cornerRadius: 4)
                .inset(by: -lineWidth / 2)
                .stroke(colors.pressedBorderColor.color, lineWidth: lineWidth)
                .frame(width: checkboxWidth, height: checkboxHeight)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
        }
        .if(selectionState == .selected) {
            $0.accessibilityAddTraits(.isSelected)
        }
        .id(Identifier.checkbox.rawValue)
        .matchedGeometryEffect(id: Identifier.checkbox.rawValue, in: namespace)
    }

    public var body: some View {
        Button(
            action: {
                tapped()
            },
            label: {
                contentView
            }
        )
        .buttonStyle(CheckboxButtonStyle(isPressed: $isPressed))
        .if(accessibilityIdentifier != nil) {
            $0.accessibility(identifier: accessibilityIdentifier!)
        }
    }

    @ViewBuilder private var contentView: some View {
        HStack(alignment: .top) {
            switch checkboxPosition {
            case .left:
                checkboxView

                labelView

                Spacer()
            case .right:
                labelView

                Spacer()

                checkboxView
            }
        }
        .padding(.vertical, 4)
        .opacity(viewModel.opacity)
        .allowsHitTesting(viewModel.interactionEnabled)
        .contentShape(Rectangle())
    }

    private var labelView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.text)
                .font(theming.theme.typography.body1.font)
                .foregroundColor(colors.textColor.color)

            if let message = viewModel.supplementaryMessage {
                Text(message)
                    .font(theming.theme.typography.caption.font)
                    .foregroundColor(colors.checkboxTintColor.color)
            }
        }
        .id(Identifier.content.rawValue)
        .matchedGeometryEffect(id: Identifier.content.rawValue, in: namespace)
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

    private enum Identifier: String {
        case checkbox
        case content
    }
}
