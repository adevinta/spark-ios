//
//  ButtonImageView.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct ButtonImageView<ViewModel: ButtonMainViewModel>: View {

    // MARK: - Properties

    let image: Image?
    @ScaledMetric private var size: CGFloat
    let foregroundColor: (any ColorToken)?

    // MARK: - Initialization

    init(manager: ButtonMainManager<ViewModel>) {
        self.image = manager.controlStateImage.image
        self._size = .init(wrappedValue: manager.viewModel.sizes?.imageSize ?? .zero)
        self.foregroundColor = manager.viewModel.currentColors?.imageTintColor
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
