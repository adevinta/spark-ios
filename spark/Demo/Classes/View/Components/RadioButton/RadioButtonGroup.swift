//
//  RadioButtonGroupView.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct RadioButtonGroup: View {
    // MARK: - Properties

    @State var selectedID: Int = 1
    let theme = SparkTheme.shared

    // MARK: - View
    var body: some View {
        VStack {
            RadioButtonGroupView(
                theme: self.theme,
                title: "Radio Button Group",
                selectedID: self.$selectedID,
                items: [
                    RadioButtonItem(id: 1,
                                    label: "1 Lorem Ipsum is dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
                    RadioButtonItem(id: 2,
                                    label: "2 Radio button / Enabled",
                                    state: .enabled),
                    RadioButtonItem(id: 3,
                                    label: "3 Radio button / Disabed",
                                    state: .disabled),
                    RadioButtonItem(id: 4,
                                    label: "4 Radio button / Error",
                                    state: .error(message: "Error")),
                    RadioButtonItem(id: 5,
                                    label: "5 Radio button / Success",
                                    state: .success(message: "Success")),
                    RadioButtonItem(id: 6,
                                    label: "6 Radio button / Warning",
                                    state: .warning(message: "Warning")),
                ])
            Text("Selected Value \(selectedID)")

        }
    }
}

struct RadioButtonGroupView_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonGroup()
    }
}
