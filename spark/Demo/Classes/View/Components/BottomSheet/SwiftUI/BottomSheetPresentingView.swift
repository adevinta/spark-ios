//
//  BottomSheetExampleView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 17.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

private let longDescription: String = """
Sample of a SwiftUI bottom sheet with a scroll view.
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
🧡
💙
"""
struct BottomSheetPresentingView: View {
    var body: some View {
        if #available(iOS 16.4, *) {
            BottomSheetPresentingViewWithHeightDetent()
        } else {
            BottomSheetPresentingViewWithoutHeightDetent()
        }
    }
}

@available(iOS 16.4, *)
struct BottomSheetPresentingViewWithHeightDetent: View {
    @State private var showingShortSheet = false
    @State private var showingLongSheet = false
    @State private var shortHeight: CGFloat = 100

    var body: some View {
        VStack {
            Button("Show bottom sheet") {
                self.showingShortSheet.toggle()
            }
            .sheet(isPresented: $showingShortSheet) {
                BottomSheetPresentedView {
                    self.showingShortSheet.toggle()
                }
                .readHeight(self.$shortHeight)
                .presentationDetents([.height(self.shortHeight), .medium, .large])
            }
            .buttonStyle(.borderedProminent)

            Button("Show bottom sheet with scroll view") {
                self.showingLongSheet.toggle()
            }
            .sheet(isPresented: $showingLongSheet) {
                    ScrollView {
                        BottomSheetPresentedView(description: longDescription) {
                            self.showingLongSheet.toggle()
                        }
                    }
                    .scrollIndicators(.visible)
                .presentationDetents([.medium, .large])
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct BottomSheetPresentingViewWithoutHeightDetent: View {
    @State private var showingShortText = false
    @State private var showingLongText = false

    var body: some View {
        VStack {
            Button("Show bottom sheet") {
                self.showingShortText.toggle()
            }
            .sheet(isPresented: $showingShortText) {
                BottomSheetPresentedView() {
                    self.showingShortText.toggle()
                }
            }
            .buttonStyle(.bordered)

            Button("Show bottom sheet with Scroll view") {
                self.showingLongText.toggle()
            }
            .sheet(isPresented: $showingLongText) {
                ScrollView(showsIndicators: false) {
                    BottomSheetPresentedView(description: longDescription) {
                        self.showingLongText.toggle()
                    }
                }
            }
            .buttonStyle(.bordered)
        }
    }
}
