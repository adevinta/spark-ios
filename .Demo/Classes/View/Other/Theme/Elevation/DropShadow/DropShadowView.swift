//
//  DropShadowView.swift
//  SparkDemo
//
//  Created by louis.borlee on 30/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct DropShadowView: View {

    private let viewModel = DropShadowViewModel()

    var theme: Theme = SparkTheme.shared

    var body: some View {
        ForEach(viewModel.itemViewModels(for: self.theme), id: \.id) { itemViewModel in
            DropShadowItemView(
                itemViewModel: itemViewModel,
                backgroundColor: self.theme.colors.main.main.color
            )
            .listRowBackground(self.theme.colors.base.surface.color)
        }
    }
}

struct DropShadowItemView: View {

    let itemViewModel: DropShadowItemViewModel
    let backgroundColor: Color

    var body: some View {
        VStack(alignment: .leading) {
            Text(itemViewModel.name)
            Text(itemViewModel.description)
                .font(Font.caption2)
                .italic()
                .foregroundColor(.gray)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            self.backgroundColor
                .frame(height: 50)
                .cornerRadius(5)
                .shadow(itemViewModel.shadow)
        }
        .padding(.bottom)
    }
}
