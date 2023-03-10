//
//  IconographyView.swift
//  SparkDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//

import SwiftUI

struct IconographyView: View {

    // MARK: - Properties

    private let viewModel = IconographyViewModel()

    // MARK: - View
    
    var body: some View {
        List(self.viewModel.sectionViewModels, id: \.self) { sectionViewModel in
            Section(header: Text(sectionViewModel.name)) {
                ForEach(sectionViewModel.itemViewModels, id: \.self) { itemViewModel in
                    IconographyItemView(viewModel: itemViewModel)
                }
            }
        }
        .navigationBarTitle(Text("Iconography"))
    }
}

struct IconographyView_Previews: PreviewProvider {
    static var previews: some View {
        IconographyView()
    }
}
