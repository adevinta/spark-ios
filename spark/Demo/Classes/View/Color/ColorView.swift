//
//  ColorView.swift
//  SparkDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//

import SwiftUI

struct ColorView: View {

    // MARK: - Properties

    private let viewModel = ColorViewModel()

    // MARK: - View
    
    var body: some View {
        List(self.viewModel.itemViewModels, id: \.self) { itemViewModels in
            Section {
                ForEach(itemViewModels, id: \.self) { itemViewModel in
                    ColorItemView(viewModel: itemViewModel)
                }
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
