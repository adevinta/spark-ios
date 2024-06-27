//
//  ColorView.swift
//  SparkDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@_spi(SI_SPI) import SparkCommon
import SparkCore
import SwiftUI

struct ColorView: View {

    // MARK: - Properties

    private let viewModel = ColorViewModel()

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    // MARK: - View

    var body: some View {
        List(self.viewModel.sectionViewModels(for: self.theme), id: \.name) { sectionViewModel in
            NavigationLink(sectionViewModel.name) {
                ColorSectionView(viewModel: sectionViewModel)
            }
        }
        .navigationBarTitle(Text("Color"))
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorView()
    }
}
