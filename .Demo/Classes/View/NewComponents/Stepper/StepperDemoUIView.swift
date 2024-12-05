//
//  StepperDemoUIView.swift
//  SparkDemo
//
//  Created by louis.borlee on 03/12/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
@_spi(SI_SPI) import SparkCommon
import SparkStepper

final class StepperDemoUIView: UIViewController {

    private let scrollView = UIScrollView()
    private let verticalStackView = UIStackView()
    private lazy var horizontalStackView = UIStackView(arrangedSubviews: [self.leftPaddingView, self.rightPaddingView])

    private var theme: any Theme { self.themes.current }
    private var themes: Themes = .spark {
        didSet {
            self.stepper.theme = self.theme
        }
    }

    private var leftPaddingView = UIView()
    private var rightPaddingView = UIView()

    private lazy var stepper = StepperUIControl<Float>(
        theme: self.theme
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupView()
    }

    private func setupView() {
        self.setupScrollView()
//        self.setupConfiguration()
        self.setupHorizontalStackView()
//        self.setupComponent()
        self.horizontalStackView.insertArrangedSubview(self.stepper, at: 1)
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

    private func setupHorizontalStackView() {
        self.horizontalStackView.spacing = 12
        NSLayoutConstraint.activate([
            self.leftPaddingView.widthAnchor.constraint(equalToConstant: 75),
            self.rightPaddingView.widthAnchor.constraint(equalToConstant: 75)
        ])

        self.leftPaddingView.backgroundColor = .systemBlue.withAlphaComponent(0.3)
        self.leftPaddingView.setCornerRadius(8)
        self.rightPaddingView.backgroundColor = .systemBlue.withAlphaComponent(0.3)
        self.rightPaddingView.setCornerRadius(8)

        self.leftPaddingView.isHidden = true
        self.rightPaddingView.isHidden = true

        self.verticalStackView.addArrangedSubview(self.horizontalStackView)
    }

}
