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
    @State var isSpinning: Bool = true

    var body: some View {
        VStack {
            Button(isSpinning ? "Stop" : "Start") {
                self.isSpinning.toggle()
            }
            Spacer()
            Text("SwiftUI")
            SpinnerView(theme: self.theme,
                        intent: self.intent,
                        spinnerSize: self.spinnerSize,
                        isSpinning: self.$isSpinning
            )
//            Divider()
//            Text("UIKit")
//            UISpinnerView()
            Spacer()
        }
    }
}

struct SpinnerComponent_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerComponent()
    }
}
