//
//  DimsView.swift
//  Spark
//
//  Created by louis.borlee on 22/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct DimsView: View {

    // MARK: - Properties

    private let viewModel = DimsViewModel()

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    // MARK: - View

    var body: some View {
        List(self.viewModel.dimItemViewModels(for: self.theme), id: \.self) {
            DimItemView(viewModel: $0)
        }
        .navigationBarTitle(Text("Dims"))
    }
}

struct DimsView_Previews: PreviewProvider {
    static var previews: some View {
        DimsView()
    }
}
