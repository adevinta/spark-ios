//
//  MainView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 02/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Border") {
                    BorderView()
                }

                NavigationLink("Color") {
                    ColorView()
                }

                NavigationLink("Elevation") {
                    ElevationView()
                }

                NavigationLink("Layout") {
                    LayoutView()
                }

                NavigationLink("Typography") {
                    TypographyView()
                }
                NavigationLink("Dims") {
                    DimsView()
                }

                NavigationLink("Checkbox") {
                    CheckboxView()
                }
            }
            .navigationBarTitle(Text("Spark"))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
