//
//  SnackbarPresentationDemoUIView.swift
//  SparkDemo
//
//  Created by louis.borlee on 23/10/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit
import Combine
@_spi(SI_SPI) import SparkCommon
import SparkCore

final class SnackbarPresentationDemoUIView: UIViewController {

    private let scrollView = UIScrollView()
    private let verticalStackView = UIStackView()

    private var direction: SnackbarPresentationDirection = .bottom
    private var autoDismissDelay: SnackbarAutoDismissDelay = .fast

    private var cancellables = Set<AnyCancellable>()

    private let snackbar = SnackbarUIView(
        theme: SparkTheme.shared,
        intent: .basic
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupView()
    }

    private func setupView() {
        self.setupScrollView()
        self.setupConfiguration()
        self.setupSnackbar()
        self.setupButtons()
    }

    private func setupScrollView() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false

        self.verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.verticalStackView.axis = .vertical
        self.verticalStackView.alignment = .leading
        self.verticalStackView.spacing = 12

        self.scrollView.addSubview(self.verticalStackView)
        self.view.addSubview(self.scrollView)

        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 12),
            self.verticalStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 12),
            self.verticalStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.scrollView.bottomAnchor, constant: -20),
            self.verticalStackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.verticalStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -24)
        ])
    }

    private func setupConfiguration() {
        self.setupPresentationDirectionConfiguration()
        self.setupAutoDismissDelayConfiguration()
    }

    private func setupPresentationDirectionConfiguration() {
        let presentationDirectionConfiguration = EnumSelectorView(
            title: "PresentationDirection:",
            currentCase: self.direction,
            presenter: self
        )
        presentationDirectionConfiguration.$currentCase.dropFirst().subscribe(
            in: &self.cancellables) { [weak self] newValue in
                guard let self else { return }
                self.direction = newValue
            }
        self.verticalStackView.addArrangedSubview(presentationDirectionConfiguration)
        self.verticalStackView.setCustomSpacing(0, after: presentationDirectionConfiguration)
    }

    private func setupAutoDismissDelayConfiguration() {
        let autoDismissDelayConfiguration = EnumSelectorView(
            title: "AutoDismissDelay:",
            currentCase: self.autoDismissDelay,
            presenter: self
        )
        autoDismissDelayConfiguration.$currentCase.dropFirst().subscribe(
            in: &self.cancellables) { [weak self] newValue in
                guard let self else { return }
                self.autoDismissDelay = newValue
            }
        self.verticalStackView.addArrangedSubview(autoDismissDelayConfiguration)
    }

    private func setupSnackbar() {
        self.snackbar.label.text = "Snackbar text"
        let button = self.snackbar.addButton()
        button.setTitle("Dismiss", for: .normal)
        button.addAction(.init(handler: { _ in
            self.snackbar.dismiss(completion: nil)
        }), for: .touchUpInside)
    }

    private func setupButtons() {
        let showSnackbarButton = UIButton(configuration: .filled())
        showSnackbarButton.setTitle("Show Snackbar", for: .normal)
        showSnackbarButton.addAction(.init(handler: { _ in
            self.snackbar.show(
                in: self.view,
                from: self.direction)
        }), for: .touchUpInside)

        let showAndDismissSnackbarButton = UIButton(configuration: .filled())
        showAndDismissSnackbarButton.setTitle("Show and dismiss Snackbar", for: .normal)
        showAndDismissSnackbarButton.addAction(.init(handler: { _ in
            self.snackbar.showAndDismiss(
                in: self.view,
                from: self.direction,
                autoDismissDelay: self.autoDismissDelay)
        }), for: .touchUpInside)

        self.verticalStackView.addArrangedSubviews([showSnackbarButton, showAndDismissSnackbarButton])
    }
}
