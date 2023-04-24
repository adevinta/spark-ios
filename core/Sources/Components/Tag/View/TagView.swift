//
//  TagView.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

// TODO: add documentation for all public struct/properties/func...
public struct TagView: View {

    // MARK: - Type Alias

    private typealias AccessibilityIdentifier = TagAccessibilityIdentifier

    // MARK: - Private Properties

    @Binding private var theme: Theme
    @Binding private var intentColor: TagIntentColor
    @Binding private var variant: TagVariant

    @Binding private var iconImage: Image?
    @Binding private var text: String?

    // MARK: - UI Properties

    @Environment(\.sizeCategory) private var sizeCategory

    private var height: CGFloat {
        return self.getHeightUseCase.execute(from: self.sizeCategory)
    }

    private var colors: TagColorables {
        return self.getColorsUseCase.execute(from: self.theme,
                                             intentColor: self.intentColor,
                                             variant: self.variant)
    }

    private let getColorsUseCase: TagGetColorsUseCaseable
    private let getHeightUseCase: TagGetHeightUseCaseable

    // MARK: - Initialization

    public init(theme: Binding<Theme>,
                intentColor: Binding<TagIntentColor>,
                variant: Binding<TagVariant>,
                iconImage: Binding<Image?>) {
        self.init(theme,
                  intentColor: intentColor,
                  variant: variant,
                  iconImage: iconImage,
                  text: Binding.constant(nil))
    }

    public init(theme: Binding<Theme>,
                intentColor: Binding<TagIntentColor>,
                variant: Binding<TagVariant>,
                text: Binding<String?>) {
        self.init(theme,
                  intentColor: intentColor,
                  variant: variant,
                  iconImage: Binding.constant(nil),
                  text: text)
    }

    public init(theme: Binding<Theme>,
                intentColor: Binding<TagIntentColor>,
                variant: Binding<TagVariant>,
                iconImage: Binding<Image?>,
                text: Binding<String?>) {
        self.init(theme,
                  intentColor: intentColor,
                  variant: variant,
                  iconImage: iconImage,
                  text: text)
    }

    private init(_ theme: Binding<Theme>,
                 intentColor: Binding<TagIntentColor>,
                 variant: Binding<TagVariant>,
                 iconImage: Binding<Image?>,
                 text: Binding<String?>,
                 getColorsUseCase: TagGetColorsUseCaseable = TagGetColorsUseCase(),
                 getHeightUseCase: TagGetHeightUseCaseable = TagGetHeightUseCase()) {
        self._theme = theme
        self._intentColor = intentColor
        self._variant = variant
        self._iconImage = iconImage
        self._text = text

        self.getColorsUseCase = getColorsUseCase
        self.getHeightUseCase = getHeightUseCase
    }

    // MARK: - View

    public var body: some View {
        HStack(spacing: self.theme.layout.spacing.small) {
            // Optional icon image
            self.iconImage?
                .resizable()
                .scaledToFit()
                .foregroundColor(self.colors.foregroundColor.color)
                .accessibilityIdentifier(AccessibilityIdentifier.iconImage)

            // Optional Text
            if let text = self.text {
                Text(text)
                    .lineLimit(1)
                    .font(self.theme.typography.captionHighlight.font)
                    .truncationMode(.tail)
                    .foregroundColor(self.colors.foregroundColor.color)
                    .accessibilityIdentifier(AccessibilityIdentifier.text)
            }
        }
        .padding(.init(vertical: self.theme.layout.spacing.small,
                       horizontal: self.theme.layout.spacing.medium))
        .frame(height: self.height)
        .background(self.colors.backgroundColor.color)
        .border(width: self.theme.border.width.small,
                radius: self.theme.border.radius.full,
                colorToken: self.colors.borderColor)
    }

    public func accessibility(identifier: String,
                              label: String?) -> some View {
        self.modifier(AccessibilityViewModifier(identifier: identifier,
                                                label: label ?? self.text))
    }
}
