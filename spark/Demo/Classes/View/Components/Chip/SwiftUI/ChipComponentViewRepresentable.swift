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

struct ChipComponentViewRepresentable: View {

    let theme: Theme
    let intent: ChipIntent
    let variant: ChipVariant
    let alignment: ChipAlignment
    let label: String?
    let icon: UIImage?
    let component: UIView?
    let isEnabled: Bool
    let action: (() -> Void)?

    var body: some View {
        ChipComponentUIViewRepresentation(
            theme: self.theme,
            intent: self.intent,
            variant: self.variant,
            alignment: self.alignment,
            label: self.label,
            icon: self.icon,
            component: self.component,
            isEnabled: self.isEnabled,
            action: self.action
        )
    }
}

struct ChipComponentUIViewRepresentation: UIViewRepresentable {

    let theme: Theme
    let intent: ChipIntent
    let variant: ChipVariant
    let alignment: ChipAlignment
    let label: String?
    let icon: UIImage?
    let component: UIView?
    let isEnabled: Bool
    let action: (()->Void)?

    func makeUIView(context: Context) -> ChipUIView {
        let chipView: ChipUIView
        if let label = self.label, let icon = self.icon {
            chipView = ChipUIView(
                theme: self.theme,
                intent: self.intent,
                variant: self.variant,
                alignment: self.alignment,
                label: label,
                iconImage: icon)
        } else if let icon = icon {
            chipView = ChipUIView(
                theme: self.theme,
                intent: self.intent,
                variant: self.variant,
                alignment: self.alignment,
                iconImage: icon)
        } else {
            chipView = ChipUIView(
                theme: self.theme,
                intent: self.intent,
                variant: self.variant,
                alignment: self.alignment,
                label: "")
        }
        chipView.action = self.action
        chipView.component = self.component
        chipView.isEnabled = self.isEnabled
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
        chipView.alignment = self.alignment
        chipView.isEnabled = self.isEnabled
    }
}