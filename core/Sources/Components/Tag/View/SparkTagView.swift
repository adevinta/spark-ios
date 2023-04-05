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
            self.colors = colorsUseCase.execute(from: self.theming)
        }
    }
    public var iconImage: Image?
    public var text: String

    public var accessibilityIdentifier: String?
    public var accessibilityLabel: String?

    // MARK: - Private Properties

    private var colors: SparkTagColorables
    private let colorsUseCase: SparkTagColorsUseCaseable

    // MARK: - Initialization

    public init(theming: SparkTagTheming,
                text: String,
                iconImage: Image? = nil) {
        self.init(theming: theming,
                  text: text,
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
        self.colors = colorsUseCase.execute(from: theming)
    }

    // MARK: - View

    public var body: some View {
        HStack(spacing: self.theming.theme.layout.spacing.small) {
            // Optional icon image
            self.iconImage?
                .foregroundColor(self.colors.foregroundColor.swiftUIColor)
                .accessibilityIdentifier(AccessibilityIdentifier.iconImage)

            // Text
            Text(self.text)
                .font(self.theming.theme.typography.captionHighlight.swiftUIFont)
                .foregroundColor(self.colors.foregroundColor.swiftUIColor)
                .accessibilityIdentifier(AccessibilityIdentifier.text)
        }
        .frame(height: 20)
        .accessibility(identifier: self.accessibilityIdentifier,
                       label: self.accessibilityLabel,
                       text: self.text)
    }
}







// TODO: déplacer
// TODO: essayer que ça se modifie bien à la volé

public extension View {

    func accessibility(identifier: String?,
                       label: String?,
                       text: String?) -> some View {
        self.modifier(AccessibilityViewModifier(identifier: identifier,
                                                label: label ?? text))
    }
}

struct AccessibilityViewModifier: ViewModifier {

    // MARK: - Properties

    let identifier: String?
    let label: String?

    // MARK: - Initialization

    init(identifier: String?,
         label: String?) {
        self.identifier = identifier
        self.label = label
    }

    // MARK: - View

    func body(content: Content) -> some View {
        if let identifier = self.identifier {
            content.accessibilityIdentifier(identifier)
        }
        if let label = self.label {
            content.accessibilityLabel(label)
        }
    }
}

// TODO: déplacer
// TODO: essayer que ça se modifie bien à la volé




