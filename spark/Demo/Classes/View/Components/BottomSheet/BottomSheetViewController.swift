//
//  BottomSheetViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 05.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

final class BottomSheetViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(self.didButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Bottom Sheet"
        self.view.backgroundColor = .systemBackground

        self.setupView()
    }

    private func setupView() {
        self.view.addSubview(self.button)

        NSLayoutConstraint.activate([
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    @objc func didButtonTapped(_: UIButton) {
        let controller = ContainerUIViewController()
        let navigationController = UINavigationController(rootViewController: controller)

        if let sheet = navigationController.sheetPresentationController {
            sheet.prefersGrabberVisible = true

//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//            sheet.preferredCornerRadius = 50

            if #available(iOS 16, *) {
                let smallIdentifier = UISheetPresentationController.Detent.Identifier("small")
                let detent = UISheetPresentationController.Detent.custom(identifier: smallIdentifier) { context in
                    return 500
                }
                sheet.detents = [detent]
//                sheet.largestUndimmedDetentIdentifier = smallIdentifier
            } else {
                sheet.detents = [.medium()]
            }
            self.navigationController?.present(navigationController, animated: true)
        }
    }
}

// MARK: - Builder
extension BottomSheetViewController {

    static func build() -> BottomSheetViewController {
        return BottomSheetViewController()
    }
}

// MARK: - ContainerUIViewController
final class ContainerUIViewController: UIViewController {

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scrollView: UIView = {
        let view = UIScrollView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.modalPresentationStyle = .pageSheet

        self.setupView()
    }

    private func setupView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.backgroundView)

        NSLayoutConstraint.stickEdges(from: self.backgroundView, to: self.scrollView)

        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),

            self.backgroundView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
}
