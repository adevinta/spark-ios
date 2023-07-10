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
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    var spinnerIntent = SpinnerIntent.primary
    var spinnerSize = SpinnerSize.medium

    func makeUIView(context: Context) -> some UIView {
        return SpinnerUIView(theme: self.theme, intent: spinnerIntent, spinnerSize: spinnerSize)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
