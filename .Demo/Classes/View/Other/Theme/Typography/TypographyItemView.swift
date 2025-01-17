//
//  TypographyItemView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct TypographyItemView: View {

    // MARK: - Properties

    let viewModel: TypographyItemViewModel

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading) {
            Text(self.viewModel.name)
                .font(self.viewModel.font)
            Text(self.viewModel.description)
                .font(Font.caption2)
                .italic()
                .foregroundColor(.gray)
        }
    }
}

struct TypographyItemView_Previews: PreviewProvider {
    static var previews: some View {
        TypographyItemView(viewModel: .init(name: "Title",
                                            token: TypographyFontTokenDefault(named: "Roboto",
                                                                              size: 12,
                                                                              textStyle: .body)))
    }
}
