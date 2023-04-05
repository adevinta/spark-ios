//
//  SparkTagView.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

// TODO: add documentation for all public struct/properties/func...
public struct SparkTagView: View {

    // MARK: - Type Alias

    private typealias AccessibilityIdentifier = SparkTagAccessibilityIdentifier

    // MARK: - Public Properties

    public var theming: SparkTagTheming {
        didSet {
            self._colors = self.getColorsFromUseCase()
        }
    }
    public var text: String
    public var iconImage: Image?

    public var accessibilityIdentifier: String?
    public var accessibilityLabel: String?

    // MARK: - Private Properties

    private var spacing: LayoutSpacing {
        return self.theming.theme.layout.spacing
    }

    private var _colors: SparkTagColorables?
    private var colors: SparkTagColorables {
        return self._colors ?? self.getColorsFromUseCase()
    }

    private let colorsUseCase: SparkTagColorsUseCaseable

    // MARK: - Initialization

    public init(theming: SparkTagTheming,
                text: String,
                iconImage: Image? = nil) {
        self.init(theming: theming,
                  text: text,
                  iconImage: iconImage,
                  colorsUseCase: SparkTagColorsUseCase())
    }

    init(theming: SparkTagTheming,
         text: String,
         iconImage: Image? = nil,
         colorsUseCase: SparkTagColorsUseCaseable) {
        self.theming = theming
        self.iconImage = iconImage
        self.text = text
        self.colorsUseCase = colorsUseCase
    }

    // MARK: - View

    public var body: some View {
        HStack(spacing: self.spacing.small) {
            // Optional icon image
            self.iconImage?
                .resizable()
                .scaledToFit()
                .foregroundColor(self.colors.foregroundColor.color)
                .accessibilityIdentifier(AccessibilityIdentifier.iconImage)

            // Text
            Text(self.text)
                .font(self.theming.theme.typography.captionHighlight.font)
                .truncationMode(.tail)
                .foregroundColor(self.colors.foregroundColor.color)
                .accessibilityIdentifier(AccessibilityIdentifier.text)
        }
        .frame(height: 10)
        .padding(.init(vertical: 0, horizontal: self.spacing.medium))
        .frame(height: 20)
        .background(self.colors.backgroundColor.color)
        .border(width: self.theming.theme.border.width.small,
                radius: self.theming.theme.border.radius.full,
                colorToken: self.colors.borderColor)
        .accessibility(identifier: self.accessibilityIdentifier,
                       label: self.accessibilityLabel,
                       text: self.text)
    }

    // MARK: - Getter

    private func getColorsFromUseCase() -> SparkTagColorables {
        return self.colorsUseCase.execute(from: self.theming)
    }
}
