//
//  TestAnimationViewController.swift
//  SparkDemo
//
//  Created by robin.lemaire on 18/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
@_spi(SI_SPI) import SparkCommon
import SparkCore

final class TestAnimationViewController: UIViewController {

    // MARK: - Properties

    private lazy var buttonView: ButtonUIView = {
        let view = ButtonUIView(
            theme: SparkTheme.shared,
            intent: .main,
            variant: .filled,
            size: .medium,
            shape: .rounded,
            alignment: .leadingImage
        )
        view.setImage(UIImage(systemName: "bell"), for: .normal)
        view.setTitle("My Text", for: .normal)
        return view
    }()

    // MARK: - Initializer

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("LOGROB DEINIT VC")
    }

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate( // TODO: changed to animate
            withType: .bell,
            on: self.buttonView.imageView,
            delay: 2,
            repeat: true,
            completion: { _ in
                print("LOGROB Animation finished")
            })

        view.backgroundColor = .systemBackground

        self.view.addSubview(self.buttonView)
        self.buttonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.buttonView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            self.buttonView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.buttonView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
        ])
    }
}
