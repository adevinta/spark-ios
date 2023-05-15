//
//  BadgeUIView.swift
//  Spark
//
//  Created by alex.vecherov on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// This is the UIKit version for the ``BadgeView``
public class BadgeUIView: UILabel {

    private var viewModel: BadgeViewModel

    public init(viewModel: BadgeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupBadge()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    private func setupBadge() {
        setupBadgeText()
        setupAppearance()
    }

    private func setupBadgeText() {
        text = viewModel.text
        textColor = viewModel.textColor.uiColor
        font = viewModel.textFont.uiFont
        textAlignment = .center
    }

    private func setupAppearance() {
        backgroundColor = viewModel.backgroundColor.uiColor
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = viewModel.badgeBorder.width
        layer.borderColor = viewModel.badgeBorder.color.uiColor.cgColor
        clipsToBounds = true
    }

    public override var intrinsicContentSize: CGSize {
        let size = CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        let estimatedSize = NSString(string: text ?? "").boundingRect(with: size, options: options, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        if viewModel.text.isEmpty {
            return viewModel.emptySize
        } else {
            return CGSize(width: ceil(estimatedSize.width + viewModel.horizontalOffset), height: ceil(estimatedSize.height + viewModel.verticalOffset))
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        preferredMaxLayoutWidth = frame.size.width
        layer.cornerRadius = frame.size.height / 2.0
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
}
