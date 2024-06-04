//
//  ButtonImageView.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

struct ButtonImageView<ViewModel: ButtonMainViewModel & ButtonMainSUIViewModel>: View {

    // MARK: - Properties

    let image: Image?
    @ScaledMetric private var size: CGFloat
    let foregroundColor: (any ColorToken)?

    // MARK: - Initialization

    init(viewModel: ViewModel) {
        self.image = viewModel.controlStateImage.image
        self._size = .init(wrappedValue: viewModel.sizes?.imageSize ?? .zero)
        self.foregroundColor = viewModel.currentColors?.imageTintColor
    }

    // MARK: - View

    var body: some View {
        if let image = self.image {
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: self.size,
                    height: self.size,
                    alignment: .center
                )
                .foregroundStyle(self.foregroundColor?.color ?? ColorTokenDefault.clear.color)
                .accessibilityIdentifier(ButtonAccessibilityIdentifier.imageView)
        }
    }
}
