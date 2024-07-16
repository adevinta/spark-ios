//
//  ComponentsConfigurationUIView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 25/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
@_spi(SI_SPI) import SparkCommon

final class ComponentsConfigurationUIView: UIView {

    // MARK: - Components

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.titleLabel,
            self.itemsStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Configuration"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private lazy var itemsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: self.itemsView)
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    private lazy var itemsView: [ComponentsConfigurationItemUIViewModelView] = {
        return self.viewModel.itemsViewModel.map {
            ComponentsConfigurationItemUIViewModelView(viewModel: $0)
        }
    }()

    // MARK: - Properties

    private let viewModel: ComponentsConfigurationUIViewModel

    // MARK: - Initialization

    init(viewModel: ComponentsConfigurationUIViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        // Subviews
        self.addSubview(self.contentStackView)

        // Setup View
        self.setupView()

        // Setup constraints
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views

    private func setupView() {
        self.backgroundColor = .clear
    }

    // MARK: - Constraints

    private func setupConstraints() {
        NSLayoutConstraint.stickEdges(
            from: self.contentStackView,
            to: self
        )
    }
}
