//
//  BorderView.swift
//  SparkDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@_spi(SI_SPI) import SparkCommon
import SparkCore
import SwiftUI

struct BorderView: View {

    // MARK: - Properties

    private let viewModel = BorderViewModel()

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    // MARK: - View

    var body: some View {
        List(self.viewModel.sectionViewModels(for: self.theme), id: \.self) { sectionViewModel in
            Section(header: Text(sectionViewModel.name)) {
                ForEach(sectionViewModel.itemViewModels, id: \.self) { itemViewModel in
                    BorderItemView(viewModel: itemViewModel)
                }
            }
        }
        .navigationBarTitle(Text("Border"))
    }
}

struct BorderView_Previews: PreviewProvider {
    static var previews: some View {
        BorderView()
    }
}
