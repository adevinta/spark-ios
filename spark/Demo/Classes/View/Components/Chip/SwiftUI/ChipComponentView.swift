//
//  ChipComponentView.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 21.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI

struct ChipComponentView: View {

    let theme: Theme
    let intent: ChipIntent
    let variant: ChipVariant
    let label: String?
    let icon: UIImage?
    let component: UIView?
    let action: (() -> Void)?

//    init(theme: Theme, intent: ChipIntent, variant: ChipVariant, label: String?, icon: UIImage?, component: UIView?, action: (() -> Void)?) {
//        self.theme = theme
//        self.intent = intent
//        self.variant = variant
//        self.showComponent = showComponent
//        self.label = label
//        self.icon = icon
//        self.action = action
//    }

    var body: some View {
        ChipComponentUIViewRepresentation(
            theme: self.theme,
            intent: self.intent,
            variant: self.variant,
            label: self.label,
            icon: self.icon,
            component: self.component,
            action: self.action
        )
    }
}

struct ChipComponentUIViewRepresentation: UIViewRepresentable {

    let theme: Theme
    let intent: ChipIntent
    let variant: ChipVariant
    let label: String?
    let icon: UIImage?
    let component: UIView?
    let action: (()->Void)?

    func makeUIView(context: Context) -> ChipUIView {
        let chipView: ChipUIView
        if let label = self.label, let icon = self.icon {
            chipView = ChipUIView(
                theme: self.theme,
                intent: self.intent,
                variant: self.variant,
                label: label,
                iconImage: icon)
        } else if let icon = icon {
            chipView = ChipUIView(
                theme: self.theme,
                intent: self.intent,
                variant: self.variant,
                iconImage: icon)
        } else {
            chipView = ChipUIView(
                theme: self.theme,
                intent: self.intent,
                variant: self.variant,
                label: "")
        }
        chipView.action = self.action
        chipView.component = self.component
        return chipView
    }

    func updateUIView(_ chipView: ChipUIView, context: Context) {
        chipView.intent = self.intent
        chipView.theme = self.theme
        chipView.variant = self.variant
        chipView.text = self.label
        chipView.icon = self.icon
        chipView.action = self.action
        chipView.component = self.component
    }
}
