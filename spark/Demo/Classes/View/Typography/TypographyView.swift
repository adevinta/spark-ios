//
//  TypographyView.swift
//  SparkDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//

import SwiftUI

struct TypographyView: View {

    // MARK: - Properties

    private let viewModel = TypographyViewModel()

    // MARK: - View
    
    var body: some View {
        List(self.viewModel.itemViewModels, id: \.self) { itemViewModels in
            Section {
                ForEach(itemViewModels, id: \.self) { itemViewModel in
                    TypographyItemView(viewModel: itemViewModel)
                }
            }
        }
        .navigationBarTitle(Text("Typography"))
    }
}

struct TypographyView_Previews: PreviewProvider {
    static var previews: some View {
        TypographyView()
    }
}
