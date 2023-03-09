//
//  MainView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 02/03/2023.
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

                NavigationLink("Layout") {
                    LayoutView()
                }

                NavigationLink("Typography") {
                    TypographyView()
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
