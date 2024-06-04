//
//  DropShadowView.swift
//  SparkDemo
//
//  Created by louis.borlee on 30/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@_spi(SI_SPI) import SparkCommon
import Spark
import SwiftUI

struct DropShadowView: View {

    private let viewModel = DropShadowViewModel()

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    var body: some View {
        ForEach(viewModel.itemViewModels(for: self.theme), id: \.id) { itemViewModel in
            DropShadowItemView(itemViewModel: itemViewModel)
        }
    }
}

struct DropShadowItemView: View {

    let itemViewModel: DropShadowItemViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(itemViewModel.name)
            Text(itemViewModel.description)
                .font(Font.caption2)
                .italic()
                .foregroundColor(.gray)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            Color.blue
                .frame(height: 50)
                .cornerRadius(5)
                .shadow(itemViewModel.shadow)
        }
        .padding(.bottom)
    }
}
