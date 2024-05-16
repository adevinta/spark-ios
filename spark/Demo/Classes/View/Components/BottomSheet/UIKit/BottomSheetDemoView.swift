//
//  BottomSheetDemoView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 16.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

protocol DidTapButtonable {
    var didTapButton: (() -> Void)? { get set }
}

final class BottomSheetDemoView: UIView, DidTapButtonable {
    // MARK: - UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bottom Sheet"
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "BottomSheet")
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = self.text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Dismiss"
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        configuration.baseBackgroundColor = .systemOrange
        configuration.cornerStyle = .medium
        button.configuration = configuration
        return button
    }()

    // MARK: - Private variables
    private let text = """
    Sample of the UIKit bottom sheet with little text
    🧡💙
    """

    // MARK: - Interactions
    var didTapButton: (() -> Void)?

    // MARK: Modifiers
    var descriptionText: String? {
        get {
            return self.descriptionLabel.text
        }
        set {
            self.descriptionLabel.text = newValue
        }
    }


    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        layout()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Setup view
    private func setup() {
        self.backgroundColor = .systemBackground
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.button)

        let action = UIAction { [weak self] _ in
            self?.didTapButton?()
        }
        self.button.addAction(action, for: .touchUpInside)
    }

    private func layout() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.topAnchor, constant: 24),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])

        NSLayoutConstraint.activate([
            self.descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            self.button.heightAnchor.constraint(equalToConstant: 44),
            self.button.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
}
