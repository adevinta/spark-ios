//
//  SwitchComponentItemsUIView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 26/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore
import Combine

struct SwitchComponentItemsUIView: UIViewRepresentable {

    // MARK: - Properties

    private let viewModel: SwitchComponentViewModel
    private let attributedText: NSAttributedString

    var width: CGFloat
    @Binding var height: CGFloat

    @Binding var isOn: Bool
    private let alignment: SwitchAlignment
    private let intentColor: SwitchIntentColor
    private let isEnabled: Bool
    private let isVariant: Bool
    private let textContent: SwitchTextContent

    // MARK: - Initialization

    init(
        viewModel: SwitchComponentViewModel,
        width: CGFloat,
        height: Binding<CGFloat>,
        isOn: Binding<Bool>,
        alignment: SwitchAlignment,
        intentColor: SwitchIntentColor,
        isEnabled: Bool,
        isVariant: Bool,
        textContent: SwitchTextContent
    ) {
        self.viewModel = viewModel
        self.attributedText = .init(
            string: viewModel.text,
            attributes: [
                .underlineColor: SparkTheme.shared.colors.base.outline.uiColor,
                .font: SparkTheme.shared.typography.body2Highlight.uiFont
            ]
        )
        self.width = width
        self._height = height
        self._isOn = isOn
        self.alignment = alignment
        self.intentColor = intentColor
        self.isEnabled = isEnabled
        self.isVariant = isVariant
        self.textContent = textContent
    }

    // MARK: - Maker

    func makeUIView(context: Context) -> UIStackView {
        var switchView: SwitchUIView

        switch self.textContent {
        case .text:
            switchView = self.makeView(isMultilineText: false)
        case .attributedText:
            if self.isVariant {
                switchView = SwitchUIView(
                    theme: SparkTheme.shared,
                    isOn: self.isOn,
                    alignment: self.alignment,
                    intentColor: self.intentColor,
                    isEnabled: self.isEnabled,
                    variant: self.variant(),
                    attributedText: self.attributedText
                )
            } else {
                switchView = SwitchUIView(
                    theme: SparkTheme.shared,
                    isOn: self.isOn,
                    alignment: self.alignment,
                    intentColor: self.intentColor,
                    isEnabled: self.isEnabled,
                    attributedText: self.attributedText
                )
            }
        case .multilineText:
            switchView = self.makeView(isMultilineText: false)
        }
        switchView.delegate = context.coordinator

        let stackView = UIStackView(arrangedSubviews: [
            switchView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        stackView.heightAnchor.constraint(equalTo: switchView.heightAnchor).isActive = true

        return stackView
    }

    func updateUIView(_ stackView: UIStackView, context: Context) {
        guard let switchView = stackView.arrangedSubviews.compactMap({ $0 as? SwitchUIView }).first else {
            return
        }

        if switchView.isOn != self.isOn {
            switchView.isOn = self.isOn
        }

        if switchView.alignment != self.alignment {
            switchView.alignment = self.alignment
        }

        if switchView.intentColor != self.intentColor {
            switchView.intentColor = self.intentColor
        }

        if switchView.isEnabled != self.isEnabled {
            switchView.isEnabled = self.isEnabled
        }

        if (switchView.variant == nil && self.isVariant) ||
            (switchView.variant != nil && !self.isVariant) {
            switchView.variant = self.isVariant ? self.variant() : nil
        }

        if ((switchView.text == nil || switchView.text != self.viewModel.text(isMultilineText: self.textContent.isMultilineText)) && self.textContent.showText) ||
            (switchView.text != nil && !self.textContent.showText) {
            if self.textContent.showText {
                switchView.text = self.viewModel.text(isMultilineText: self.textContent.isMultilineText)
            } else {
                switchView.text = nil
            }
        }

        if (switchView.attributedText == nil && self.textContent.showAttributeText) ||
            (switchView.attributedText != nil && !self.textContent.showAttributeText) {
            switchView.attributedText = self.textContent.showAttributeText ? self.attributedText : nil
        }

        DispatchQueue.main.async {
            self.height = switchView.frame.height
        }
    }

    // MARK: - Coordinator

    func makeCoordinator() -> Coordinator {
        return Coordinator(isOn: self.$isOn)
    }

    // MARK: - Getter & Maker

    private func variant() -> SwitchUIVariantImages {
        let onImage = UIImage(named: self.viewModel.onImageNamed) ?? UIImage()
        let offImage = UIImage(named: self.viewModel.offImageNamed) ?? UIImage()

        return SwitchUIVariantImages(
            on: onImage,
            off: offImage
        )
    }

    private func makeView(isMultilineText: Bool) -> SwitchUIView {
        if self.isVariant {
            return SwitchUIView(
                theme: SparkTheme.shared,
                isOn: self.isOn,
                alignment: self.alignment,
                intentColor: self.intentColor,
                isEnabled: self.isEnabled,
                variant: self.variant(),
                text: self.viewModel.text(isMultilineText: isMultilineText)
            )
        } else {
            return SwitchUIView(
                theme: SparkTheme.shared,
                isOn: self.isOn,
                alignment: self.alignment,
                intentColor: self.intentColor,
                isEnabled: self.isEnabled,
                text: self.viewModel.text(isMultilineText: isMultilineText)
            )
        }
    }
}

extension SwitchComponentItemsUIView {

    class Coordinator: NSObject, SwitchUIViewDelegate {

        // MARK: - Properties

        @Binding var isOn: Bool

        var subscriptions = Set<AnyCancellable>()

        // MARK: - Initialization

        init(isOn: Binding<Bool>) {
            _isOn = isOn
        }

        // MARK: - Delegate

        func switchDidChange(_ switchView: SwitchUIView, isOn: Bool) {
            self.isOn = isOn
        }
    }
}
