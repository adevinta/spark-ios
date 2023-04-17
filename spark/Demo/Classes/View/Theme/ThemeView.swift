//
//  ThemeView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 02/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct ThemeView: View {
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
                    CheckboxListView()
                }

                NavigationLink("Checkbox Group") {
                    CheckboxGroupListView()
                }
            }
            .navigationBarTitle(Text("Theme"))
        }
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
