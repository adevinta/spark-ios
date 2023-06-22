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

    var width: CGFloat
    @Binding var height: CGFloat

    @Binding var isOn: Bool
    private let alignment: SwitchAlignment
    private let intentColor: SwitchIntentColor
    private let isEnabled: Bool
    private let isVariant: Bool
    private let isMultilineText: Bool

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
        isMultilineText: Bool
    ) {
        self.viewModel = viewModel
        self.width = width
        self._height = height
        self._isOn = isOn
        self.alignment = alignment
        self.intentColor = intentColor
        self.isEnabled = isEnabled
        self.isVariant = isVariant
        self.isMultilineText = isMultilineText
    }

    // MARK: - Maker

    func makeUIView(context: Context) -> UIStackView {
        var switchView: SwitchUIView
        if self.isVariant {
            switchView = SwitchUIView(
                theme: SparkTheme.shared,
                isOn: self.isOn,
                alignment: self.alignment,
                intentColor: self.intentColor,
                isEnabled: self.isEnabled,
                variant: self.variant(),
                text: self.viewModel.text(isMultilineText: self.isMultilineText)
            )
        } else {
            switchView = SwitchUIView(
                theme: SparkTheme.shared,
                isOn: self.isOn,
                alignment: self.alignment,
                intentColor: self.intentColor,
                isEnabled: self.isEnabled,
                text: self.viewModel.text(isMultilineText: self.isMultilineText)
            )
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

        if switchView.text != self.viewModel.text(isMultilineText: self.isMultilineText) {
            switchView.text = self.viewModel.text(isMultilineText: self.isMultilineText)
        }

        DispatchQueue.main.async {
            self.height = switchView.frame.height
        }
    }

    // MARK: - Coordinator

    func makeCoordinator() -> Coordinator {
        return Coordinator(isOn: self.$isOn)
    }

    // MARK: - Getter

    private func variant() -> SwitchVariant {
        let onImage = UIImage(named: self.viewModel.onImageNamed) ?? UIImage()
        let offImage = UIImage(named: self.viewModel.offImageNamed) ?? UIImage()

        return .init(
            onImage: onImage,
            offImage: offImage
        )
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
