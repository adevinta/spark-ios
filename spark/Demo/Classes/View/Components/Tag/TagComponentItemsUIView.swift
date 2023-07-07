//
//  TagComponentItemsUIView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 17/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import Spark
import SparkCore

struct TagComponentItemsUIView: UIViewRepresentable {

    // MARK: - Properties

    private let viewModel: TagComponentViewModel
    private let iconImage: UIImage

    @Binding var height: CGFloat

    private let intentColor: TagIntentColor
    private let variant: TagVariant
    private let content: TagContent

    // MARK: - Initialization

    init(
        viewModel: TagComponentViewModel,
        height: Binding<CGFloat>,
        intentColor: TagIntentColor,
        variant: TagVariant,
        content: TagContent
    ) {
        self.viewModel = viewModel
        self.iconImage = UIImage(named: viewModel.imageNamed) ?? UIImage()
        self._height = height
        self.intentColor = intentColor
        self.variant = variant
        self.content = content
    }

    // MARK: - Maker

    func makeUIView(context: Context) -> UIStackView {
        var tagView: TagUIView

        let theme = SparkThemePublisher.shared.theme
        switch self.content {
        case .icon:
            tagView = TagUIView(
                theme: theme,
                intentColor: self.intentColor,
                variant: self.variant,
                iconImage: self.iconImage
            )

        case .text:
            tagView = TagUIView(
                theme: theme,
                intentColor: self.intentColor,
                variant: self.variant,
                text: self.viewModel.text
            )

        case .all:
            tagView = TagUIView(
                theme: theme,
                intentColor: self.intentColor,
                variant: self.variant,
                iconImage: self.iconImage,
                text: self.viewModel.text
            )
        }

        let stackView = UIStackView(arrangedSubviews: [
            tagView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalTo: tagView.heightAnchor).isActive = true

        return stackView
    }

    func updateUIView(_ stackView: UIStackView, context: Context) {
        guard let tagView = stackView.arrangedSubviews.compactMap({ $0 as? TagUIView }).first else {
            return
        }

        if tagView.intentColor != self.intentColor {
            tagView.intentColor = self.intentColor
        }

        if tagView.variant != self.variant {
            tagView.variant = self.variant
        }

        if (tagView.iconImage == nil && self.content.shouldShowIcon) ||
            (tagView.iconImage != nil && !self.content.shouldShowIcon) {
            tagView.iconImage = self.content.shouldShowIcon ? self.iconImage : nil
        }

        if (tagView.text == nil && self.content.shouldShowText) ||
            (tagView.text != nil && !self.content.shouldShowText) {
            tagView.text = self.content.shouldShowText ? self.viewModel.text : nil
        }

        DispatchQueue.main.async {
            self.height = tagView.frame.height
        }
    }
}
