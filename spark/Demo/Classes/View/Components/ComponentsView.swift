//
//  ComponentsView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 14/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//
// swiftlint:disable all

import SwiftUI
import Spark
import SparkCore

struct ComponentsView: View {

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Badge") {
                    BadgeComponentView()
                }

                NavigationLink("Button") {
                    ButtonComponentView()
                }

                NavigationLink("Checkbox") {
                    ComponentsCheckboxListView()
                }

                NavigationLink("Chip") {
                    ChipComponent()
                }

                NavigationLink("Icon") {
                    IconComponentView()
                }

                NavigationLink("Radio Button") {
                    RadioButtonOverview()
                }

                NavigationLink("Spinner") {
                    SpinnerComponent()
                }

                NavigationLink("Switch") {
                    SwitchComponentView()
                }

                NavigationLink("Tag") {
                    TagComponentView()
                }
            }
            .navigationBarTitle(Text("Components"))
        }
        .background(Color.gray)
        .accentColor(theme.colors.main.main.color)
    }
}

struct ComponentsView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsView()
    }
}
