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

    // MARK: - Type Alias

    private typealias AccessibilityIdentifier = CheckboxAccessibilityIdentifier

    // MARK: - Public Properties

    public var theming: Theme {
        return self.viewModel.theming
    }

    public var accessibilityIdentifier: String?
    public var accessibilityLabel: String?

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
        theming: Theme,
        colorsUseCase: CheckboxColorsUseCaseable = CheckboxColorsUseCase(),
        state: SelectButtonState = .enabled,
        selectionState: Binding<CheckboxSelectionState>,
        accessibilityIdentifier: String? = nil
    ) {
        self._selectionState = selectionState
        self.checkboxPosition = checkboxPosition
        self.viewModel = .init(text: text, theming: theming, colorsUseCase: colorsUseCase, state: state)
        self.accessibilityIdentifier = accessibilityIdentifier
    }

    /// Initialize a new checkbox.
    /// - Parameters:
    ///   - text: The checkbox text.
    ///   - checkboxPosition: Positions the checkbox on the leading or trailing edge of the view.
    ///   - theming: The current Spark-Theme.
    ///   - state: The control state describes whether the checkbox is enabled or disabled as well as options for displaying success and error messages.
    ///   - selectionState: `CheckboxSelectionState` is either selected, unselected or indeterminate.
    ///   - accessibilityIdentifier: The accessibility identifier.
    public init(
        text: String,
        checkboxPosition: CheckboxPosition = .left,
        theming: Theme,
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

    // MARK: - Body

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
        .if(self.accessibilityIdentifier != nil) {
            $0.accessibility(identifier: self.accessibilityIdentifier!)
        }
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
                self.theming.iconography.checkmark
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
                .font(self.theming.typography.body1.font)
                .foregroundColor(self.colors.textColor.color)

            if let message = self.viewModel.supplementaryMessage {
                Text(message)
                    .font(self.theming.typography.caption.font)
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

    public enum CheckboxPosition {
        case left
        case right
    }

    private enum Identifier: String {
        case checkbox
        case content
    }
}
