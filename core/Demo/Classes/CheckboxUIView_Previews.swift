//
//  CheckboxUIView_Previews.swift
//  SparkCoreDemo
//
//  Created by janniklas.freundt.ext on 21.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct CheckboxUIView_Previews: PreviewProvider {

    struct ContainerView: View {
        let theming = SparkTheme.shared

        @State private var selection1: CheckboxSelectionState = .selected
        @State private var selection2: CheckboxSelectionState = .unselected
        @State private var selection3: CheckboxSelectionState = .indeterminate

        var body: some View {
            CheckboxUIViewControllerBridge()
                .environment(\.sizeCategory, .extraSmall)
                .previewDisplayName("Extra small")

            CheckboxUIViewControllerBridge()
                .environment(\.sizeCategory, .medium)
                .previewDisplayName("Medium")

            CheckboxUIViewControllerBridge()
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDisplayName("Extra large")
        }

    }

    static var previews: some View {
        ContainerView()
    }
}

struct CheckboxUIViewControllerBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = CheckboxViewController

    func makeUIViewController(context: Context) -> CheckboxViewController {
        return CheckboxViewController()
    }

    func updateUIViewController(_ uiViewController: CheckboxViewController, context: Context) {
    }
}

final class CheckboxViewController: UIViewController {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        let scrollView = self.scrollView
        let contentView = self.contentView
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

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
        let view = self.contentView
        let theming = SparkTheme.shared

        var checkboxes: [CheckboxUIView] = []

        let shuffleButton = UIButton(type: .system)
        shuffleButton.setTitle("Shuffle", for: .normal)
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shuffleButton)

        shuffleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        shuffleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        shuffleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        shuffleButton.addTarget(self, action: #selector(self.actionShuffle(sender:)), for: .touchUpInside)

        let checkbox = CheckboxUIView(
            theming: theming,
            text: "Hello world!",
            state: .enabled,
            selectionState: .unselected,
            checkboxPosition: .left,
            selectionStateHandler: {
                print("selectionStateHandler", $0)
            }
        )
        view.addSubview(checkbox)
        checkboxes.append(checkbox)

        let checkbox2 = CheckboxUIView(
            theming: theming,
            text: "Second checkbox! This is a very very long descriptive text.",
            state: .disabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        view.addSubview(checkbox2)
        checkboxes.append(checkbox2)


        let errorCheckbox = CheckboxUIView(
            theming: theming,
            text: "Error checkbox",
            state: .error(message: "Error message"),
            selectionState: .indeterminate,
            checkboxPosition: .left
        )
        view.addSubview(errorCheckbox)
        checkboxes.append(errorCheckbox)

        let successCheckbox = CheckboxUIView(
            theming: theming,
            text: "Right checkbox",
            state: .success(message: "Success message"),
            selectionState: .selected,
            checkboxPosition: .right
        )
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
        print("checkbox", checkbox.text, "did switch to", state)
    }
}
