//
//  RadioButtonOverview.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 21.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct RadioButtonOverview: View {

    // MARK: - Body

    var body: some View {
        List {
            NavigationLink("Radio Button SwiftUI") {
                RadioButtonGroup()
            }

            NavigationLink("Radio Button UIKit") {
                RadioButtonUIGroup()
            }
        }
        .navigationBarTitle(Text("Radio Buttons"))
    }
}

// MARK: - Preview
struct RadioButtonOverview_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonOverview()
    }
}
