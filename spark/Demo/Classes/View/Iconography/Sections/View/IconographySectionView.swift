//
//  IconographySectionView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 10/03/2023.
//

import SwiftUI

struct IconographySectionView: View {

    // MARK: - Properties

    let viewModel: any IconographySectionViewModelable

    // MARK: - View

    var body: some View {
        List(self.viewModel.itemViewModels, id: \.self) { itemViewModels in
            Section {
                ForEach(itemViewModels, id: \.self) { itemViewModel in
                    IconographyItemView(viewModel: itemViewModel)
                }
            }
        }
        .navigationBarTitle(Text(self.viewModel.name))
    }
}

struct IconographySectionView_Previews: PreviewProvider {
    static var previews: some View {
        IconographySectionView(viewModel: IconographySectionType.account.viewModel)
    }
}
