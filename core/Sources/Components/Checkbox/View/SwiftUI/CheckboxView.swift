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
    
    private var spacing: LayoutSpacing {
        return self.theme.layout.spacing
    }

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

    init(
        text: String,
        checkedImage: UIImage,
        alignment: CheckboxAlignment = .left,
        theme: Theme,
        intent: CheckboxIntent = .main,
        colorsUseCase: CheckboxColorsUseCaseable = CheckboxColorsUseCase(),
        isEnabled: Bool = true,
        selectionState: Binding<CheckboxSelectionState>
    ) {
        self._horizontalSpacing = .init(wrappedValue: theme.layout.spacing.medium)
        self._selectionState = selectionState
        self.viewModel = .init(
            text: .right(text),
            checkedImage: checkedImage,
            theme: theme,
            intent: intent,
            colorsUseCase: colorsUseCase,
            isEnabled: isEnabled,
            alignment: alignment,
            selectionState: selectionState.wrappedValue
        )
    }

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
        text: String,
        checkedImage: UIImage,
        alignment: CheckboxAlignment = .left,
        theme: Theme,
        intent: CheckboxIntent = .main,
        isEnabled: Bool = true,
        selectionState: Binding<CheckboxSelectionState>
    ) {
        self.init(
            text: text,
            checkedImage: checkedImage,
            alignment: alignment,
            theme: theme,
            intent: intent,
            colorsUseCase: CheckboxColorsUseCase(),
            isEnabled: isEnabled,
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
        .accessibilityIdentifier(CheckboxAccessibilityIdentifier.checkbox)
    }

    @ViewBuilder private var checkboxView: some View {
        let tintColor = self.viewModel.colors.tintColor.color
        let iconColor = self.viewModel.colors.iconColor.color
        let borderColor = self.viewModel.colors.borderColor.color
        ZStack {
            RoundedRectangle(cornerRadius: self.checkboxBorderRadius)
                .if(self.selectionState == .selected || self.selectionState == .indeterminate) {
                    $0.fill(tintColor)
                } else: {
                    $0.strokeBorder(borderColor, lineWidth: self.checkboxBorderWidth)
                }
                .frame(width: self.checkboxSize, height: self.checkboxSize)
                .if(self.isPressed && self.viewModel.isEnabled) {
                    $0.overlay(
                        RoundedRectangle(cornerRadius: self.checkboxBorderRadius)
                            .inset(by: -self.checkboxSelectedBorderWidth / 2)
                            .stroke(self.viewModel.colors.pressedBorderColor.color, lineWidth: self.checkboxSelectedBorderWidth)
                            .animation(.easeInOut(duration: 0.1), value: self.isPressed)
                    )
                }

            switch self.selectionState {
            case .selected:
                Image(uiImage: self.viewModel.checkedImage)
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
        .if(self.selectionState == .selected) {
            $0.accessibilityAddTraits(.isSelected)
        }
        .id(Identifier.checkbox.rawValue)
        .matchedGeometryEffect(id: Identifier.checkbox.rawValue, in: self.namespace)
    }

    @ViewBuilder private var contentView: some View {
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
                self.labelView.padding(.trailing, self.horizontalSpacing * 3)
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
                .font(self.theme.typography.body1.font)
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
