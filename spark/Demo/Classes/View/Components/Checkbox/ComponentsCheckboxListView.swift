//
//  ComponentsCheckboxListView.swift
//  SparkDemo
//
//  Created by janniklas.freundt.ext on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct ComponentsCheckboxListView: View {
    var body: some View {
        List {
            NavigationLink("Checkbox") {
                CheckboxListView()
            }

            NavigationLink("Checkbox Group") {
                CheckboxGroupListView()
            }
        }
        .navigationBarTitle(Text("Checkbox"))
    }
}

struct ComponentsCheckboxListView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsCheckboxListView()
    }
}
