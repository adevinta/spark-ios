//
//  CheckboxUIView.swift
//  SparkCoreDemo
//
//  Created by janniklas.freundt.ext on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import Spark
import SparkCore
import SwiftUI

struct CheckboxUIViewControllerBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = CheckboxViewController

    func makeUIViewController(context: Context) -> CheckboxViewController {
        let vc = CheckboxViewController()
        return vc
    }

    func updateUIViewController(_ uiViewController: CheckboxViewController, context: Context) {
    }
}

final class CheckboxViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private var checkboxes: [CheckboxUIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = .yellow
        scrollView.frame = view.bounds
        view.addSubview(scrollView)

        scrollView.addSubview(contentView)
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        setUpView()
    }

    @objc private func actionShuffle(sender: UIButton) {
        let selectionStates = [CheckboxSelectionState.indeterminate, .selected, .unselected]
        let states = [SelectButtonState.enabled, .disabled, .success(message: "Success message"), .warning(message: "Warning emssage"), .error(message: "Error message")]
        for checkbox in checkboxes {
            checkbox.selectionState = selectionStates.randomElement() ?? .indeterminate
            checkbox.state = states.randomElement() ?? .disabled
        }
    }

    private func setUpView() {
        let view = contentView
        let theming = CheckboxTheming.init(
            theme: SparkTheme.shared
        )

        var checkboxes: [CheckboxUIView] = []

        let shuffleButton = UIButton(type: .system)
        shuffleButton.setTitle("Shuffle", for: .normal)
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shuffleButton)

        shuffleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        shuffleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        shuffleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        shuffleButton.addTarget(self, action: #selector(actionShuffle(sender:)), for: .touchUpInside)

        let checkbox = CheckboxUIView(
            theming: theming,
            state: .enabled,
            selectionState: .unselected,
            checkboxPosition: .left,
            selectionStateHandler: {
                print("selectionStateHandler", $0)
            }
        )
        checkbox.text = "Hello world!"
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkbox)
        checkboxes.append(checkbox)

        let checkbox2 = CheckboxUIView(
            theming: theming,
            state: .disabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        checkbox2.text = "Second checkbox! This is a very very long descriptive text."
        checkbox2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkbox2)
        checkboxes.append(checkbox2)


        let errorCheckbox = CheckboxUIView(
            theming: theming,
            state: .error(message: "Error message"),
            selectionState: .indeterminate,
            checkboxPosition: .left
        )
        errorCheckbox.text = "Error checkbox"
        errorCheckbox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorCheckbox)
        checkboxes.append(errorCheckbox)

        let successCheckbox = CheckboxUIView(
            theming: theming,
            state: .success(message: "Success message"),
            selectionState: .selected,
            checkboxPosition: .right
        )
        successCheckbox.text = "Right checkbox"
        successCheckbox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(successCheckbox)
        checkboxes.append(successCheckbox)

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

extension CheckboxViewController: CheckboxUIViewDelegate {
    func checkbox(_ checkbox: SparkCore.CheckboxUIView, didChangeSelection state: SparkCore.CheckboxSelectionState) {
        print("checkbox", checkbox.text ?? "", "did switch to", state)
    }
}

struct CheckboxGroupUIViewControllerBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = CheckboxGroupViewController

    func makeUIViewController(context: Context) -> CheckboxGroupViewController {
        let vc = CheckboxGroupViewController()
        return vc
    }

    func updateUIViewController(_ uiViewController: CheckboxGroupViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

final class CheckboxGroupViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = .yellow
        scrollView.frame = view.bounds
        view.addSubview(scrollView)

        scrollView.backgroundColor = .orange
        scrollView.addSubview(contentView)
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        setUpView()
    }


    @State private var items: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItem(title: "Entry", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
        CheckboxGroupItem(title: "Entry 2", id: "2", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 3", id: "3", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 4", id: "4", selectionState: .unselected, state: .success(message: "Great!")),
        CheckboxGroupItem(title: "Entry 5", id: "5", selectionState: .unselected, state: .disabled),
        CheckboxGroupItem(title: "Entry 6", id: "6", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 7", id: "7", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 8", id: "8", selectionState: .unselected)
    ]

    private func setUpView() {
        let view = contentView
        let theming = CheckboxTheming.init(
            theme: SparkTheme.shared
        )

        view.backgroundColor = .green

        let groupView = CheckboxGroupUIView(
            items: $items,
            checkboxPosition: .left,
            theming: theming,
            accessibilityIdentifierPrefix: "abc"
        )
        groupView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(groupView)
        groupView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        groupView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        groupView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        groupView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

/*
        var checkboxes: [CheckboxUIView] = []

        let checkbox = CheckboxUIView(
            theming: theming,
            state: .enabled,
            selectionState: .unselected,
            checkboxPosition: .left,
            selectionStateHandler: {
                print("selectionStateHandler", $0)
            }
        )
        checkbox.text = "Hello world!"
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkbox)
        checkboxes.append(checkbox)

        let checkbox2 = CheckboxUIView(
            theming: theming,
            state: .disabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        checkbox2.text = "Second checkbox! This is a very very long descriptive text."
        checkbox2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkbox2)
        checkboxes.append(checkbox2)


        let errorCheckbox = CheckboxUIView(
            theming: theming,
            state: .error(message: "Error message"),
            selectionState: .indeterminate,
            checkboxPosition: .left
        )
        errorCheckbox.text = "Error checkbox"
        errorCheckbox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorCheckbox)
        checkboxes.append(errorCheckbox)

        let successCheckbox = CheckboxUIView(
            theming: theming,
            state: .success(message: "Success message"),
            selectionState: .selected,
            checkboxPosition: .right
        )
        successCheckbox.text = "Right checkbox"
        successCheckbox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(successCheckbox)
        checkboxes.append(successCheckbox)

        var previousCheckbox: CheckboxUIView?
        for checkbox in checkboxes {
            checkbox.delegate = self

            checkbox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            checkbox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true

            if let previousCheckbox = previousCheckbox {
                checkbox.topAnchor.constraint(equalTo: previousCheckbox.safeAreaLayoutGuide.bottomAnchor, constant: 16).isActive = true
            } else {
                checkbox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }

            if checkbox == checkboxes.last {
                checkbox.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

            }

            previousCheckbox = checkbox
        }*/
    }
}
