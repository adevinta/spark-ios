//
//  Spinner-UIViewRepresentable.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 07.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import Foundation
import SwiftUI

struct UISpinnerView: UIViewRepresentable {
    let theme: Theme
    let intent: SpinnerIntent
    let spinnerSize: SpinnerSize

    func makeUIView(context: Context) -> SpinnerUIView {
        return SpinnerUIView(theme: self.theme, intent: self.intent, spinnerSize: self.spinnerSize)
    }

    func updateUIView(_ uiView: SpinnerUIView, context: Context) {
        uiView.intent = self.intent
        uiView.theme = self.theme
        uiView.spinnerSize = self.spinnerSize
    }
}
