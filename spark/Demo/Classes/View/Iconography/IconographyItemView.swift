//
//  IconographyItemView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SwiftUI
import SparkCore

struct IconographyItemView: View {

    // MARK: - Properties

    let viewModel: IconographyItemViewModel

    // MARK: - View

    var body: some View {
        HStack(spacing: 10) {
            self.viewModel.image
                .foregroundColor(.orange)
            Text(self.viewModel.name)
        }
    }
}

struct IconographyItemView_Previews: PreviewProvider {
    static var previews: some View {
        IconographyItemView(viewModel: .init(name: "Title",
                                             iconographyImage: IconographyImageDefault(named: "test", in: Bundle())))
    }
}
