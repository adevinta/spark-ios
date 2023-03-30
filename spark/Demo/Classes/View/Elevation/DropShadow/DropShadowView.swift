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

    var body: some View {
        ForEach(viewModel.itemViewModels, id: \.id) { itemViewModel in
            DropShadowItemView(itemViewModel: itemViewModel)
        }
        .padding(.bottom)
    }
}

struct DropShadowItemView: View {

    let itemViewModel: DropShadowItemViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(itemViewModel.name)
            Spacer()
            Text(itemViewModel.description)
                .font(Font.caption2)
                .italic()
                .foregroundColor(.gray)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            Color.blue
                .frame(height: 50)
                .cornerRadius(5)
                .shadow(itemViewModel.shadow)
        }
    }
}
