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
    private let iconImage: UIImage
    private let attributedText: NSAttributedString

    var width: CGFloat
    @Binding var height: CGFloat

    private let intentColor: ButtonIntentColor
    private let variant: ButtonVariant
    private let size: ButtonSize
    private let shape: ButtonShape
    private let alignment: ButtonAlignment
    private let content: ButtonContentDefault
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
        alignment: ButtonAlignment,
        content: ButtonContentDefault,
        isEnabled: Bool
    ) {
        self.viewModel = viewModel
        self.iconImage = .init(named: viewModel.imageNamed) ?? UIImage()
        self.attributedText = .init(
            string: self.viewModel.text,
            attributes: [
                .foregroundColor: UIColor.purple,
                .font: SparkTheme.shared.typography.body2Highlight.uiFont
            ]
        )
        self.width = width
        self._height = height
        self.intentColor = intentColor
        self.variant = variant
        self.size = size
        self.shape = shape
        self.alignment = alignment
        self.content = content
        self.isEnabled = isEnabled
    }

    // MARK: - Maker

    func makeUIView(context: Context) -> UIStackView {
        let buttonView: ButtonUIView

        switch self.content {
        case .icon:
            buttonView = ButtonUIView(
                theme: SparkTheme.shared,
                intentColor: self.intentColor,
                variant: self.variant,
                size: self.size,
                shape: self.shape,
                alignment: self.alignment,
                iconImage: self.iconImage,
                isEnabled: self.isEnabled
            )

        case .text:
            buttonView = ButtonUIView(
                theme: SparkTheme.shared,
                intentColor: self.intentColor,
                variant: self.variant,
                size: self.size,
                shape: self.shape,
                alignment: self.alignment,
                text: self.viewModel.text,
                isEnabled: self.isEnabled
            )

        case .attributedText:
            buttonView = ButtonUIView(
                theme: SparkTheme.shared,
                intentColor: self.intentColor,
                variant: self.variant,
                size: self.size,
                shape: self.shape,
                alignment: self.alignment,
                attributedText: self.attributedText,
                isEnabled: self.isEnabled
            )

        case .iconAndText:
            buttonView = ButtonUIView(
                theme: SparkTheme.shared,
                intentColor: self.intentColor,
                variant: self.variant,
                size: self.size,
                shape: self.shape,
                alignment: self.alignment,
                iconImage: self.iconImage,
                text: self.viewModel.text,
                isEnabled: self.isEnabled
            )

        case .iconAndAttributedText:
            buttonView = ButtonUIView(
                theme: SparkTheme.shared,
                intentColor: self.intentColor,
                variant: self.variant,
                size: self.size,
                shape: self.shape,
                alignment: self.alignment,
                iconImage: self.iconImage,
                attributedText: self.attributedText,
                isEnabled: self.isEnabled
            )
        }

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

        if buttonView.intentColor != self.intentColor {
            buttonView.intentColor = self.intentColor
        }

        if buttonView.variant != self.variant {
            buttonView.variant = self.variant
        }

        if buttonView.size != self.size {
            buttonView.size = self.size
        }

        if buttonView.shape != self.shape {
            buttonView.shape = self.shape
        }

        if buttonView.alignment != self.alignment {
            buttonView.alignment = self.alignment
        }

        switch self.content {
        case .icon:
            buttonView.text = nil
            buttonView.attributedText = nil
            buttonView.iconImage = self.iconImage

        case .text:
            buttonView.iconImage = nil
            buttonView.attributedText = nil
            buttonView.text = self.viewModel.text

        case .attributedText:
            buttonView.iconImage = nil
            buttonView.text = nil
            buttonView.attributedText = self.attributedText

        case .iconAndText:
            buttonView.attributedText = nil
            buttonView.iconImage = self.iconImage
            buttonView.text = self.viewModel.text

        case .iconAndAttributedText:
            buttonView.text = nil
            buttonView.iconImage = self.iconImage
            buttonView.attributedText = self.attributedText
        }

        if buttonView.isEnabled != self.isEnabled {
            buttonView.isEnabled = self.isEnabled
        }

        DispatchQueue.main.async {
            self.height = buttonView.frame.height
        }
    }
}
