//
//  ButtonComponentItemsUIView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore
import Combine

struct ButtonComponentItemsUIView: UIViewRepresentable {

    // MARK: - Properties

    private let viewModel: ButtonComponentViewModel
    private var iconImage: UIImage

    var width: CGFloat
    @Binding var height: CGFloat

    private let intentColor: ButtonIntentColor
    private let variant: ButtonVariant
    private let size: ButtonSize
    private let shape: ButtonShape
    private let icon: ButtonIcon
    private let isText: Bool
    private let isEnabled: Bool

    // MARK: - Initialization

    init(
        viewModel: ButtonComponentViewModel,
        width: CGFloat,
        height: Binding<CGFloat>,
        intentColor: ButtonIntentColor,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        icon: ButtonIcon,
        isText: Bool,
        isEnabled: Bool
    ) {
        self.viewModel = viewModel
        self.iconImage = .init(named: viewModel.imageNamed) ?? UIImage()
        self.width = width
        self._height = height
        self.intentColor = intentColor
        self.variant = variant
        self.size = size
        self.shape = shape
        self.icon = icon
        self.isText = isText
        self.isEnabled = isEnabled
    }

    // MARK: - Maker

    func makeUIView(context: Context) -> UIStackView {
        let buttonView = ButtonUIView(
            theme: SparkTheme.shared,
            text: self.viewModel.text,
            icon: .leading(icon: self.iconImage), // TODO:
            state: self.isEnabled ? .enabled : .disabled,
            variant:  self.variant,
            intentColor: self.intentColor
        )

        let stackView = UIStackView(arrangedSubviews: [
            buttonView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        stackView.heightAnchor.constraint(equalTo: buttonView.heightAnchor).isActive = true

        return stackView
    }

    func updateUIView(_ stackView: UIStackView, context: Context) {
        guard let buttonView = stackView.arrangedSubviews.compactMap({ $0 as? ButtonUIView }).first else {
            return
        }

//        if buttonView.intentColor != self.intentColor {
//            buttonView.intentColor = self.intentColor
//        }
//
//        if buttonView.variant != self.variant) {
//            buttonView.variant = self.variant
//        }

        if buttonView.size != self.size {
            buttonView.size = size
        }

        if buttonView.shape != self.shape {
            buttonView.shape = shape
        }

//        if buttonView.icon != self.viewModel.icon {
//            buttonView.icon = self.viewModel.icon
//        }

        if buttonView.text != self.viewModel.text {
            buttonView.text = self.viewModel.text
        }

//        if buttonView.isEnabled != self.isEnabled {
//            buttonView.isEnabled = self.isEnabled
//        }

        DispatchQueue.main.async {
            self.height = buttonView.frame.height
        }
    }
}
