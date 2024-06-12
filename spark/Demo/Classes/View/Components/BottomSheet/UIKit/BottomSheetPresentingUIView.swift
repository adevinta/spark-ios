//
//  BottomSheetPresentingView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 16.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

final class BottomSheetPresentingUIView: UIView {

    // MARK: - UI Elements
    let presentSheetButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.borderedTinted()
        configuration.title = "Present Sheet"
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let presentBottomSheetButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.borderedTinted()
        configuration.title = "Present Sheet with Scroll View"
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        layout()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - SSUL

    private func setup() {
        addSubview(presentSheetButton)
        addSubview(presentBottomSheetButton)
    }

    private func layout() {
        presentSheetButton.translatesAutoresizingMaskIntoConstraints = false
        presentBottomSheetButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            presentSheetButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            presentSheetButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            presentBottomSheetButton.topAnchor.constraint(equalTo: presentSheetButton.bottomAnchor, constant: 48),
            presentBottomSheetButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
