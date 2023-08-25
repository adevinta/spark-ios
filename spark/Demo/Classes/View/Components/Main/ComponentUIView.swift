//
//  ComponentUIView.swift
//  Spark
//
//  Created by robin.lemaire on 25/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

class ComponentUIView: UIView {

    // MARK: - UIViews

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.accessibilityIdentifier = self.viewModel.identifier + "ScrollView"
        scrollView.addSubview(self.contentStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.configurationView,
            self.separationLineView,
            self.integrationStackView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = self.viewModel.identifier + "StackView"
        return stackView
    }()

    private lazy var configurationView: ComponentsConfigurationUIView = {
        return .init(
            viewModel: self.viewModel.configurationViewModel
        )
    }()

    private lazy var separationLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var integrationStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.integrationLabel,
                self.componentStackView
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private lazy var integrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Integration"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private lazy var componentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.componentView,
                self.componentSpaceView
            ]
        )
        stackView.axis = .horizontal
        return stackView
    }()

    private let componentView: UIView

    lazy var componentSpaceView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()

    // MARK: - Properties

    private let viewModel: any ComponentUIViewModel

    // MARK: - Initialization

    init(viewModel: some ComponentUIViewModel,
         componentView: UIView) {
        self.viewModel = viewModel

        self.componentView = componentView

        super.init(frame: .zero)

        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        // Properties
        self.backgroundColor = .white
        self.accessibilityIdentifier = self.viewModel.identifier

        // Subviews
        self.addSubview(self.scrollView)

        // Add constraints
        self.setupConstraints()
    }

    private func setupConstraints() {
        // ScrollView
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        // Content StackView
        let spacing: CGFloat = 16
        NSLayoutConstraint.stickEdges(
            from: self.contentStackView,
            to: self.scrollView,
            insets: .init(top: 0, left: spacing, bottom: 0, right: spacing)
        )
        NSLayoutConstraint.activate([
            self.contentStackView.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                constant: -spacing * 2
            )
        ])

        // Separation Line View
        NSLayoutConstraint.activate([
            self.separationLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
