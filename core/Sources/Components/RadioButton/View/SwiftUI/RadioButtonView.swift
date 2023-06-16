//
//  RadioButtonView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 05.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

private enum Constants {
    static let pressedLineWidth: CGFloat = 4
    static let lineWidth: CGFloat = 2
    static let size: CGFloat = 20
    static let filledSize: CGFloat = 10
}
/// RadioButtonView is a single radio button control.
/// Radio buttons are used for selecting a single value from a selection of values.
/// The values from which can be selected need to be ``Equatable`` & ``CustomStringConvertible``.
///
/// The radio button is created by providing:
/// - A theme
/// - A unique ID
/// - A label representing the value to be selected
/// - The current selected ID: this is a binding and will change, when the button is selected.
/// - State: see ``SparkSelectButtonState``. The default state is ``.enabled``
///
/// **Example**
/// ```swift
///    @State var selectedID: Int = 1
///    var body: any View {
///       VStack(alignment: .leading) {
///           RadioButtonView(theme: theme, id: 1, label: "label 1", selectedID: self.$selectedID)
///           RadioButtonView(theme: theme, id: 2, label: "label 2", selectedID: self.$selectedID)
///       )
///    }
///  ```
///
///  An alternative to using ``RadioButtonViews`` is to use the ``RadioButtonGroupView``.
public struct RadioButtonView<ID: Equatable & CustomStringConvertible>: View {

    // MARK: - Injected Properties

    @ObservedObject private var viewModel: RadioButtonViewModel<ID>

    // MARK: - Local Properties

    @ScaledMetric private var pressedLineWidth: CGFloat = Constants.pressedLineWidth
    @ScaledMetric private var lineWidth: CGFloat = Constants.lineWidth
    @ScaledMetric private var size: CGFloat = Constants.size
    @ScaledMetric private var filledSize: CGFloat = Constants.filledSize
    @ScaledMetric private var spacing: CGFloat

    @State private var isPressed: Bool = false

    private var radioButtonSize: CGFloat {
        return self.size + (self.pressedLineWidth * 2)
    }

    // MARK: - Initialization

    /// - Parameters:
    ///   - theme: The theme used for designing colors and font of the radio button.
    ///   - id: A unique ID identifing the value of the item
    ///   - label: A text describing the value
    ///   - selectedID: A binding to which the id of the radio button will be assigned when selected.
    ///   - state: The current state, default value is `.enabled`
    ///   - labelPostion: The position of the label according to the radio button toggle. Default is `right`
    public init(theme: Theme,
                id: ID,
                label: String,
                selectedID: Binding<ID>,
                state: SparkSelectButtonState = .enabled,
                labelPosition: RadioButtonLabelPosition = .right) {
        let viewModel = RadioButtonViewModel(
            theme: theme,
            id: id,
            label: label,
            selectedID: selectedID,
            state: state,
            labelPosition: labelPosition)
        self.init(viewModel: viewModel)
    }

    init(viewModel: RadioButtonViewModel<ID>) {
        self.viewModel = viewModel
        self._spacing = ScaledMetric(wrappedValue: viewModel.spacing)
    }

    // MARK: - Content

    public var body: some View {
        Button(action: {
            self.viewModel.setSelected()
        }, label: {
            self.buttonAndLabel()
        })
        .disabled(self.viewModel.isDisabled)
        .opacity(self.viewModel.opacity)
        .buttonStyle(RadioButtonButtonStyle(isPressed: self.$isPressed))
        .accessibilityLabel(self.viewModel.label)
        .accessibilityValue(self.viewModel.id.description)
    }

    // MARK: - View modifier

    public func state(_ state: SparkSelectButtonState) -> Self {
        self.viewModel.set(state: state)
        return self
    }

    public func theme(_ theme: Theme) -> Self {
        self.viewModel.set(theme: theme)
        return self
    }

    public func labelPosition(_ labelPosition: RadioButtonLabelPosition) -> Self {
        self.viewModel.set(labelPosition: labelPosition)
        return self
    }

    // MARK: - Private Functions
    @ViewBuilder
    private func buttonAndLabel() -> some View {
        if self.viewModel.labelPosition == .right {
            HStack(alignment: .top, spacing: self.spacing) {
                self.radioButton()
                self.labelAndSublabel()
            }
        } else  {
            HStack(alignment: .top, spacing: 0) {
                self.labelAndSublabel()

                Spacer()

                self.radioButton()
                    .padding(.leading, viewModel.spacing)
            }
        }
    }

    @ViewBuilder
    private func labelAndSublabel() -> some View {
        VStack(alignment: .leading) {
            Text(self.viewModel.label)
                .font(self.viewModel.font.font)
                .multilineTextAlignment(.leading)
                .foregroundColor(self.viewModel.surfaceColor.color)

            if let supplementaryLabel = self.viewModel.supplementaryText {
                Text(supplementaryLabel)
                    .font(self.viewModel.supplemetaryFont.font)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(self.viewModel.colors.subLabel.color)
            }
        }
    }

    @ViewBuilder
    private func radioButton() -> some View {
        let colors = self.viewModel.colors

        ZStack {
            Circle()
                .strokeBorder(
                    isPressed ? colors.halo.color : .clear,
                    lineWidth: self.pressedLineWidth
                )

            Circle()
                .strokeBorder(
                    colors.button.color,
                    lineWidth: self.lineWidth
                )
                .frame(width: self.size, height: self.size)

            Circle()
                .fill()
                .foregroundColor(colors.fill.color)
                .frame(width: self.filledSize, height: self.filledSize)
        }
        .frame(width: self.radioButtonSize,
               height: self.radioButtonSize)
        .padding(-self.pressedLineWidth)
        .animation(.easeIn(duration: 0.1), value: self.viewModel.selectedID)
    }

    // MARK: - Button Style

    private struct RadioButtonButtonStyle: ButtonStyle {
        @Binding var isPressed: Bool

        func makeBody(configuration: Self.Configuration) -> some View {
            if configuration.isPressed != self.isPressed {
                DispatchQueue.main.async {
                    self.isPressed = configuration.isPressed
                }
            }
            return configuration.label
                .animation(.easeOut(duration: 0.2), value: self.isPressed)
        }
    }
}
