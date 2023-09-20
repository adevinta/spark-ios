//
//  ChipView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 17.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct ChipView: View {

    @ObservedObject private var viewModel: ChipViewModel<BadgeUIView>
    @ScaledMetric private var imageSize = ChipConstants.imageSize
    @ScaledMetric private var height = ChipConstants.height
    @ScaledMetric private var borderWidth = ChipConstants.borderWidth
    @ScaledMetric private var dashLength = ChipConstants.dashLength
    @ScaledMetric private var spacing: CGFloat
    @ScaledMetric private var padding: CGFloat
    @ScaledMetric private var borderRadius: CGFloat

    private var action: (() -> Void)?
    

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
                intent: ChipIntent,
                variant: ChipVariant,
                alignment: ChipAlignment = .leadingIcon,
                iconImage: Image,
                action: (() -> Void)? = nil
    ) {
        self.init(theme: theme,
                  intent: intent,
                  variant: variant,
                  alignment: alignment,
                  optionalLabel: nil,
                  optionalIconImage: iconImage,
                  action: action
        )
    }

    public init(theme: Theme,
                intent: ChipIntent,
                variant: ChipVariant,
                alignment: ChipAlignment = .leadingIcon,
                label: String,
                iconImage: Image,
                action: (() -> Void)? = nil
    ) {
        self.init(theme: theme,
                  intent: intent,
                  variant: variant,
                  alignment: alignment,
                  optionalLabel: label ,
                  optionalIconImage: iconImage,
                  aciton: action
        )
    }

    init(theme: Theme,
         intent: ChipIntent,
         variant: ChipVariant,
         alignment: ChipAlignment,
         optionalLabel: String?,
         optionalIconImage: Image?,
         action: (() -> Void)? = nil
    ) {
        let viewModel = ChipViewModel(
            theme: theme,
            variant: variant,
            intent: intent,
            alignment: alignment)
        self.init(viewModel: viewModel,
                  optionalLabel: optionalLabel,
                  optionalIconImage: optionalIconImage,
                  action: action
        )
    }

    internal init(viewModel: ChipViewModel,
                  optionalLabel: String?,
                  optionalIconImage: Image?,
                  action: (() -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.text = optionalLabel
        self.icon = optionalIconImage
        self.action = action

        self._spacing = ScaledMetric(wrappedValue: viewModel.spacing)
        self._padding = ScaledMetric(wrappedValue: viewModel.padding)
        self._borderRadius = ScaledMetric(wrappedValue: viewModel.borderRadius)

    }

    public var body: some View {
        Button(action: {}) {
            HStack {
                if self.viewModel.alignment == .leadingIcon {
                    if let icon = icon {
                        icon
                    }
                    if let text = text {
                        Text(text)
                    }
                } else {
                    if let text = text {
                        Text(text)
                    }
                    if let icon = icon {
                        icon
                    }
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

