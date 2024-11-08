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
    private var insets: UIEdgeInsets {
        return .init(
            top: self.topInset,
            left: self.leftInset,
            bottom: self.bottomInset,
            right: self.rightInset
        )
    }

    private var leftInset: CGFloat = .zero
    private var rightInset: CGFloat = .zero
    private var topInset: CGFloat = .zero
    private var bottomInset: CGFloat = .zero

    private let numberFormatter = NumberFormatter()

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
        self.setupInsetsConfiguration()
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

    private func setupInsetsConfiguration() {
        let topTextField = UITextField()
        topTextField.placeholder = "Top inset"

        let leftTextField = UITextField()
        leftTextField.placeholder = "Left inset"

        let rightTextField = UITextField()
        rightTextField.placeholder = "Right inset"

        let bottomTextField = UITextField()
        bottomTextField.placeholder = "Bottom inset"

        let textFields = [topTextField, leftTextField, rightTextField, bottomTextField]
        for textField in textFields {
            textField.borderStyle = .roundedRect
            textField.addAction(.init(handler: { _ in
                var newValue = CGFloat.zero
                if let text = textField.text,
                   let number = self.numberFormatter.number(from: text) {
                    newValue = CGFloat(truncating: number)
                }
                switch textField {
                case leftTextField: self.leftInset = newValue
                case rightTextField: self.rightInset = newValue
                case topTextField: self.topInset = newValue
                case bottomTextField: self.bottomInset = newValue
                default: break
                }
            }), for: .editingChanged)
            textField.widthAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
        }

        let hstack = UIStackView(arrangedSubviews: [leftTextField, rightTextField])
        hstack.axis = .horizontal
        hstack.spacing = 12
        hstack.distribution = .fillEqually
        let vstack = UIStackView(arrangedSubviews: [topTextField, hstack, bottomTextField])
        vstack.axis = .vertical
        vstack.spacing = 12
        self.verticalStackView.addArrangedSubview(vstack)
    }

    private func setupSnackbar() {
        self.snackbar.label.text = "Snackbar text"
        self.snackbar.widthAnchor.constraint(lessThanOrEqualToConstant: 600).isActive = true
        let button = self.snackbar.addButton()
        button.setTitle("Dismiss", for: .normal)
        button.addAction(.init(handler: { _ in
            self.snackbar.dismiss(completion: { isFinished in
                print("Dismiss action", isFinished)
            })
        }), for: .touchUpInside)
    }

    private func setupButtons() {
        let showSnackbarButton = UIButton(configuration: .filled())
        showSnackbarButton.setTitle("Show Snackbar", for: .normal)
        showSnackbarButton.addAction(.init(handler: { _ in
            self.snackbar.show(
                in: self.view,
                from: self.direction,
                insets: self.insets)
        }), for: .touchUpInside)

        let showAndDismissSnackbarButton = UIButton(configuration: .filled())
        showAndDismissSnackbarButton.setTitle("Show and dismiss Snackbar", for: .normal)
        showAndDismissSnackbarButton.addAction(
            .init(handler: {
                _ in
                self.snackbar.showAndDismiss(
                    in: self.view,
                    from: self.direction,
                    insets: self.insets,
                    autoDismissDelay: self.autoDismissDelay
                ) { isFinished in
                        print("Auto dismiss", isFinished)
                    }
            }),
            for: .touchUpInside
        )

        self.verticalStackView.addArrangedSubviews([showSnackbarButton, showAndDismissSnackbarButton])
    }
}
