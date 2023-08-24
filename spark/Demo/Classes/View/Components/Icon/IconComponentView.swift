//
//  IconComponentView.swift
//  SparkDemo
//
//  Created by Jacklyn Situmorang on 25.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct IconComponentView: View {

    // MARK: - Properties

    @State private var uiKitViewHeight: CGFloat = .zero

    @State private var versionSheetIsPresented = false
    @State var version: ComponentVersion = .uiKit

    @State private var sizeSheetIsPresented = false
    @State var size: IconSize = .medium

    @State private var intentSheetIsPresented = false
    @State var intent: IconIntent = .main

    // MARK: - View

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Configuration")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 16) {
                    // Version
                    HStack() {
                        Text("Version: ")
                            .bold()
                        Button("\(self.version.name)") {
                            self.versionSheetIsPresented = true
                        }
                        .confirmationDialog(
                            "Select a version",
                            isPresented: self.$versionSheetIsPresented) {
                                ForEach(ComponentVersion.allCases, id: \.self) { version in
                                    Button("\(version.name)") {
                                        self.version = version
                                    }
                                }
                            }
                    }

                    // Intent
                    HStack() {
                        Text("Intent: ")
                            .bold()
                        Button("\(self.intent.name)") {
                            self.intentSheetIsPresented = true
                        }
                        .confirmationDialog(
                            "Select an intent",
                            isPresented: self.$intentSheetIsPresented) {
                                ForEach(IconIntent.allCases, id: \.self) { intent in
                                    Button("\(intent.name)") {
                                        self.intent = intent
                                    }
                                }
                            }
                    }

                    // Size
                    HStack() {
                        Text("Size: ")
                            .bold()
                        Button("\(self.size.name)") {
                            self.sizeSheetIsPresented = true
                        }
                        .confirmationDialog(
                            "Select a size",
                            isPresented: self.$sizeSheetIsPresented) {
                                ForEach(IconSize.allCases, id: \.self) { size in
                                    Button("\(size.name)") {
                                        self.size = size
                                    }
                                }
                            }
                    }
                }

                Divider()

                Text("Integration")
                    .font(.title2)
                    .bold()

                if self.version == .swiftUI {
                    IconView(
                        theme: SparkTheme.shared,
                        intent: self.intent,
                        size: self.size,
                        iconImage: Image(systemName: "lock.circle")
                    )
                } else {
                    IconComponentUIView(
                        intent: self.$intent,
                        size: self.$size
                    )
                }

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitle(Text("Icon"))
    }
}

struct IconComponentView_Previews: PreviewProvider {
    static var previews: some View {
        IconComponentView()
    }
}
