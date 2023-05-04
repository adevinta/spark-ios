//
//  CheckboxView.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// The `CheckboxView`renders a single checkbox.
public struct CheckboxView: View {

    // MARK: - Public Properties

    /// The current Spark theme.
    public var theme: Theme {
        return self.viewModel.theme
    }

    /// A binding for the selection state of the checkbox (`.selected`, `.unselected` or `.indeterminate`). The value will update when the control is tapped.
    @Binding public var selectionState: CheckboxSelectionState

    // MARK: - Internal Properties

    @State var isPressed: Bool = false

    @ObservedObject var viewModel: CheckboxViewModel

    var colors: CheckboxColorables {
        return self.viewModel.colors
    }

    // MARK: - Private Properties

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
        theme: Theme,
        colorsUseCase: CheckboxColorsUseCaseable = CheckboxColorsUseCase(),
        state: SelectButtonState = .enabled,
        selectionState: Binding<CheckboxSelectionState>
    ) {
        self._selectionState = selectionState
        self.checkboxPosition = checkboxPosition
        self.viewModel = .init(text: text, theme: theme, colorsUseCase: colorsUseCase, state: state)
    }

    /// Initialize a new checkbox.
    /// - Parameters:
    ///   - text: The checkbox text.
    ///   - checkboxPosition: Positions the checkbox on the leading or trailing edge of the view.
    ///   - theme: The current Spark-Theme.
    ///   - state: The control state describes whether the checkbox is enabled or disabled as well as options for displaying success and error messages.
    ///   - selectionState: `CheckboxSelectionState` is either selected, unselected or indeterminate.
    public init(
        text: String,
        checkboxPosition: CheckboxPosition = .left,
        theme: Theme,
        state: SelectButtonState = .enabled,
        selectionState: Binding<CheckboxSelectionState>
    ) {
        self.init(
            text: text,
            checkboxPosition: checkboxPosition,
            theme: theme,
            colorsUseCase: CheckboxColorsUseCase(),
            state: state,
            selectionState: selectionState
        )
    }

    // MARK: - Body

    /// Returns a single rendered checkbox.
    public var body: some View {
        Button(
            action: {
                self.tapped()
            },
            label: {
                self.contentView
            }
        )
        .buttonStyle(CheckboxButtonStyle(isPressed: self.$isPressed))
    }

    @ViewBuilder private var checkboxView: some View {
        let tintColor = self.colors.checkboxTintColor.color
        let iconColor = self.colors.checkboxIconColor.color
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .if(self.selectionState == .selected || self.selectionState == .indeterminate) {
                    $0.fill(tintColor)
                } else: {
                    $0.strokeBorder(tintColor, lineWidth: 2)
                }
                .frame(width: self.checkboxWidth, height: self.checkboxHeight)

            switch self.selectionState {
            case .selected:
                self.theme.iconography.checkmark
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(iconColor)
                    .frame(width: self.checkboxSelectedWidth, height: self.checkboxSelectedHeight)

            case .unselected:
                EmptyView()
            case .indeterminate:
                Capsule()
                    .fill(iconColor)
                    .frame(width: self.checkboxIndeterminateWidth, height: self.checkboxIndeterminateHeight)
            }

            let lineWidth: CGFloat = self.isPressed ? 4 : 0
            RoundedRectangle(cornerRadius: 4)
                .inset(by: -lineWidth / 2)
                .stroke(self.colors.pressedBorderColor.color, lineWidth: lineWidth)
                .frame(width: self.checkboxWidth, height: self.checkboxHeight)
                .animation(.easeInOut(duration: 0.1), value: self.isPressed)
        }
        .if(self.selectionState == .selected) {
            $0.accessibilityAddTraits(.isSelected)
        }
        .id(Identifier.checkbox.rawValue)
        .matchedGeometryEffect(id: Identifier.checkbox.rawValue, in: self.namespace)
    }

    @ViewBuilder private var contentView: some View {
        HStack(alignment: .top) {
            switch checkboxPosition {
            case .left:
                self.checkboxView

                self.labelView

                Spacer()
            case .right:
                self.labelView

                Spacer()

                self.checkboxView
            }
        }
        .padding(.vertical, 4)
        .opacity(self.viewModel.opacity)
        .allowsHitTesting(self.viewModel.interactionEnabled)
        .contentShape(Rectangle())
    }

    private var labelView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.viewModel.text)
                .font(self.theme.typography.body1.font)
                .foregroundColor(self.colors.textColor.color)

            if let message = self.viewModel.supplementaryMessage {
                Text(message)
                    .font(self.theme.typography.caption.font)
                    .foregroundColor(self.colors.checkboxTintColor.color)
            }
        }
        .id(Identifier.content.rawValue)
        .matchedGeometryEffect(id: Identifier.content.rawValue, in: self.namespace)
    }

    // MARK: - Action

    func tapped() {
        guard self.viewModel.interactionEnabled else { return }

        switch self.selectionState {
        case .selected:
            self.selectionState = .unselected
        case .unselected:
            self.selectionState = .selected
        case .indeterminate:
            break
        }
    }

    // MARK: - Enum

    /// The checkbox can be either on the leading or trailing edge of the view.
    public enum CheckboxPosition {
        /// Checkbox on leading edge.
        case left

        /// Checkbox on trailing edge.
        case right
    }

    private enum Identifier: String {
        case checkbox
        case content
    }
}
