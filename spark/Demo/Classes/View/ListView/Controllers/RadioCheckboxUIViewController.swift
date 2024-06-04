//
//  RadioCheckboxUIViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 22.03.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine
import Spark
@_spi(SI_SPI) import SparkCommon

final class RadioCheckboxUIViewController: UIViewController {

    private let theme = SparkThemePublisher.shared.theme
    private var cancellables = Set<AnyCancellable>()

    private lazy var alignment: CheckboxUIView = {
        let view = CheckboxUIView(
            theme: self.theme,
            text: "Alignment: Click to change postion.",
            checkedImage: DemoIconography.shared.checkmark.uiImage,
            isEnabled: true,
            selectionState: .selected,
            alignment: .left
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var checkboxGroup: CheckboxGroupUIView = {
        var items = [
            CheckboxGroupItemDefault(title: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", id: "1", selectionState: .selected, isEnabled: true),
            CheckboxGroupItemDefault(title: "Hello World", id: "2", selectionState: .selected, isEnabled: true)
        ]
        let view = CheckboxGroupUIView(
            checkedImage: DemoIconography.shared.checkmark.uiImage,
            items: items,
            alignment: alignment.isSelected ? CheckboxAlignment.left : CheckboxAlignment.right,
            theme: self.theme,
            intent: .main,
            accessibilityIdentifierPrefix: "Checkbox"
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var radioButtonGroup: RadioButtonUIGroupView = {
        var items = [
            RadioButtonUIItem(id: 0, label: "Hello World"),
            RadioButtonUIItem(id: 1, label: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
        ]
        let view = RadioButtonUIGroupView(
            theme: self.theme,
            intent: .main,
            selectedID: 0,
            items: items,
            labelAlignment: alignment.isSelected ? RadioButtonLabelAlignment.trailing : RadioButtonLabelAlignment.leading,
            groupLayout: .vertical
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Radio Checkbox UIKit"

        self.setupView()
        self.subscribe()
    }

    private func setupView() {
        self.view.backgroundColor = UIColor.systemBackground

        self.view.addSubview(alignment)
        self.view.addSubview(lineView)
        self.view.addSubview(checkboxGroup)
        self.view.addSubview(radioButtonGroup)

        NSLayoutConstraint.activate([

            self.alignment.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.alignment.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.alignment.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),

            self.lineView.topAnchor.constraint(equalTo: self.alignment.bottomAnchor, constant: 32),
            self.lineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.lineView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.lineView.heightAnchor.constraint(equalToConstant: 1),

            self.checkboxGroup.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: 32),
            self.checkboxGroup.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.checkboxGroup.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),

            self.radioButtonGroup.topAnchor.constraint(equalTo: self.checkboxGroup.bottomAnchor, constant: 16),
            self.radioButtonGroup.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.radioButtonGroup.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }

    private func subscribe() {
        self.alignment.publisher.subscribe(in: &self.cancellables) { [weak self] isSelected in
            self?.radioButtonGroup.labelAlignment = isSelected == .selected ? RadioButtonLabelAlignment.trailing : RadioButtonLabelAlignment.leading
            self?.checkboxGroup.alignment = isSelected == .selected ? CheckboxAlignment.left : CheckboxAlignment.right
        }
    }
}
