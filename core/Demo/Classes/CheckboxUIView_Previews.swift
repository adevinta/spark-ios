//
//  CheckboxUIView_Previews.swift
//  SparkCoreDemo
//
//  Created by janniklas.freundt.ext on 21.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import SwiftUI

// MARK: - Preview

struct CheckboxUIView_Previews: PreviewProvider {

    struct ContainerView: View {
        let theme = SparkTheme.shared

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

// MARK: - SwiftUI-wrapper

struct CheckboxUIViewControllerBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = CheckboxViewController

    func makeUIViewController(context: Context) -> CheckboxViewController {
        return CheckboxViewController()
    }

    func updateUIViewController(_ uiViewController: CheckboxViewController, context: Context) {
    }
}

// MARK: - View Controller

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

    // MARK: - Methods

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
        let states = [SelectButtonState.enabled, .disabled, .success(message: "Success message"), .warning(message: "Warning message"), .error(message: "Error message")]
        for checkbox in checkboxes {
            checkbox.selectionState = selectionStates.randomElement() ?? .indeterminate
            checkbox.state = states.randomElement() ?? .disabled
        }
    }

    private func setUpView() {
        let view = self.contentView
        let theme = SparkTheme.shared

        var checkboxes: [CheckboxUIView] = []

        let shuffleButton = UIButton(type: .system)
        shuffleButton.setTitle("Shuffle", for: .normal)
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shuffleButton)

        shuffleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        shuffleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        shuffleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        shuffleButton.addTarget(self, action: #selector(self.actionShuffle(sender:)), for: .touchUpInside)

        let checkedImage = UIImage(systemName: "checkmark")!.withRenderingMode(.alwaysTemplate)

        let checkbox = CheckboxUIView(
            theme: theme,
            text: "Hello world!",
            checkedImage: checkedImage,
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
            theme: theme,
            text: "Second checkbox! This is a very very long descriptive text.",
            checkedImage: checkedImage,
            state: .disabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        view.addSubview(checkbox2)
        checkboxes.append(checkbox2)


        let errorCheckbox = CheckboxUIView(
            theme: theme,
            text: "Error checkbox",
            checkedImage: checkedImage,
            state: .error(message: "Error message"),
            selectionState: .indeterminate,
            checkboxPosition: .left
        )
        view.addSubview(errorCheckbox)
        checkboxes.append(errorCheckbox)

        let successCheckbox = CheckboxUIView(
            theme: theme,
            text: "Right checkbox",
            checkedImage: checkedImage,
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

// MARK: - Demo delegate

extension CheckboxViewController: CheckboxUIViewDelegate {
    func checkbox(_ checkbox: SparkCore.CheckboxUIView, didChangeSelection state: SparkCore.CheckboxSelectionState) {
        print("checkbox", checkbox.text, "did switch to", state)
    }
}
