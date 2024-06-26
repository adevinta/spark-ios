//
//  BorderItemView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@_spi(SI_SPI) import SparkCommon
import SparkCore
import SwiftUI

struct BorderItemView: View {

    // MARK: - Properties

    let viewModel: BorderItemViewModel

    // MARK: - View

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(self.viewModel.name)
            Text(self.viewModel.description)
                .font(Font.caption2)
                .italic()
                .foregroundColor(.gray)

            Color.gray
                .frame(height: self.viewModel.contentHeight)
                .border(width: self.viewModel.width,
                        radius: self.viewModel.radius,
                        colorToken: self.theme.colors.base.surfaceInverse)
        }
    }
}

struct BorderItemView_Previews: PreviewProvider {
    static var previews: some View {
        BorderItemView(viewModel: .init(name: "Title", width: 10, radius: 4))
    }
}
