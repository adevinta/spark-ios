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

    @ObservedObject private var viewModel: TagViewModel
    @ScaledMetric private var height: CGFloat = TagConstants.height

    // MARK: - Initialization

    public init(theme: Theme) {
        self.viewModel = .init(theme: theme)
    }

    // MARK: - View

    public var body: some View {
        HStack(spacing: self.viewModel.spacing.small) {
            // Optional icon image
            self.viewModel.iconImage?
                .resizable()
                .scaledToFit()
                .foregroundColor(self.viewModel.colors.foregroundColor.color)
                .accessibilityIdentifier(AccessibilityIdentifier.iconImage)

            // Optional Text
            if let text = self.viewModel.text {
                Text(text)
                    .lineLimit(1)
                    .font(self.viewModel.typography.captionHighlight.font)
                    .truncationMode(.tail)
                    .foregroundColor(self.viewModel.colors.foregroundColor.color)
                    .accessibilityIdentifier(AccessibilityIdentifier.text)
            }
        }
        .padding(.init(vertical: self.viewModel.spacing.small,
                       horizontal: self.viewModel.spacing.medium))
        .frame(height: self.height)
        .background(self.viewModel.colors.backgroundColor.color)
        .border(width: self.viewModel.border.width.small,
                radius: self.viewModel.border.radius.full,
                colorToken: self.viewModel.colors.borderColor)
    }

    // MARK: - Modifier

    public func accessibility(identifier: String,
                              label: String?) -> some View {
        self.modifier(AccessibilityViewModifier(identifier: identifier,
                                                label: label ?? self.viewModel.text))
    }

    public func intentColor(_ intentColor: TagIntentColor) -> Self {
        self.viewModel.setIntentColor(intentColor)
        return self
    }

    public func variant(_ variant: TagVariant) -> Self {
        self.viewModel.setVariant(variant)
        return self
    }

    public func iconImage(_ iconImage: Image?) -> Self {
        self.viewModel.setIconImage(iconImage)
        return self
    }

    public func text(_ text: String?) -> Self {
        self.viewModel.setText(text)
        return self
    }
}
