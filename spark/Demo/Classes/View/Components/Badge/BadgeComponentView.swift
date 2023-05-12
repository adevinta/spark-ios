//
//  BadgeComponentView.swift
//  Spark
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import Spark
import SwiftUI

private struct MyFormatter: BadgeFormatting {
    func badgeText(value: String?) -> String {
        guard let value else {
            return "_"
        }
        return "My Formatter \(value)"
    }
}

struct BadgeComponentView: View {
    @State private var viewModel = BadgeViewModel(
        formatter: .custom(formatter: MyFormatter()),
        theme: SparkTheme.shared,
        badgeStyle: BadgeStyle(
            badgeSize: .small,
            badgeType: .danger,
            isBadgeOutlined: true,
            theme: SparkTheme.shared
        ),
        value: "23"
    )

    var body: some View {
        VStack {
            UIBadgeView()
            BadgeView(viewModel: $viewModel)
                .background(Color.blue)
        }
    }
}

struct BadgeComponentView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeComponentView()
    }
}
