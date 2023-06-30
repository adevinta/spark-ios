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
/*
struct TagComponentItemView: View {

    // MARK: - Constants

    private enum Constants {
        static let spacing: CGFloat = 10
    }

    // MARK: - Properties

    let viewModel: TagComponentItemViewModel
    @State private var uiKitViewHeight: CGFloat = .zero

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

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

            // Swift UI ?
            if self.viewModel.isSwiftUIComponent {
                HStack(spacing: Constants.spacing) {

                    TagView(theme: self.theme)
                        .intentColor(self.viewModel.intentColor)
                        .variant(self.viewModel.variant)
                        .iconImage(Image(self.viewModel.imageNamed))
                        .text(self.viewModel.text)
                        .accessibility(identifier: "MyTag1",
                                       label: "It's my first tag")

                    TagView(theme: self.theme)
                        .intentColor(self.viewModel.intentColor)
                        .variant(self.viewModel.variant)
                        .iconImage(Image(self.viewModel.imageNamed))
                        .accessibility(identifier: "MyTag2",
                                       label: "It's my second tag")

                    TagView(theme: self.theme)
                        .intentColor(self.viewModel.intentColor)
                        .variant(self.viewModel.variant)
                        .text(self.viewModel.text)
                        .accessibility(identifier: "MyTag3",
                                       label: nil)
                }
            } else { // UIKit !
                HStack(spacing: Constants.spacing) {
                    TagComponentItemsUIView(itemViewModel: self.viewModel,
                                            spacing: Constants.spacing,
                                            height: self.$uiKitViewHeight)
                    .frame(height: self.uiKitViewHeight, alignment: .leading)
                }
            }
        }
    }
}

struct TagComponentItemView_Previews: PreviewProvider {
    static var previews: some View {
        TagComponentItemView(
            viewModel: .init(
                isSwiftUIComponent: true,
                intentColor: .alert,
                variant: .filled
            )
        )
    }
}
*/
