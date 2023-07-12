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
    @State var rightTextAligment: Bool = false
    @State var dummyBinding: Int = 1
    @State var groupState: RadioButtonGroupState = .enabled
    @State var stateSheetIsPresented = false

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            Button(self.groupState.description) {
                self.stateSheetIsPresented = true
            }
            .confirmationDialog("Select a state", isPresented: self.$stateSheetIsPresented) {
                ForEach(RadioButtonGroupState.allCases, id: \.self) { state in
                    Button(state.description) {
                        self.groupState = state
                    }
                }
            }
            .padding(.bottom, 20)

            RadioButtonGroupView(
                theme: self.theme,
                title: "Radio Button Group (SwiftUI)",
                selectedID: self.$selectedID,
                items: [
                    RadioButtonItem(id: 1,
                                    label: "1 Lorem Ipsum is dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
                    RadioButtonItem(id: 2,
                                    label: .init("2 Radio button")),
                    RadioButtonItem(id: 3,
                                    label: .init("3 Radio button")),
                    RadioButtonItem(id: 4,
                                    label: .init("4 Radio button")),
                    RadioButtonItem(id: 5,
                                    label: .init("5 Radio button")),
                    RadioButtonItem(id: 6,
                                    label: .init("6 Radio button")),
                ],
                radioButtonLabelPosition: .right,
                state: self.groupState,
                supplementaryLabel: self.groupState.supplementaryLabel
            )
            .padding(.bottom, 20)

            Text("Selected Value \(selectedID)")
                .padding(.bottom, 20)

            Divider()

            Text("Toggle label value")

            RadioButtonGroupView(theme: self.theme,
                                 selectedID: self.$rightTextAligment,
                                 items: [
                                    RadioButtonItem(id: false,
                                                    label: "Left"),
                                    RadioButtonItem(id: true,
                                                    label: "Right")
                                    ],
                                 groupLayout: .horizontal)

            HStack {
                RadioButtonGroupView(theme: self.theme,
                                     selectedID: self.$dummyBinding,
                                     items: [
                                        RadioButtonItem(id: 1,
                                                        label: "Label 1"),
                                        RadioButtonItem(id: 2,
                                                        label: "Label 2")
                                     ],
                                     radioButtonLabelPosition: self.rightTextAligment ? .right : .left,
                                     groupLayout: .horizontal)
                Spacer()
            }

            Spacer()

        }
        .padding(8)
    }
}

struct RadioButtonGroupView_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonGroup()
    }
}
