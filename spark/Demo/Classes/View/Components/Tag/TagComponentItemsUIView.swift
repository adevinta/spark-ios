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

    let itemViewModel: TagComponentItemViewModel
    private let spacing: CGFloat

    @Binding var height: CGFloat

    // MARK: - Initialization

    init(
        itemViewModel: TagComponentItemViewModel,
        spacing: CGFloat,
        height: Binding<CGFloat>
    ) {
        self.itemViewModel = itemViewModel
        self.spacing = spacing
        self._height = height
    }

    // MARK: - Maker

    func makeUIView(context: Context) -> UIStackView {
        let iconImage = UIImage(named: self.itemViewModel.imageNamed) ?? UIImage()

        let fullTagView = TagUIView(
            theme: SparkTheme.shared,
            intentColor: self.itemViewModel.intentColor,
            variant: self.itemViewModel.variant,
            iconImage: iconImage,
            text: self.itemViewModel.text
        )

        let iconTagView = TagUIView(
            theme: SparkTheme.shared,
            intentColor: self.itemViewModel.intentColor,
            variant: self.itemViewModel.variant,
            iconImage: iconImage
        )

        let textTagView = TagUIView(
            theme: SparkTheme.shared,
            intentColor: self.itemViewModel.intentColor,
            variant: self.itemViewModel.variant,
            text: self.itemViewModel.text
        )

        let stackView = UIStackView(arrangedSubviews: [
            fullTagView,
            iconTagView,
            textTagView,
            UIView()
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = self.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalTo: fullTagView.heightAnchor).isActive = true

        return stackView
    }

    func updateUIView(_ stackView: UIStackView, context: Context) {
        DispatchQueue.main.async {
            guard let tagView = stackView.arrangedSubviews.first(where: { $0 is TagUIView}) else {
                return
            }

            self.height = tagView.frame.height
        }
    }
}
