//
//  ChipView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 17.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct ChipView: View {

    @ObservedObject private var viewModel: ChipViewModel
    @ScaledMetric private var imageSize = ChipConstants.imageSize
    @ScaledMetric private var height = ChipConstants.height
    @ScaledMetric private var borderWidth = ChipConstants.borderWidth
    @ScaledMetric private var dashLength = ChipConstants.dashLength
    @ScaledMetric private var spacing: CGFloat
    @ScaledMetric private var padding: CGFloat
    @ScaledMetric private var borderRadius: CGFloat

    private var action: (() -> ())?

    /// An optional icon on the Chip. The icon is always rendered to the left of the text
    private var icon: Image?
//    {
//        set {
//            self.imageView.image = newValue
//        }
//        get {
//            return self.imageView.image
//        }
//    }

    /// An optional text shown on the Chip. The text is rendered to the right of the icon.
    private var text: String?
//    {
//        set {
//            self.textLabel.text = newValue
//        }
//        get {
//            return self.textLabel.text
//        }
//    }

    public init(theme: Theme,
                intentColor: ChipIntentColor,
                variant: ChipVariant,
                iconImage: Image) {
        self.init(theme: theme, intentColor: intentColor, variant: variant, optionalLabel: nil, optionalIconImage: iconImage)
    }

    public init(theme: Theme,
                intentColor: ChipIntentColor,
                variant: ChipVariant,
                label: String,
                iconImage: Image) {
        self.init(theme: theme, intentColor: intentColor, variant: variant, optionalLabel: label , optionalIconImage: iconImage)
    }

    init(theme: Theme,
         intentColor: ChipIntentColor,
         variant: ChipVariant,
         optionalLabel: String?,
         optionalIconImage: Image?) {
        let viewModel = ChipViewModel(theme: theme, variant: variant, intentColor: intentColor)
        self.init(viewModel: viewModel, optionalLabel: optionalLabel, optionalIconImage: optionalIconImage)
    }

    init(viewModel: ChipViewModel,
         optionalLabel: String?,
         optionalIconImage: Image?) {
        self.viewModel = viewModel
        self.text = optionalLabel
        self.icon = optionalIconImage

        self._spacing = ScaledMetric(wrappedValue: viewModel.spacing)
        self._padding = ScaledMetric(wrappedValue: viewModel.padding)
        self._borderRadius = ScaledMetric(wrappedValue: viewModel.borderRadius)


    }

    var body: some View {
        Button(action: {}) {
            HStack {
                if let text = text {
                    Text(text)
                }
                if let icon = icon {
                    icon
                }
            }
        }
    }

    public func icon(_ icon: UIImage) -> Self {
//        self.icon = icon
        return self
    }

    public func text(_ text: String) -> Self {
        return self
    }
}

