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

struct SwitchComponentViewRepresentable: UIViewRepresentable {

    // MARK: - Properties

    private let viewModel: SwitchComponentViewModel
    private let attributedText: NSAttributedString

    var width: CGFloat
    @Binding var height: CGFloat

    @Binding var isOn: Bool
    private let alignment: SwitchAlignment
    private let intent: SwitchIntent
    private let isEnabled: Bool
    private let hasImages: Bool
    private let textContent: SwitchTextContentDefault

    // MARK: - Initialization

    init(
        viewModel: SwitchComponentViewModel,
        width: CGFloat,
        height: Binding<CGFloat>,
        isOn: Binding<Bool>,
        alignment: SwitchAlignment,
        intent: SwitchIntent,
        isEnabled: Bool,
        hasImages: Bool,
        textContent: SwitchTextContentDefault
    ) {
        self.viewModel = viewModel
        self.attributedText = .init(
            string: viewModel.text,
            attributes: [
                .foregroundColor: SparkTheme.shared.colors.main.main.uiColor,
                .font: SparkTheme.shared.typography.body2Highlight.uiFont
            ]
        )
        self.width = width
        self._height = height
        self._isOn = isOn
        self.alignment = alignment
        self.intent = intent
        self.isEnabled = isEnabled
        self.hasImages = hasImages
        self.textContent = textContent
    }

    // MARK: - Maker

    func makeUIView(context: Context) -> UIView {
        var switchView: SwitchUIView

        switch self.textContent {
        case .text:
            switchView = self.makeView(isMultilineText: false)
        case .attributedText:
            if self.hasImages {
                switchView = SwitchUIView(
                    theme: SparkTheme.shared,
                    isOn: self.isOn,
                    alignment: self.alignment,
                    intent: self.intent,
                    isEnabled: self.isEnabled,
                    images: self.images(),
                    attributedText: self.attributedText
                )
            } else {
                switchView = SwitchUIView(
                    theme: SparkTheme.shared,
                    isOn: self.isOn,
                    alignment: self.alignment,
                    intent: self.intent,
                    isEnabled: self.isEnabled,
                    attributedText: self.attributedText
                )
            }
        case .multilineText:
            switchView = self.makeView(isMultilineText: false)
        }
        switchView.delegate = context.coordinator

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
        view.addSubview(switchView)

        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        switchView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        switchView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        switchView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: switchView.heightAnchor).isActive = true

        return view
    }

    func updateUIView(_ stackView: UIView, context: Context) {
        guard let switchView = stackView.subviews.compactMap({ $0 as? SwitchUIView }).first else {
            return
        }

        if switchView.isOn != self.isOn {
            switchView.isOn = self.isOn
        }

        if switchView.alignment != self.alignment {
            switchView.alignment = self.alignment
        }

        if switchView.intent != self.intent {
            switchView.intent = self.intent
        }

        if switchView.isEnabled != self.isEnabled {
            switchView.isEnabled = self.isEnabled
        }

        if (switchView.images == nil && self.hasImages) ||
            (switchView.images != nil && !self.hasImages) {
            switchView.images = self.hasImages ? self.images() : nil
        }

        if self.textContent.shouldShowText {
            switchView.text = self.viewModel.text(isMultilineText: self.textContent.isMultilineText)
        }

        if self.textContent.shouldShowShowAttributeText {
            switchView.attributedText = self.attributedText
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

    private func images() -> SwitchUIImages {
        let onImage = UIImage(named: self.viewModel.onImageNamed) ?? UIImage()
        let offImage = UIImage(named: self.viewModel.offImageNamed) ?? UIImage()

        return SwitchUIImages(
            on: onImage,
            off: offImage
        )
    }

    private func makeView(isMultilineText: Bool) -> SwitchUIView {
        if self.hasImages {
            return SwitchUIView(
                theme: SparkTheme.shared,
                isOn: self.isOn,
                alignment: self.alignment,
                intent: self.intent,
                isEnabled: self.isEnabled,
                images: self.images(),
                text: self.viewModel.text(isMultilineText: isMultilineText)
            )
        } else {
            return SwitchUIView(
                theme: SparkTheme.shared,
                isOn: self.isOn,
                alignment: self.alignment,
                intent: self.intent,
                isEnabled: self.isEnabled,
                text: self.viewModel.text(isMultilineText: isMultilineText)
            )
        }
    }
}

extension SwitchComponentViewRepresentable {

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
