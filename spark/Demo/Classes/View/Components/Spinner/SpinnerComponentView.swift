//
//  SpinnerComponentView.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 07.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import Foundation
import SwiftUI

struct SpinnerComponentView: View {
    @State private var spinnerStarted = true
    var body: some View {
        VStack {
            HStack {
                UISpinnerView()
                Button(spinnerStarted ? "Stop " : "Start") {
                    self.spinnerStarted.toggle()
                }
            }
            Spacer()
        }
    }
}

struct SpinnerComponentView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerComponentView()
    }
}
