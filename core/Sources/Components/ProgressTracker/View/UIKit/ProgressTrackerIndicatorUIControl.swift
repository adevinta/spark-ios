//
//  ProgressTrackerIndicatorUIControl.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 26.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import Foundation
import UIKit

/// The round small indicator on the progress tracker
final class ProgressTrackerIndicatorUIControl: UIControl {

    private let viewModel: ProgressTrackerIndicatorViewModel<ProgressTrackerUIIndicatorContent>

    var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    var intent: ProgressTrackerIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    var content: ProgressTrackerUIIndicatorContent {
        get {
            return self.viewModel.content
        }
        set {
            self.viewModel.content = newValue
        }
    }

    var size: ProgressTrackerSize {
        get {
            return self.viewModel.size
        }
        set {
            self.viewModel.size = newValue
        }
    }

    var variant: ProgressTrackerVariant {
        get {
            return self.viewModel.variant
        }
        set {
            self.viewModel.variant = newValue
        }
    }

    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.adjustsFontForContentSizeCategory = true
        label.isHidden = true
        label.numberOfLines = 1
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        imageView.isUserInteractionEnabled = false
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true

        imageView.setContentCompressionResistancePriority(.required,
                                                      for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required,
                                                      for: .vertical)

        return imageView
    }()

    private var cancellables = Set<AnyCancellable>()
    private var heightConstraint: NSLayoutConstraint?
    private var imageHeightConstraint: NSLayoutConstraint?

    @ScaledUIMetric var scaleFactor: CGFloat = 1.0

    private var borderWidth: CGFloat {
        return self.scaleFactor * ProgressTrackerConstants.borderWidth
    }

    private var imageHeight: CGFloat {
        return self.scaleFactor * ProgressTrackerConstants.iconHeight
    }

    override var isHighlighted: Bool {
        didSet {
            self.viewModel.set(highlighted: self.isHighlighted)
        }
    }

    override var isEnabled: Bool {
        didSet {
            self.viewModel.set(enabled: self.isEnabled)
        }
    }

    override var isSelected: Bool {
        didSet {
            self.viewModel.set(selected: self.isSelected)
        }
    }

    // MARK: - Initialization
    convenience init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize,
        content: ProgressTrackerUIIndicatorContent) {
            let viewModel = ProgressTrackerIndicatorViewModel<ProgressTrackerUIIndicatorContent>(

                theme: theme,
                intent: intent,
                variant: variant,
                size: size,
                content: content,
                state: .normal
            )

            self.init(viewModel: viewModel)
    }

    init(viewModel: ProgressTrackerIndicatorViewModel<ProgressTrackerUIIndicatorContent>) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        self.setupView()
        self.update(colors: self.viewModel.colors)
        self.update(content: self.viewModel.content)
        self.update(font: self.viewModel.font)
        self.updateBorderWidth()
        self.setupSubscriptions()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self._scaleFactor.update(traitCollection: self.traitCollection)

        self.sizesChanged()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private functions
    private func setupView() {
        self.addSubviewSizedEqually(self.indicatorView)
        self.indicatorView.addSubviewCentered(self.imageView)
        self.indicatorView.addSubviewCentered(self.label)

        self.indicatorView.layer.cornerRadius = (self.viewModel.size.rawValue * self.scaleFactor) / 2
        
        let heightConstraint = self.indicatorView.heightAnchor.constraint(equalToConstant: self.viewModel.size.rawValue * self.scaleFactor)

        let imageHeightConstraint =
        self.imageView.heightAnchor.constraint(equalToConstant: self.imageHeight)

        NSLayoutConstraint.activate([
            heightConstraint,
            imageHeightConstraint,
            self.indicatorView.widthAnchor.constraint(equalTo: self.indicatorView.heightAnchor)
        ])
        self.imageHeightConstraint = imageHeightConstraint
        self.heightConstraint = heightConstraint
    }

    private func setupSubscriptions() {
        self.viewModel.$colors.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] colors in
            self?.update(colors: colors)
        }
        self.viewModel.$size.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] size in
            self?.update(size: size)
        }
        self.viewModel.$content.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] content in
            self?.update(content: content)
        }
        self.viewModel.$font.removeDuplicates(by: { $0.uiFont == $1.uiFont }).subscribe(in: &self.cancellables) { [weak self] font in
            self?.update(font: font)
        }
    }

    private func updateBorderWidth() {
        self.indicatorView.setBorderWidth(self.borderWidth)
    }

    private func update(font: TypographyFontToken) {
        self.label.font = font.uiFont
    }

    private func update(colors: ProgressTrackerColors) {
        self.indicatorView.backgroundColor = colors.background.uiColor
        self.indicatorView.setBorderColor(from: colors.outline)
        self.imageView.tintColor = colors.content.uiColor
        self.label.textColor = colors.content.uiColor
    }

    private func update(content: ProgressTrackerUIIndicatorContent) {
        self.update(content: content, andSize: self.viewModel.size)
    }

    private func update(content: ProgressTrackerUIIndicatorContent, andSize size: ProgressTrackerSize) {
        if size == .small {
            self.imageView.isHidden = true
            self.label.isHidden = true
        } else if let image = content.indicatorImage {
            self.imageView.image = image
            self.imageView.isHidden = false
            self.label.isHidden = true
        } else if let text = content.label {
            self.label.text = String(text)
            self.label.isHidden = false
            self.imageView.isHidden = true
        } else {
            self.imageView.isHidden = true
            self.label.isHidden = true
        }
    }

    private func update(size: ProgressTrackerSize) {
        self.update(content: self.viewModel.content, andSize: size)
        self.heightConstraint?.constant = size.rawValue * self.scaleFactor
        self.indicatorView.layer.cornerRadius = (size.rawValue * self.scaleFactor) / 2
    }

    private func sizesChanged() {
        self.update(size: self.viewModel.size)
        self.imageHeightConstraint?.constant = self.imageHeight
        self.indicatorView.setBorderWidth(self.borderWidth)
    }

    func set(size: ProgressTrackerSize) {
        self.viewModel.size = size
    }
}
