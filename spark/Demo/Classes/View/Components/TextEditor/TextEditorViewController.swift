//
//  TextEditorViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 29.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class TextEditorViewController: UIViewController, UIGestureRecognizerDelegate {

    private lazy var textEditor: TextEditorUIView = {
        let view = TextEditorUIView(
            theme: SparkTheme.shared,
            intent: .neutral
        )
//        view.text = "It is a long established It is a long established"
//        view.isEditable = false
//        view.isSelectable = false
        view.isScrollEnabled = true
//        view.isReadOnly = true
        view.text = "It is a long established It is a long established It is a long established It is a long established It is a long established It is a long established It is a long established It is a long established It is a long established It is a long established"
        view.placeHolder = "It is a long established It is a long established It is a long established It is a long established It is a long established It is a long established It is a long established It is a long established It is a long established It is a long established"


        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TextEditor"

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewDidTapped))
        tap.delegate = self
        view.addGestureRecognizer(tap)

        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.textEditor)

        NSLayoutConstraint.activate([
            self.textEditor.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.textEditor.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.textEditor.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.textEditor.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    @objc private func viewDidTapped() {
        _ = self.textEditor.resignFirstResponder()
    }
}
