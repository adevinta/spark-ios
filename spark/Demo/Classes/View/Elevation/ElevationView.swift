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
        ScrollView {
            Section(header: Text("Drop Shadow").font(Font.title).underline()) {
                Spacer()
                DropShadowView()
            }.padding()
        }
        .navigationTitle("Elevation")
        .navigationBarTitleDisplayMode(.inline)
    }
}
