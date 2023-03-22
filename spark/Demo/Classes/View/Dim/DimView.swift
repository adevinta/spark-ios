//
//  DimView.swift
//  Spark
//
//  Created by louis.borlee on 22/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct DimView: View {

    // MARK: - Properties

    private let viewModel = DimViewModel()

    // MARK: - View

    var body: some View {
        List(self.viewModel.dimItemViewModels, id: \.self) {
            DimItemView(viewModel: $0)
        }
        .navigationBarTitle(Text("Dim"))
    }
}

struct DimView_Previews: PreviewProvider {
    static var previews: some View {
        DimView()
    }
}
