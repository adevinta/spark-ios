//
//  TagComponentView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct TagComponentView: View {

    // MARK: - Properties

    let viewModel = TagComponentViewModel()

    // MARK: - View

    var body: some View {
        List(self.viewModel.sectionViewModels, id: \.name) { sectionViewModel in
            Section(header: Text(sectionViewModel.name)) {
                ForEach(sectionViewModel.itemViewModels, id: \.name) { itemViewModel in
                    TagComponentItemView(viewModel: itemViewModel)
                }
            }
        }
        .navigationBarTitle(Text("Tag"))
    }
}

struct TagComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TagComponentView()
    }
}
