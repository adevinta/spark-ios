//
//  OptionalEnumSelectorView.swift
//  SparkDemo
//
//  Created by louis.borlee on 20/09/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

final class OptionalEnumSelectorView<Enum>: UIView, ObservableObject where Enum: CaseIterable & Hashable {

    private let title: String
    @Published var currentCase: Enum?

    private let button = UIButton()

    private weak var presenter: UIViewController?

    init(title: String, currentCase: Enum?, presenter: UIViewController?) {
        self.title = title
        self.currentCase = currentCase
        self.presenter = presenter
        super.init(frame: .zero)

        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let label = UILabel()
        label.text = self.title
        label.font = SparkTheme.shared.typography.subhead.uiFont
        label.adjustsFontForContentSizeCategory = true

        self.button.setTitle(self.currentCase?.name ?? "Default", for: .normal)
        self.button.configuration = .plain()

        self.button.addAction(.init(handler: { [weak self] _ in
            guard let self else { return }
            let actionSheetBuilder = EnumSelectorActionSheetBuilder<Enum>(
                title: nil)
            let alertController = actionSheetBuilder.build() { [weak self] newCase in
                guard let self else { return }
                self.currentCase = newCase
                self.button.setTitle(newCase?.name ?? "Default", for: .normal)
            }
            alertController.addAction(
                .init(
                    title: "Dismiss",
                    style: .cancel,
                    handler: { _ in
                        alertController.dismiss(animated: true)
                    }
                )
            )
            self.presenter?.present(alertController, animated: true)
        }), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [label, self.button])
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
