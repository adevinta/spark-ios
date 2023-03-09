//
//  TypographyItemView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 01/03/2023.
//

import SwiftUI
import SparkCore

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
                                            typographyFont: TypographyFontDefault(font: .systemFont(ofSize: 12),
                                                                                  swiftUIFont: .body)))
    }
}
