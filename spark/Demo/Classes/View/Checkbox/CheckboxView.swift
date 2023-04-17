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

struct CheckboxListView: View {

    // MARK: - Properties

    private let viewModel = CheckboxViewModel()

    // MARK: - View

    private func title(for state: SelectButtonState) -> String {
        switch state {
        case .enabled:
            return "Enabled"
        case .disabled:
            return "Disabled"
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

    @State private var selection1: CheckboxSelectionState = .selected
    @State private var selection2: CheckboxSelectionState = .unselected
    @State private var selection3: CheckboxSelectionState = .indeterminate
    @State private var selection4: CheckboxSelectionState = .selected


    var body: some View {
        List(viewModel.states, id: \.self) { state in
            Section(header: Text("State \(title(for: state))")) {
                let theming = CheckboxTheming.init(
                    theme: SparkTheme.shared
                )
                CheckboxView(
                    text: "Selected",
                    theming: theming,
                    state: state,
                    selectionState: $selection1
                )
                CheckboxView(
                    text: "Unselected",
                    theming: theming,
                    state: state,
                    selectionState: $selection2
                )
                CheckboxView(
                    text: "Indeterminate",
                    theming: theming,
                    state: state,
                    selectionState: $selection3
                )
                CheckboxView(
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
        CheckboxListView()
    }
}
