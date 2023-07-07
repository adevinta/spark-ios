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

    private var isSpinning: Bool = false

    var theme: Theme {
        self.themePublisher.theme
    }

    init(isSpinning: Bool) {
        self.isSpinning = isSpinning
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = SpinnerUIView(theme: self.theme)
        if isSpinning {
            view.start()
        }
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
