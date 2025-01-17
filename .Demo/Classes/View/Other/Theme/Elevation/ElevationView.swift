//
//  ElevationView.swift
//  SparkDemo
//
//  Created by louis.borlee on 30/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct ElevationView: View {

    var body: some View {
        List {
            Section(header: Text("Drop Shadow")) {
                DropShadowView()
            }
        }
        .navigationTitle("Elevation")
    }
}

struct ElevationView_Previews: PreviewProvider {
    static var previews: some View {
        ElevationView()
    }
}

