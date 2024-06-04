//
//  CheckboxGroupViewModel.swift
//  SparkCore
//
//  Created by alican.aycil on 22.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
import SparkTheming

final class CheckboxGroupViewModel: ObservableObject {

    // MARK: - Internal properties
    @Published var title: String?
    @Published var checkedImage: Image
    @Published var layout: CheckboxGroupLayout
    @Published var spacing: LayoutSpacing
    @Published var accessibilityIdentifierPrefix: String
    @Published var titleFont: TypographyFontToken
    @Published var titleColor: any ColorToken
    @Published var intent: CheckboxIntent
    @Published var alignment: CheckboxAlignment
    var theme: Theme

    // MARK: - Init
    init(
        title: String?,
        checkedImage: Image,
        accessibilityIdentifierPrefix: String,
        theme: Theme,
        intent: CheckboxIntent = .main,
        alignment: CheckboxAlignment = .left,
        layout: CheckboxGroupLayout = .vertical
    ) {
        self.title = title
        self.checkedImage = checkedImage
        self.theme = theme
        self.intent = intent
        self.alignment = alignment
        self.layout = layout
        self.spacing = theme.layout.spacing
        self.titleFont = theme.typography.subhead
        self.titleColor = theme.colors.base.onSurface
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
    }

    func calculateSingleCheckboxWidth(string: String?) -> CGFloat {
        let font: UIFont = self.theme.typography.body1.uiFont
        let textWidth: CGFloat = string?.widthOfString(usingFont: font) ?? 0
        let spacing: CGFloat = CheckboxGetSpacingUseCase().execute(layoutSpacing: self.theme.layout.spacing, alignment: self.alignment)
        let checkboxControlSize: CGFloat = CheckboxView.Constants.checkboxSize
        let width: CGFloat = checkboxControlSize + spacing + textWidth
        return width
    }
}

private extension String {
   func widthOfString(usingFont font: UIFont?) -> CGFloat {
       if let font = font {
           let fontAttributes = [NSAttributedString.Key.font: font]
           let size = self.size(withAttributes: fontAttributes)
           return size.width
       }
       return 0
    }
}
