//
//  AnimationDemoUIViewController.swift
//  SparkDemo
//
//  Created by robin.lemaire on 18/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
@_spi(SI_SPI) import SparkCommon
import SparkCore
import Combine

final class AnimationDemoUIViewController: UIViewController {

    // MARK: - Components

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(self.contentStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:
                AnimationOption.allCases.map {
                    AnimationUIView(option: $0)
                } + [
                    UIView()
                ]
        )
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Life view cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Style
        self.view.backgroundColor = .systemBackground

        // Subview
        self.view.addSubview(self.scrollView)

        // Constraints
        self.setupConstraints()
    }

    // MARK: - Constraints

    private func setupConstraints() {
        // ScrollView
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        // Content StackView
        let spacing: CGFloat = 16
        NSLayoutConstraint.stickEdges(
            from: self.contentStackView,
            to: self.scrollView,
            insets: .init(top: 0, left: spacing, bottom: 0, right: spacing)
        )

        // Width & Separation Line View
        NSLayoutConstraint.activate([
            self.contentStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -spacing * 2)
        ])
    }
}

// MARK: - Private View

private final class AnimationUIView: UIView {

    // MARK: - Components

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.headerStackView,
                self.animatedStackView,
                self.option.hasBottomSeparationLine ? self.separationLineView : nil
            ].compactMap { $0 }
        )
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.titleLabel,
            self.startButton,
            UIView()
        ])
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.option.title
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private lazy var startButton: ButtonUIView = {
        let view = ButtonUIView(
            theme: SparkTheme.shared,
            intent: .support,
            variant: .ghost,
            size: .medium,
            shape: .rounded,
            alignment: .leadingImage
        )
        view.setTitle("Start", for: .normal)
        view.addAction(.init(handler: { [weak self] _ in
            guard let self else { return }
            view.isEnabled = false

            UIView.animate(
                withType: .bell,
                on: [
                    self.iconView,
                    self.iconButton,
                    self.button.imageView
                ],
                repeat: self.option.repeat,
                completion: { _ in
                    if self.option.canBeReplayed {
                        view.isEnabled = true
                    }
                })

        }), for: .touchUpInside)
        return view
    }()

    private lazy var animatedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.iconView,
            self.iconButton,
            self.button
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()

    private lazy var iconView: IconUIView = {
        return .init(
            iconImage: self.image,
            theme: SparkTheme.shared,
            intent: self.option.iconIntent,
            size: .medium
        )
    }()

    private lazy var iconButton: IconButtonUIView = {
        let view = IconButtonUIView(
            theme: SparkTheme.shared,
            intent: self.option.buttonIntent,
            variant: .filled,
            size: .medium,
            shape: .rounded
        )
        view.setImage(self.image, for: .normal)
        return view
    }()

    private lazy var button: ButtonUIView = {
        let view = ButtonUIView(
            theme: SparkTheme.shared,
            intent: self.option.buttonIntent,
            variant: .outlined,
            size: .medium,
            shape: .rounded,
            alignment: .leadingImage
        )
        view.setImage(self.image, for: .normal)
        view.setTitle("My Text", for: .normal)
        return view
    }()

    private lazy var separationLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()

    private let image = UIImage(systemName: "bell")

    // MARK: - Properties

    private let option: AnimationOption

    // MARK: - Initialization

    init(option: AnimationOption) {
        self.option = option

        super.init(frame: .zero)

        // Setup View
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views

    private func setupView() {
        // Subviews
        self.addSubview(self.contentStackView)

        // Constraints
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.stickEdges(
            from: self.contentStackView,
            to: self
        )
    }
}
