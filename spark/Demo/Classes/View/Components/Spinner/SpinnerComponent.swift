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

    @State private var versionSheetIsPresented = false
    @State var version: ComponentVersion = .swiftUI

    @State var intent: SpinnerIntent = .primary
    @State var isIntentPresented = false
    @State var spinnerSize: SpinnerSize = .medium
    @State var isSizesPresented = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Configuration")
                .font(.title2)
                .bold()
                .padding(.bottom, 6)
            HStack() {
                Text("Version: ")
                Button(self.version.name) {
                    self.versionSheetIsPresented = true
                }
                .confirmationDialog("Select a version",
                                    isPresented: self.$versionSheetIsPresented) {
                    ForEach(ComponentVersion.allCases, id: \.self) { version in
                        Button(version.name) {
                            self.version = version
                        }
                    }
                }
                Spacer()
            }
            HStack() {
                Text("Intent: ")
                Button(self.intent.name) {
                    self.isIntentPresented = true
                }
                .confirmationDialog("Select an intent", isPresented: self.$isIntentPresented) {
                    ForEach(SpinnerIntent.allCases, id: \.self) { intent in
                        Button(intent.name) {
                            self.intent = intent
                        }
                    }
                }
            }
            HStack() {
                Text("Spinner Size: ")
                Button(self.spinnerSize.name) {
                    self.isSizesPresented = true
                }
                .confirmationDialog("Select a size", isPresented: self.$isSizesPresented) {
                    ForEach(SpinnerSize.allCases, id: \.self) { size in
                        Button(size.name) {
                            self.spinnerSize = size
                        }
                    }
                }
            }

            Divider()

            Text("Integration")
                .font(.title2)
                .bold()

            if version == .swiftUI {
                SpinnerView(theme: self.theme,
                            intent: self.intent,
                            spinnerSize: self.spinnerSize
                )
            } else {
                VStack(alignment: .leading) {
                    UISpinnerView(theme: self.theme,
                                  intent: self.intent,
                                  spinnerSize: self.spinnerSize)
                    Text("*").baselineOffset(0.5) +
                    Text("The UIKit spinner does not animate in a view representable, but works fine in a standard UIView view hierarchy.")
                        .font(.footnote)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarTitle(Text("Spinner"))
    }
}

struct SpinnerComponent_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerComponent()
    }
}

private extension CaseIterable {
    var name: String {
        return "\(self)".capitalizingFirstLetter
    }
}

extension String {
    var capitalizingFirstLetter: String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
