//
//  LayoutSpacingItemView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct LayoutSpacingItemView: View {

    // MARK: - Properties

    let viewModel: LayoutSpacingItemViewModel

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading) {
            Text(self.viewModel.name)
            Text(self.viewModel.description)
                .font(Font.caption2)
                .italic()
                .foregroundColor(.gray)

            if self.viewModel.value > 0 {
                Rectangle()
                    .fill(.gray)
                    .frame(width: self.viewModel.value,
                           height: 20)
            }
        }
    }
}

struct LayoutSpacingItemView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutSpacingItemView(viewModel: .init(name: "Small", value: 10))
    }
}
