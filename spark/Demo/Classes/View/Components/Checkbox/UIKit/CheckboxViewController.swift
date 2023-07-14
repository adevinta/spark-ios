//
//  CheckboxUIView.swift
//  SparkCoreDemo
//
//  Created by janniklas.freundt.ext on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI

// swiftlint: disable no_debugging_method

// MARK: - SwiftUI-wrapper

struct CheckboxUIViewControllerBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = CheckboxViewController

    func makeUIViewController(context: Context) -> CheckboxViewController {
        let vc = CheckboxViewController()
        return vc
    }

    func updateUIViewController(_ uiViewController: CheckboxViewController, context: Context) {
    }
}

// MARK: - Demo View Controller

final class CheckboxViewController: UIViewController {

    // MARK: - Properties

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private var checkboxes: [CheckboxUIView] = []

    private var checkboxValue1: CheckboxSelectionState = .unselected
    private var checkboxValue2: CheckboxSelectionState = .selected
    private var checkboxValue3: CheckboxSelectionState = .indeterminate
    private var checkboxValue4: CheckboxSelectionState = .selected

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    private var cancellables = Set<AnyCancellable>()

    private var attributedCheckboxLabel: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "This text is ")
        let boldString = NSAttributedString(
            string: "bold",
            attributes: [
                .font: self.theme.typography.body1Highlight.uiFont,
                .foregroundColor: UIColor.red
            ]
        )
        attributedString.append(boldString)
        return attributedString
    }

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(self.scrollView)
        self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        self.scrollView.addSubview(self.contentView)
        self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true

        self.setUpView()
        self.subscribe()
    }

    private func subscribe() {
        self.themePublisher.$theme
            .sink { [weak self] theme in
                guard let self else { return }

                for checkbox in self.checkboxes {
                    checkbox.theme = theme
                }
            }
            .store(in: &self.cancellables)
    }

    @objc private func actionShuffle(sender: UIButton) {
        let selectionStates = [CheckboxSelectionState.indeterminate, .selected, .unselected]
        let states = [SelectButtonState.enabled, .disabled, .success(message: "Success message"), .warning(message: "Warning message"), .error(message: "Error message")]
        for checkbox in self.checkboxes {
            checkbox.selectionState = selectionStates.randomElement() ?? .indeterminate
            checkbox.state = states.randomElement() ?? .disabled
        }
    }

    private func setUpView() {
        let view = self.contentView
        let theme = self.theme

        var checkboxes: [CheckboxUIView] = []

        let shuffleButton = UIButton(type: .system)
        shuffleButton.setTitle("Shuffle", for: .normal)
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shuffleButton)

        shuffleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        shuffleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        shuffleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        shuffleButton.addTarget(self, action: #selector(self.actionShuffle(sender:)), for: .touchUpInside)

        let image = DemoIconography.shared.checkmark
        let checkbox = CheckboxUIView(
            theme: theme,
            text: "Hello world!",
            checkedImage: image,
            state: .enabled,
            selectionState: self.checkboxValue1,
            checkboxPosition: .left
        )

        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.publisher.sink { [weak self] in
            self?.checkboxValue1 = $0
        }.store(in: &self.cancellables)

        view.addSubview(checkbox)
        checkboxes.append(checkbox)

        let checkbox2 = CheckboxUIView(
            theme: theme,
            text: "Second checkbox! This is a very very long descriptive text.",
            checkedImage: image,
            state: .disabled,
            selectionState: self.checkboxValue2,
            checkboxPosition: .left
        )
        checkbox2.translatesAutoresizingMaskIntoConstraints = false
        checkbox2.publisher.sink { [weak self] in
            self?.checkboxValue2 = $0
        }.store(in: &self.cancellables)
        view.addSubview(checkbox2)
        checkboxes.append(checkbox2)


        let errorCheckbox = CheckboxUIView(
            theme: theme,
            text: "Error checkbox",
            checkedImage: image,
            state: .error(message: "Error message"),
            selectionState: self.checkboxValue3,
            checkboxPosition: .left
        )
        errorCheckbox.translatesAutoresizingMaskIntoConstraints = false
        errorCheckbox.publisher.sink { [weak self] in
            self?.checkboxValue3 = $0
        }.store(in: &self.cancellables)

        view.addSubview(errorCheckbox)
        checkboxes.append(errorCheckbox)

        let successCheckbox = CheckboxUIView(
            theme: theme,
            text: "Right checkbox",
            checkedImage: image,
            state: .success(message: "Success message"),
            selectionState: self.checkboxValue4,
            checkboxPosition: .right
        )
        successCheckbox.translatesAutoresizingMaskIntoConstraints = false
        successCheckbox.publisher.sink { [weak self] in
            self?.checkboxValue4 = $0
        }.store(in: &self.cancellables)

        view.addSubview(successCheckbox)
        checkboxes.append(successCheckbox)

        let attributedCheckbox = CheckboxUIView(
            theme: theme,
            text: "Right checkbox",
            checkedImage: image,
            state: .success(message: "Success message"),
            selectionState: self.checkboxValue4,
            checkboxPosition: .right
        )
        attributedCheckbox.attributedText = self.attributedCheckboxLabel
        attributedCheckbox.publisher.sink { [weak self] in
            self?.checkboxValue4 = $0
        }.store(in: &self.cancellables)

        view.addSubview(attributedCheckbox)
        checkboxes.append(attributedCheckbox)

        var previousCheckbox: CheckboxUIView?
        for checkbox in checkboxes {
            checkbox.delegate = self

            checkbox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            checkbox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true

            if let previousCheckbox = previousCheckbox {
                checkbox.topAnchor.constraint(equalTo: previousCheckbox.safeAreaLayoutGuide.bottomAnchor, constant: 16).isActive = true
            } else {
                checkbox.topAnchor.constraint(equalTo: shuffleButton.bottomAnchor, constant: 16).isActive = true
            }

            if checkbox == checkboxes.last {
                checkbox.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

            }

            previousCheckbox = checkbox
        }

        self.checkboxes = checkboxes
    }
}

// MARK: - Demo delegate

extension CheckboxViewController: CheckboxUIViewDelegate {
    func checkbox(_ checkbox: SparkCore.CheckboxUIView, didChangeSelection state: SparkCore.CheckboxSelectionState) {
    }
}
