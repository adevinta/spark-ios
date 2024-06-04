//
//  TextLinkView.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

public struct TextLinkView: View {

    // MARK: - Component

    private let image: Image?

    // MARK: - Properties

    @ObservedObject private var viewModel: TextLinkViewModel
    @ObservedObject private var style = TextLinkStyle()

    private var action: () -> Void

    @Environment(\.sizeCategory) var sizeCategory

    @ScaledMetric private var spacing: CGFloat

    // MARK: - Initialization

    /// Initialize a new text link view.
    /// - Parameters:
    ///   - theme: The spark theme of the text link.
    ///   - text: The text of the text link.
    ///   - textHighlightRange: The optional range to specify the highlighted part of the text link.
    ///   - intent: The intent of the text link.
    ///   - typography: The typography of the text link.
    ///   - variant: The variant of the text link.   
    ///   - image: The optional image of the text link.
    ///   - alignment: The alignment image of the text link.
    ///   - action: The action of the text link when the user tap on the component.
    public init(
        theme: any Theme,
        text: String,
        textHighlightRange: NSRange? = nil,
        intent: TextLinkIntent,
        typography: TextLinkTypography,
        variant: TextLinkVariant,
        image: Image?,
        alignment: TextLinkAlignment = .leadingImage,
        action: @escaping () -> Void
    ) {
        let viewModel = TextLinkViewModel(
            for: .swiftUI,
            theme: theme,
            text: text,
            textHighlightRange: textHighlightRange,
            intent: intent,
            typography: typography,
            variant: variant,
            alignment: alignment
        )
        self.viewModel = viewModel

        self.image = image

        self._spacing = .init(wrappedValue: viewModel.spacing)

        self.action = action
    }

    // MARK: - View

    public var body: some View {
        Button(action: self.action) {
            self.content()
        }
        .buttonStyle(PressedButtonStyle(isPressed: self.$viewModel.isHighlighted))
        .accessibilityIdentifier(TextLinkAccessibilityIdentifier.view)
        .accessibilityAddTraits(.isButton)
    }

    // MARK: - View Builder

    @ViewBuilder
    private func content() -> some View {
        HStack(
            alignment: .top,
            spacing: self.spacing
        ) {
            if self.viewModel.isTrailingImage {
                self.text()
                self.imageView()
            } else {
                self.imageView()
                self.text()
            }
        }
    }

    @ViewBuilder
    private func imageView() -> some View {
        self.image?
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(
                width: self.viewModel.imageSize?.size,
                height: self.viewModel.imageSize?.size,
                alignment: .center
            )
            .padding(.init(
                vertical: self.viewModel.imageSize?.padding ?? .zero,
                horizontal: .zero
            ))
            .foregroundStyle(self.viewModel.imageTintColor.color)
            .accessibilityIdentifier(TextLinkAccessibilityIdentifier.image)
    }

    @ViewBuilder
    private func text() -> some View {
        Text(self.viewModel.attributedText?.rightValue ?? "")
            .multilineTextAlignment(self.style.multilineTextAlignment)
            .lineLimit(self.style.lineLimit)
        .accessibilityIdentifier(TextLinkAccessibilityIdentifier.text)
        .onChange(of: self.sizeCategory) { _ in
            self.viewModel.contentSizeCategoryDidUpdate()
        }
    }

    // MARK: - Modifier

    /// Sets the alignment of a text view that contains multiple lines of text.
    /// - Parameters:
    ///   - alignment: A value that you use to align multiple lines of text within a view.
    /// - Returns: Current TextLink View.
    public func multilineTextAlignment(_ alignment: TextAlignment) -> Self {
        self.style.multilineTextAlignment = alignment
        return self
    }

    /// Sets the maximum number of lines that text can occupy in this view.
    /// - Parameters:
    ///   - number: The line limit. If `nil`, no line limit applies.
    /// - Returns: Current TextLink View.
    public func lineLimit(_ lineLimit: Int?) -> Self {
        self.style.lineLimit = lineLimit
        return self
    }
}

// MARK: - Observable Style

private final class TextLinkStyle: ObservableObject {

    // MARK: - Properties

    @Published var multilineTextAlignment: TextAlignment = .leading
    @Published var lineLimit: Int?
}
