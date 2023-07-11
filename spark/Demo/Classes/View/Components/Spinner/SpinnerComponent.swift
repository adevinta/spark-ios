//
//  SpinnerComponent.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct SpinnerComponent: View {

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    @State var intent: SpinnerIntent = .primary
    @State var spinnerSize: SpinnerSize = .medium

    var body: some View {
        VStack {
            Text("SwiftUI")
            SpinnerView(theme: self.theme,
                        intent: self.intent,
                        spinnerSize: self.spinnerSize
            )
            Divider()
            Text("UIKit")
            UISpinnerView()
            Spacer()
        }
    }
}

struct SpinnerComponent_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerComponent()
    }
}
