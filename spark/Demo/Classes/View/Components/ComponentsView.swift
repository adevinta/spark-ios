//
//  ComponentsView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct ComponentsView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Badge") {
                    BadgeComponentView()
                }

                NavigationLink("Button") {
                    Text("TODO")
                }

                NavigationLink("Checkbox") {
                    ComponentsCheckboxListView()
                }

                NavigationLink("Chip") {
                    ChipComponentUIView()
                }

                NavigationLink("Radio Button") {
                    RadioButtonOverview()
                }

                NavigationLink("Switch") {
                    Text("TODO")
                }

                NavigationLink("Tag") {
                    TagComponentView()
                }
            }
            .navigationBarTitle(Text("Components"))
        }
    }
}

struct ComponentsView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsView()
    }
}
