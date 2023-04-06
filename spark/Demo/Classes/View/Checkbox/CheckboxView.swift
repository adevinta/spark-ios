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

    private func title(for state: SparkCheckboxState) -> String {
        switch state {
        case .enabled:
            return "Enabled"
        case .disabled:
            return "Disabled"
        case .focused:
            return "Focused"
        case .pressed:
            return "Pressed"
        case .hover:
            return "Hover"
        case .success:
            return "Success"
        case .warning:
            return "Warning"
        case .error:
            return "Error"
        @unknown default:
            return "Unknown"
        }
    }

    @State private var selection1: SparkCheckboxSelectionState = .selected
    @State private var selection2: SparkCheckboxSelectionState = .unselected
    @State private var selection3: SparkCheckboxSelectionState = .indeterminate
    @State private var selection4: SparkCheckboxSelectionState = .selected


    var body: some View {
        List(viewModel.states, id: \.self) { state in
            Section(header: Text("State \(title(for: state))")) {
                let theming = SparkCheckboxTheming.init(
                    theme: SparkTheme.shared,
                    variant: .filled
                )
                SparkCheckboxView(
                    text: "Selected",
                    theming: theming,
                    state: state,
                    selectionState: $selection1
                )
                SparkCheckboxView(
                    text: "Unselected",
                    theming: theming,
                    state: state,
                    selectionState: $selection2
                )
                SparkCheckboxView(
                    text: "Indeterminate",
                    theming: theming,
                    state: state,
                    selectionState: $selection3
                )
                SparkCheckboxView(
                    text: "Long text lorem ipsum dolor sit et amet abcdefghjijkl",
                    theming: theming,
                    state: state,
                    selectionState: $selection4
                )
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
