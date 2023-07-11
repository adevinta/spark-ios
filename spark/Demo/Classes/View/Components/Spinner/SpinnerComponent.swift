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
    @State var isSizesPresented = false
    @State var isIntentPresented = false

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Button(self.spinnerSize.description) {
                    self.isSizesPresented = true
                }
                .confirmationDialog("Select a size", isPresented: self.$isSizesPresented) {
                    ForEach(SpinnerSize.allCases, id: \.self) { size in
                        Button(size.description) {
                            self.spinnerSize = size
                        }
                    }
                }

                Button(self.intent.description) {
                    self.isIntentPresented = true
                }
                .confirmationDialog("Select an intent", isPresented: self.$isIntentPresented) {
                    ForEach(SpinnerIntent.allCases, id: \.self) { intent in
                        Button(intent.description) {
                            self.intent = intent
                        }
                    }
                }
            }.padding(.bottom, 20)

            Text("SwiftUI")
            SpinnerView(theme: self.theme,
                        intent: self.intent,
                        spinnerSize: self.spinnerSize
            )
            Divider()
            Text("UIKit*")
            UISpinnerView(theme: self.theme,
                          intent: self.intent,
                          spinnerSize: self.spinnerSize)
            Text("*The UIKit spinner does not animate in a view representable, but works fine in a standard UIView view hierarchy.")
                .font(.footnote)
            Spacer()
        }
    }
}

struct SpinnerComponent_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerComponent()
    }
}

private extension CaseIterable {
    var description: String {
        return "\(self)".capitalized
    }
}
