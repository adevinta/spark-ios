//
//  TextLinkView.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct TextLinkView: View {

    // MARK: - Type alias

    private typealias AccessibilityIdentifier = TextLinkAccessibilityIdentifier

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
    ///   - textColorToken: The text color of the text link.
    ///   - textHighlightRange: The optional range to specify the highlighted part of the text link.
    ///   - typography: The typography of the text link.
    ///   - variant: The variant of the text link.   
    ///   - image: The optional image of the text link.
    ///   - alignment: The alignment image of the text link.
    ///   - action: The action of the text link when the user tap on the component.
    public init(
        theme: any Theme,
        text: String,
        textColorToken: any ColorToken,
        textHighlightRange: NSRange? = nil,
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
            textColorToken: textColorToken,
            textHighlightRange: textHighlightRange,
            typography: typography,
            variant: variant,
            alignment: alignment
        )
        self.viewModel = viewModel

        self.image = image

        self._spacing = .init(wrappedValue: viewModel.spacing ?? .zero)

        self.action = action
    }

    // MARK: - View

    public var body: some View {
        Button(action: self.action) {
            self.content()
        }
        .buttonStyle(PressedButtonStyle(viewModel: self.viewModel))
        .accessibilityIdentifier(AccessibilityIdentifier.view)
    }

    // MARK: - View Builder

    @ViewBuilder
    private func content() -> some View {
        HStack(
            alignment: .top,
            spacing: self.spacing
        ) {
            if self.viewModel.isTrailingImage ?? false {
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
            .foregroundStyle(self.viewModel.imageTintColor?.color ?? ColorTokenDefault.clear.color)
            .accessibilityIdentifier(AccessibilityIdentifier.image)
    }

    @ViewBuilder
    private func text() -> some View {
        Text(self.viewModel.attributedText?.rightValue ?? "")
            .multilineTextAlignment(self.style.multilineTextAlignment)
            .lineLimit(self.style.lineLimit)
        .accessibilityIdentifier(AccessibilityIdentifier.text)
        .onChange(of: self.sizeCategory) { value in
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

// MARK: - Button Style

private struct PressedButtonStyle: ButtonStyle {

    // MARK: - Properties

    private var viewModel: TextLinkViewModel

    // MARK: - Initialization

    init(viewModel: TextLinkViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - View

    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .onChange(of: configuration.isPressed) { value in
                self.viewModel.set(isHighlighted: value)
            }
    }
}

// MARK: - Observable Style

private final class TextLinkStyle: ObservableObject {

    // MARK: - Properties

    var multilineTextAlignment: TextAlignment = .leading
    var lineLimit: Int?
}
