//
//  ChipComponentView.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 21.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
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

    init(theme: Theme = SparkTheme.shared,
         intent: ChipIntent = .alert,
         variant: ChipVariant = .outlined,
         alignment: ChipAlignment = .leadingIcon,
         label: String? = "Test",
         icon: UIImage? = nil,
         component: UIView? = nil,
         isEnabled: Bool = true,
         action: (() -> Void)? = {}
    ) {
        self.theme = theme
        self.intent = intent
        self.variant = variant
        self.alignment = alignment
        self.label = label
        self.icon = icon
        self.component = component
        self.action = action
        self.isEnabled = isEnabled
    }

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


struct ChipComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ChipComponentViewRepresentable()
    }
}
