//
//  IconComponentViewRepresentable.swift
//  SparkDemo
//
//  Created by Jacklyn Situmorang on 19.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI


struct IconComponentViewRepresentable: UIViewRepresentable {

    @Binding private var intent: IconIntent
    @Binding private var size: IconSize

    init(intent: Binding<IconIntent>, size: Binding<IconSize>) {
        self._intent = intent
        self._size = size
    }

    func makeUIView(context: Context) -> IconUIView {
        return IconUIView(
            iconImage: UIImage(systemName: "lock.circle"),
            theme: SparkTheme.shared,
            intent: self.intent,
            size: self.size
        )
    }

    func updateUIView(_ iconView: IconUIView, context: Context) {
        if iconView.intent != self.intent {
            iconView.intent = self.intent
        }

        if iconView.size != self.size {
            iconView.size = self.size
        }
    }
}
