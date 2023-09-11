//
//  TextFieldUIViewController.swift
//  SparkCore
//
//  Created by louis.borlee on 11/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

class TextFieldUIViewController: UIViewController {

    private let textField = TextFieldUIView()

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.dismissKeyboard))
        toolbar.items = [UIBarButtonItem.flexibleSpace(), doneButton]
        toolbar.sizeToFit()
        return toolbar
    }()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        self.textField.layer.borderWidth = 1
        self.textField.layer.cornerRadius = 16
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.input.clearButtonMode = .always
        //        self.textField.input.inputAccessoryView = self.toolbar
        if let button = self.textField.input.value(forKeyPath: "_clearButton") as? UIButton {
            button.setImage(UIImage(systemName: "cross"), for: .normal)
            button.setImage(UIImage(systemName: "cross.fill"), for: .highlighted)
        }

        //        self.textField.input.leftView =

        view.addSubview(self.textField)

        NSLayoutConstraint.activate([
            self.textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.textField.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20)
        ])

        self.textField.rightIcon = UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")

        self.view = view
    }

    @objc
    private func dismissKeyboard() {
        //        self.textField.setRightIcon(icon: nil)
        self.textField.input.resignFirstResponder()
    }
}
