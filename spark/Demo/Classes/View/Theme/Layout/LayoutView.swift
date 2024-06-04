//
//  LayoutView.swift
//  SparkDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@_spi(SI_SPI) import SparkCommon
import Spark
import SwiftUI

struct LayoutView: View {

    // MARK: - Properties

    private let viewModel = LayoutViewModel()

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    // MARK: - View

    var body: some View {
        List(self.viewModel.spacingItemViewModels(for: self.theme), id: \.self) {
            LayoutSpacingItemView(viewModel: $0)
        }
        .navigationBarTitle(Text("Layout"))
    }
}

struct LayoutView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView()
    }
}
