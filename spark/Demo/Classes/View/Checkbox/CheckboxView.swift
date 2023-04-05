//
//  CheckboxItemView.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct CheckboxView: View {

    // MARK: - Properties

    private let viewModel = CheckboxViewModel()

    // MARK: - View

    private func title(for variant: SparkTagVariant) -> String {
        switch variant {
        case .tinted:
            return "Tinted"
        case .outlined:
            return "Outlined"
        case .filled:
            return "Filled"
        }
    }

    var body: some View {
        List(viewModel.variants, id: \.self) { variant in
            Section(header: Text("Variant \(title(for: variant))")) {
                ForEach(viewModel.colors, id: \.self) { color in
                    let theming = SparkCheckboxTheming.init(
                        theme: SparkTheme.shared,
                        intentColor: color,
                        variant: variant
                    )
                    SparkCheckboxView(
                        theming: theming,
                        viewModel: .init(
                            text: "Selected",
                            selectionState: .selected
                        )
                    )
                    SparkCheckboxView(
                        theming: theming,
                        viewModel: .init(
                            text: "Unselected",
                            selectionState: .unselected
                        )
                    )
                    SparkCheckboxView(
                        theming: theming,
                        viewModel: .init(
                            text: "Indeterminate",
                            selectionState: .indeterminate
                        )
                    )
                }
            }
        }
        .navigationBarTitle(Text("Checkbox"))
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxView()
    }
}
