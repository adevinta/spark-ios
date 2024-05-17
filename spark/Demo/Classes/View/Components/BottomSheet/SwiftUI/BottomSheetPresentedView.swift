//
//  BottomSheetPresentedView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 17.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

struct BottomSheetPresentedView: View {
    var description: String = """
Sample of a SwiftUI bottom sheet with little text.
🧡💙
"""
    var dismiss: () -> Void

    var body: some View {
        VStack(spacing: 40) {
            Text("Bottom Sheet").font(.title)
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            Button {
                self.dismiss()
            } label: {
                Text("Dismiss")
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity)
        .background(alignment: .top) {
            Image("BottomSheet")
        }
    }
}
