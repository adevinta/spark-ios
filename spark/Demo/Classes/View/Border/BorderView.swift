//
//  BorderView.swift
//  SparkDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//

import SwiftUI

struct BorderView: View {

    // MARK: - Properties

    private let viewModel = BorderViewModel()

    // MARK: - View
    
    var body: some View {
        List(self.viewModel.sectionViewModels, id: \.self) { sectionViewModel in
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
