//
//  CheckboxItemView.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI

struct CheckboxListView: View {

    // MARK: - Properties

    private let viewModel = CheckboxViewModel()

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    @State private var selection1: CheckboxSelectionState = .selected
    @State private var selection2: CheckboxSelectionState = .unselected
    @State private var selection3: CheckboxSelectionState = .indeterminate
    @State private var selection4: CheckboxSelectionState = .selected

    // MARK: - View

    var body: some View {
        List(self.viewModel.states, id: \.self) { state in
            Section(header: Text("State \(self.title(for: state))")) {
                let checkedImage = DemoIconography.shared.checkmark
                CheckboxView(
                    text: "Selected",
                    checkedImage: checkedImage,
                    theme: theme,
                    state: state,
                    selectionState: self.$selection1
                )
                CheckboxView(
                    text: "Unselected",
                    checkedImage: checkedImage,
                    theme: theme,
                    state: state,
                    selectionState: self.$selection2
                )
                CheckboxView(
                    text: "Indeterminate",
                    checkedImage: checkedImage,
                    theme: theme,
                    state: state,
                    selectionState: self.$selection3
                )
                CheckboxView(
                    text: "Long text lorem ipsum dolor sit et amet abcdefghjijkl",
                    checkedImage: checkedImage,
                    theme: theme,
                    state: state,
                    selectionState: self.$selection4
                )
            }
        }
        .navigationBarTitle(Text("Checkbox"))
    }

    private func title(for state: CheckboxState) -> String {
        switch state {
        case .enabled:
            return "Enabled"
        case .disabled:
            return "Disabled"
        @unknown default:
            return ""
        }
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxListView()
    }
}
