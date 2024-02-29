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

        if let sheet = controller.sheetPresentationController {
            sheet.prefersGrabberVisible = false
            sheet.preferredCornerRadius = 0
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false


            if #available(iOS 16, *) {
                let customIdentifier = UISheetPresentationController.Detent.Identifier("custom")
                let detent = UISheetPresentationController.Detent.custom(identifier: customIdentifier) { context in
                    return controller.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
                }
                sheet.detents = [detent]
//                sheet.largestUndimmedDetentIdentifier = smallIdentifier
            } else {
                sheet.detents = [.medium()]
            }
            self.navigationController?.present(controller, animated: true)
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
        view.backgroundColor = UIColor.yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.modalPresentationStyle = .pageSheet

        self.setupView()
    }

    private func setupView() {
        self.view.addSubview(self.backgroundView)
        self.backgroundView.addSubview(label)

        NSLayoutConstraint.activate([
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

            self.label.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 20),
            self.label.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: -20),
            self.label.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40)
        ])
    }
}
