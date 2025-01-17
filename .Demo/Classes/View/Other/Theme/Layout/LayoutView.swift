//
//  LayoutView.swift
//  SparkDemo
//
//  Created by luis.figueiredo-ext on 08/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct LayoutView: View {

    // MARK: - Properties

    private let viewModel = LayoutViewModel()

    // MARK: - View

    var body: some View {
        List(self.viewModel.spacingItemViewModels(), id: \.self) {
            LayoutSpacingItemView(viewModel: $0)
        }
        .navigationBarTitle("Layout")
    }
}

struct LayoutView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView()
    }
}
