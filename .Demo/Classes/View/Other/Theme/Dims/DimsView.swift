//
//  DimsView.swift
//  Spark
//
//  Created by louis.borlee on 22/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct DimsView: View {

    // MARK: - Properties

    private let viewModel = DimsViewModel()

    // MARK: - View

    var body: some View {
        List(self.viewModel.dimItemViewModels(), id: \.self) {
            DimItemView(viewModel: $0)
        }
        .navigationBarTitle("Dims")
    }
}

struct DimsView_Previews: PreviewProvider {
    static var previews: some View {
        DimsView()
    }
}
