//
//  ColorSectionView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 10/03/2023.
//

@_spi(SI_SPI) import SparkCommon
import SwiftUI
import SparkCore

struct ColorSectionView: View {

    // MARK: - Properties

    let viewModel: any ColorSectionViewModelable

    // MARK: - View

    var body: some View {
        List(self.viewModel.itemViewModels, id: \.self) { itemViewModels in
            Section {
                ForEach(itemViewModels, id: \.self) { itemViewModel in
                    if #available(iOS 15.0, *) {
                        ColorItemView(viewModel: itemViewModel)
                            .listRowSeparator(.hidden)
                    } else {
                        ColorItemView(viewModel: itemViewModel)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle(Text(self.viewModel.name))
    }
}

struct ColorSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSectionView(viewModel: ColorSectionType.main.viewModel(for: SparkTheme()))
    }
}
