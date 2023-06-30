//
//  TypographyView.swift
//  SparkDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct TypographyView: View {

    // MARK: - Properties

    private let viewModel = TypographyViewModel()

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    // MARK: - View
    
    var body: some View {
        List(self.viewModel.itemViewModels(for: self.theme), id: \.self) { itemViewModels in
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
