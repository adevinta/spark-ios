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
    public var text: String?
    public var iconImage: Image?

    public var accessibilityIdentifier: String?
    public var accessibilityLabel: String?

    // MARK: - Private Properties

    @Environment(\.sizeCategory) private var sizeCategory

    private var height: CGFloat {
        self.getHeightUseCase.execute(from: self.sizeCategory)
    }

    private var spacing: LayoutSpacing {
        return self.theming.theme.layout.spacing
    }

    private var border: Border {
        return self.theming.theme.border
    }

    private var typography: Typography {
        self.theming.theme.typography
    }

    private var _colors: SparkTagColorables?
    private var colors: SparkTagColorables {
        return self._colors ?? self.getColorsFromUseCase()
    }

    private let getColorsUseCase: SparkTagGetColorsUseCaseable
    private let getHeightUseCase: SparkTagGetHeightUseCaseable

    // MARK: - Initialization

    public init(theming: SparkTagTheming,
                text: String) {
        self.init(theming,
                  text: text,
                  iconImage: nil)
    }

    public init(theming: SparkTagTheming,
                iconImage: Image) {
        self.init(theming,
                  text: nil,
                  iconImage: iconImage)
    }

    public init(theming: SparkTagTheming,
                text: String,
                iconImage: Image) {
        self.init(theming,
                  text: text,
                  iconImage: iconImage)
    }

    init(_ theming: SparkTagTheming,
         text: String?,
         iconImage: Image?,
         getColorsUseCase: SparkTagGetColorsUseCaseable = SparkTagGetColorsUseCase(),
         getHeightUseCase: SparkTagGetHeightUseCaseable = SparkTagGetHeightUseCase()) {
        self.theming = theming
        self.iconImage = iconImage
        self.text = text
        self.getColorsUseCase = getColorsUseCase
        self.getHeightUseCase = getHeightUseCase
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

            // Optional Text
            if let text = self.text {
                Text(text)
                    .lineLimit(1)
                    .font(self.typography.captionHighlight.font)
                    .truncationMode(.tail)
                    .foregroundColor(self.colors.foregroundColor.color)
                    .accessibilityIdentifier(AccessibilityIdentifier.text)
            }
        }
        .frame(height: self.height / 2)
        .padding(.init(vertical: self.spacing.none, horizontal: self.spacing.medium))
        .frame(height: self.height)
        .background(self.colors.backgroundColor.color)
        .border(width: self.border.width.small,
                radius: self.border.radius.full,
                colorToken: self.colors.borderColor)
        .accessibility(identifier: self.accessibilityIdentifier,
                       label: self.accessibilityLabel,
                       text: self.text)
    }

    // MARK: - Getter

    private func getColorsFromUseCase() -> SparkTagColorables {
        return self.getColorsUseCase.execute(from: self.theming)
    }
}
