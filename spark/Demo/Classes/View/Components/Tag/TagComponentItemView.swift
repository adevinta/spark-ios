//
//  TagComponentItemView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 20/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct TagComponentItemView: View {

    // MARK: - Properties

    let viewModel: TagComponentItemViewModel

    // MARK: - Initialization

    init(viewModel: TagComponentItemViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading) {
            Text(self.viewModel.name)
                .font(Font.caption2)
                .italic()

            HStack(spacing: 10) {
                TagView(theme: SparkTheme.shared,
                        intentColor: self.viewModel.intentColor,
                        variant: self.viewModel.variant,
                        iconImage: Image(self.viewModel.imageNamed),
                        text: self.viewModel.text)
                .accessibility(identifier: "MyTag1",
                               label: "It's my first tag")

                TagView(theme: SparkTheme.shared,
                        intentColor: self.viewModel.intentColor,
                        variant: self.viewModel.variant,
                        iconImage: Image(self.viewModel.imageNamed))
                .accessibility(identifier: "MyTag3",
                               label: "It's my first tag")

                TagView(theme: SparkTheme.shared,
                        intentColor: self.viewModel.intentColor,
                        variant: self.viewModel.variant,
                        text: self.viewModel.text)
                .accessibility(identifier: "MyTag3",
                               label: nil)
            }
        }
    }
}

struct TagComponentItemView_Previews: PreviewProvider {
    static var previews: some View {
        TagComponentItemView(viewModel: .init(intentColor: .alert, variant: .filled))
    }
}
