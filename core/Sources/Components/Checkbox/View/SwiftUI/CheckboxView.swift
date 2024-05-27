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

    // MARK: - Constants

    enum Constants {
        static var checkboxSize: CGFloat = 24
        static var checkboxBorderRadius: CGFloat = 4
        static var checkboxBorderWidth: CGFloat = 2

        static var checkboxSelectedSize: CGFloat = 17
        static var checkboxSelectedBorderWidth: CGFloat = 4

        static var checkboxIndeterminateWidth: CGFloat = 14
        static var checkboxIndeterminateHeight: CGFloat = 2
    }

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

    // MARK: - Private Properties
    
    @Namespace private var namespace

    @ScaledMetric var checkboxSize: CGFloat = Constants.checkboxSize
    @ScaledMetric private var checkboxBorderRadius: CGFloat = Constants.checkboxBorderRadius
    @ScaledMetric private var checkboxBorderWidth: CGFloat = Constants.checkboxBorderWidth

    @ScaledMetric private var checkboxSelectedSize: CGFloat = Constants.checkboxSelectedSize
    @ScaledMetric var checkboxSelectedBorderWidth: CGFloat = Constants.checkboxSelectedBorderWidth

    @ScaledMetric private var checkboxIndeterminateWidth: CGFloat = Constants.checkboxIndeterminateWidth
    @ScaledMetric private var checkboxIndeterminateHeight: CGFloat = Constants.checkboxIndeterminateHeight

    @ScaledMetric private var horizontalSpacing: CGFloat

    // MARK: - Initialization

    /// Initialize a new checkbox.
    /// - Parameters:
    ///   - text: The checkbox text.
    ///   - checkedImage: The tick-checkbox image for checked-state.
    ///   - alignment: Positions the checkbox on the leading or trailing edge of the view.
    ///   - theme: The current Spark-Theme.
    ///   - intent: The current Intent.
    ///   - state: The control state describes whether the checkbox is enabled or disabled as well as options for displaying success and error messages.
    ///   - selectionState: `CheckboxSelectionState` is either selected, unselected or indeterminate.
    public init(
        text: String?,
        checkedImage: Image,
        alignment: CheckboxAlignment = .left,
        theme: Theme,
        intent: CheckboxIntent = .main,
        isEnabled: Bool = true,
        selectionState: Binding<CheckboxSelectionState>
    ) {
        self._selectionState = selectionState
        let viewModel = CheckboxViewModel(
            text: .right(text),
            checkedImage: .right(checkedImage),
            theme: theme,
            intent: intent,
            isEnabled: isEnabled,
            alignment: alignment,
            selectionState: selectionState.wrappedValue
        )
        self.viewModel = viewModel
        self._horizontalSpacing = .init(wrappedValue: viewModel.spacing)
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
        .buttonStyle(PressedButtonStyle(isPressed: self.$isPressed))
        .accessibilityIdentifier(CheckboxAccessibilityIdentifier.checkbox)
        .isEnabledChanged { isEnabled in
            self.viewModel.isEnabled = isEnabled
        }
    }

    @ViewBuilder 
    private var checkboxView: some View {
        if self.selectionState == .selected {
            self.checkbox().accessibilityAddTraits(.isSelected)
        } else {
            self.checkbox()
        }
    }

    @ViewBuilder
    private func checkbox() -> some View {
        let iconColor = self.viewModel.colors.iconColor.color

        ZStack {
            self.stateFullCheckboxRectangle()

            switch self.selectionState {
            case .selected:
                self.viewModel.checkedImage.rightValue
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(iconColor)
                    .frame(width: self.checkboxSelectedSize, height: self.checkboxSelectedSize)

            case .unselected:
                EmptyView()
            case .indeterminate:
                Capsule()
                    .fill(iconColor)
                    .frame(width: self.checkboxIndeterminateWidth, height: self.checkboxIndeterminateHeight)
            }
        }
        .id(Identifier.checkbox.rawValue)
        .matchedGeometryEffect(id: Identifier.checkbox.rawValue, in: self.namespace)
    }

    @ViewBuilder
    private func stateFullCheckboxRectangle() -> some View {
        if self.isPressed && self.viewModel.isEnabled {
            self.checkboxRectangle()
                .overlay(
                    RoundedRectangle(cornerRadius: self.checkboxBorderRadius)
                        .inset(by: -self.checkboxSelectedBorderWidth / 2)
                        .stroke(self.viewModel.colors.pressedBorderColor.color, lineWidth: self.checkboxSelectedBorderWidth)
                        .animation(.easeInOut(duration: 0.1), value: self.isPressed)
                )
        } else {
            self.checkboxRectangle()
        }
    }

    @ViewBuilder
    private func checkboxRectangle() -> some View {
        let tintColor = self.viewModel.colors.tintColor.color
        let borderColor = self.viewModel.colors.borderColor.color

        RoundedRectangle(cornerRadius: self.checkboxBorderRadius)
            .if(self.selectionState == .selected || self.selectionState == .indeterminate) {
                $0.fill(tintColor)
            } else: {
                $0.strokeBorder(borderColor, lineWidth: self.checkboxBorderWidth)
            }
            .frame(width: self.checkboxSize, height: self.checkboxSize)
    }

    @ViewBuilder 
    private var contentView: some View {
        HStack(spacing: 0) {
            switch self.viewModel.alignment {
            case .left:
                VStack {
                    self.checkboxView.padding(.trailing, self.horizontalSpacing)
                    Spacer(minLength: 0)
                }
                self.labelView
                Spacer(minLength: 0)
            case .right:
                self.labelView.padding(.trailing, self.horizontalSpacing)
                Spacer(minLength: 0)
                VStack {
                    self.checkboxView
                    Spacer(minLength: 0)
                }
            }
        }
        .opacity(self.viewModel.opacity)
        .allowsHitTesting(self.viewModel.isEnabled)
        .contentShape(Rectangle())
    }

    private var labelView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.viewModel.text.rightValue ?? "")
                .font(self.viewModel.font.font)
                .foregroundColor(self.viewModel.colors.textColor.color)
                .fixedSize(horizontal: false, vertical: true)
        }
        .id(Identifier.content.rawValue)
        .matchedGeometryEffect(id: Identifier.content.rawValue, in: self.namespace)
    }

    // MARK: - Action

    func tapped() {
        guard self.viewModel.isEnabled else { return }

        switch self.selectionState {
        case .selected:
            self.selectionState = .unselected
        case .unselected, .indeterminate:
            self.selectionState = .selected
        }
    }

    private enum Identifier: String {
        case checkbox
        case content
    }
}
