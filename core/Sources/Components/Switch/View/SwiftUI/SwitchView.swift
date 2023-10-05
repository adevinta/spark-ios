//
//  SwitchView.swift
//  SparkCore
//
//  Created by robin.lemaire on 11/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct SwitchView: View {

    // MARK: - Type alias

    private typealias AccessibilityIdentifier = SwitchAccessibilityIdentifier
    private typealias Constants = SwitchConstants

    // MARK: - Properties

    @ObservedObject private var viewModel: SwitchViewModel

    @Binding private var isOn: Bool

    @ScaledMetric private var contentStackViewSpacingMultiplier: CGFloat = .scaledMetricMultiplier
    @ScaledMetric private var toggleHeight: CGFloat = Constants.ToggleSizes.height
    @ScaledMetric private var toggleWidth: CGFloat = Constants.ToggleSizes.width
    @ScaledMetric private var togglePadding: CGFloat = Constants.ToggleSizes.padding
    @ScaledMetric private var toggleDotPadding: CGFloat = Constants.toggleDotImagePadding

    // MARK: - Initialization

    /// Initialize a new switch view
    /// - Parameters:
    ///   - theme: The spark theme of the switch.
    ///   - isOn: The Binding value of the switch.
    public init(
        theme: any Theme,
        isOn: Binding<Bool>
    ) {
        self.viewModel = .init(
            for: .swiftUI,
            theme: theme,
            isOn: isOn.wrappedValue,
            alignment: .left,
            intent: .main,
            isEnabled: false,
            images: nil,
            text: nil,
            attributedText: nil
        )
        self._isOn = isOn
    }

    // MARK: - View
    
    public var body: some View {
        HStack(alignment: .top) {
            ForEach(self.subviewsTypes(), id: \.self) {
                self.makeSubview(from: $0)
            }
        }
        .onChange(of: self.viewModel.isOnChanged) { isOn in
            guard let isOn else { return }
            self.isOn = isOn
        }
    }

    // MARK: - Subview Maker

    private func subviewsTypes() -> [SwitchSubviewType] {
        return (self.viewModel.isToggleOnLeft == true) ? SwitchSubviewType.leftAlignmentCases : SwitchSubviewType.rightAlignmentCases
    }

    @ViewBuilder
    private func makeSubview(from type: SwitchSubviewType) -> some View {
        switch type {
        case .space:
            self.space()
        case .text:
            self.text()
        case .toggle:
            self.toggle()
        }
    }

    // MARK: - Subview Builder

    @ViewBuilder
    private func text() -> some View {
        if let text = self.viewModel.displayedText?.text {
            Text(text)
                .font(self.viewModel.textFontToken?.font)
                .foregroundColor(self.viewModel.textForegroundColorToken?.color ?? .clear)
                .applyStyle()
        } else if let attributedText = self.viewModel.displayedText?.attributedText?.rightValue {
            Text(attributedText)
                .applyStyle()
        }
    }

    @ViewBuilder
    private func space() -> some View {
        Spacer()
            .frame(
                width: self.viewModel.horizontalSpacing.scaledMetric(
                    with: self.contentStackViewSpacingMultiplier
                )
            )
    }

    @ViewBuilder
    private func toggle() -> some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: self.viewModel.theme.border.radius.full
            )
            .fill(self.viewModel.toggleBackgroundColorToken?.color ?? .clear)
            .opacity(self.viewModel.toggleOpacity ?? .zero)

            HStack {
                // Left Space
                if let showSpace = self.viewModel.showToggleLeftSpace,
                   showSpace {
                    Spacer()
                }
                ZStack {
                    // Dot
                    Circle()
                        .fill(self.viewModel.toggleDotBackgroundColorToken?.color ?? .clear)
                        .accessibilityIdentifier(AccessibilityIdentifier.toggleDotView)

                    ZStack {
                        // On icon
                        self.viewModel.toggleDotImagesState?.images.rightValue.on
                            .applyStyle(
                                isForOnImage: true,
                                viewModel: self.viewModel
                            )

                        // Off icon
                        self.viewModel.toggleDotImagesState?.images.rightValue.off
                            .applyStyle(
                                isForOnImage: false,
                                viewModel: self.viewModel
                            )
                    }
                    .opacity(self.viewModel.toggleOpacity ?? .zero)
                    .padding(.init(
                        all: self.toggleDotPadding
                    ))
                    .animation(
                        .custom,
                        value: self.viewModel.toggleDotImagesState
                    )
                }

                // Right Space
                if let showSpace = self.viewModel.showToggleLeftSpace,
                   !showSpace {
                    Spacer()
                }
            }
            .padding(.init(
                all: self.togglePadding
            ))
            .animation(
                .custom,
                value: self.viewModel.showToggleLeftSpace
            )
        }
        .frame(
            width: self.toggleWidth,
            height: self.toggleHeight
        )
        .accessibilityIdentifier(AccessibilityIdentifier.toggleView)
        .onTapGesture {
            withAnimation(.custom) {
                self.viewModel.toggle()
            }
        }
    }

    // MARK: - Modifier

    /// Set the alignment on switch.
    /// - Parameters:
    ///   - alignment: The alignment of the switch.
    /// - Returns: Current Switch View.
    public func alignment(_ alignment: SwitchAlignment) -> Self {
        self.viewModel.set(alignment: alignment)
        return self
    }

    /// Set the intent on switch.
    /// - Parameters:
    ///   - intent: The intent of the switch.
    /// - Returns: Current Switch View.
    public func intent(_ intent: SwitchIntent) -> Self {
        self.viewModel.set(intent: intent)
        return self
    }

    /// Set the isEnabled on switch.
    /// - Parameters:
    ///   - isEnabled: The state of the switch: enabled or not.
    /// - Returns: Current Switch View.
    public func isEnabled(_ isEnabled: Bool) -> Self {
        self.viewModel.set(isEnabled: isEnabled)
        return self
    }

    /// Set the images on switch.
    /// - Parameters:
    ///   - images: The optional images of the switch.
    /// - Returns: Current Switch View.
    public func images(_ images: SwitchImages?) -> Self {
        self.viewModel.set(images: images.map { .right($0) })
        return self
    }

    /// Set the text of the switch.
    /// - Parameters:
    ///   - text: The optional text of the switch.
    /// - Returns: Current Switch View.
    public func text(_ text: String?) -> Self {
        self.viewModel.set(text: text)
        return self
    }

    /// Set the attributed text of the switch.
    /// - Parameters:
    ///   - text: The optional attributed text of the switch.
    /// - Returns: Current Switch View.
    public func attributedText(_ attributedText: AttributedString?) -> Self {
        self.viewModel.set(attributedText: attributedText.map { .right($0) })
        return self
    }
}

// MARK: - Extension

private extension Text {

    func applyStyle() -> some View {
        return self.frame(
            maxHeight: .infinity,
            alignment: .center
        )
        .accessibilityIdentifier(SwitchAccessibilityIdentifier.text)
    }
}

private extension Image {

    func applyStyle(
        isForOnImage: Bool,
        viewModel: SwitchViewModel
    ) -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(viewModel.toggleDotForegroundColorToken?.color)
            .if(isForOnImage) {
                $0.opacity(viewModel.toggleDotImagesState?.onImageOpacity ?? 0)
            } else: {
                $0.opacity(viewModel.toggleDotImagesState?.offImageOpacity ?? 0)
            }
            .accessibilityIdentifier(SwitchAccessibilityIdentifier.toggleDotImageView)
    }
}

private extension Animation {

    static var custom: Animation {
        return Animation.easeOut(duration: SwitchConstants.animationDuration)
    }
}