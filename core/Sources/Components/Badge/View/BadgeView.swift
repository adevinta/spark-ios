//
//  BadgeView.swift
//  SparkCore
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct BadgeView: View {
    @Binding public var viewModel: BadgeViewModel

    public var body: some View {
        GeometryReader { proxy in
            Text(viewModel.badgeText)
                .padding(.init(vertical: viewModel.verticalOffset / 2.0, horizontal: viewModel.horizontalOffset / 2.0))
                .font(viewModel.textFont.font)
                .foregroundColor(viewModel.badgeStyle.badgeColors.foregroundColor.color)
                .background(viewModel.badgeStyle.badgeColors.backgroundColor.color)
                .border(width: viewModel.borderWidth, radius: proxy.size.height / 2.0, colorToken: viewModel.borderColor)
        }
        .offset(x: viewModel.borderWidth / 2.0)
    }

    public init(viewModel: Binding<BadgeViewModel>) {
        self._viewModel = viewModel
    }
}
