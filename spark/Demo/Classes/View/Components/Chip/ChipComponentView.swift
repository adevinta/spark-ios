//
//  ChipComponentView.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 17.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct ChipComponentView: View {
    @ObservedObject private var themePublisher = SparkThemePublisher.shared
    @State private var intent: ChipIntentColor = .primary

    var theme: Theme {
        self.themePublisher.theme
    }

    var body: some View {

        ChipView(theme: theme, intentColor: <#T##ChipIntentColor#>, variant: <#T##ChipVariant#>, label: <#T##String#>, iconImage: <#T##Image#>)
    }
}

struct ChipComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ChipComponentView()
    }
}
