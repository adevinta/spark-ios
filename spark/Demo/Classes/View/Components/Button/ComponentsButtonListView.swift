//
//  ComponentsButtonListView.swift
//  SparkDemo
//
//  Created by janniklas.freundt.ext on 22.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct ComponentsButtonListView: View {
    var body: some View {
        List {
            Section(header: Text("UIKit")) {
                NavigationLink("Button") {
                    ButtonUIViewControllerBridge()
                }
            }
        }
        .navigationBarTitle(Text("Button"))
    }
}

struct ComponentsButtonListView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsButtonListView()
    }
}
