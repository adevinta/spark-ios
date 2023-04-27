//
//  CheckboxGroupViewController.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 21.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import Spark
import SparkCore
import SwiftUI

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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private var contentView = UIView()

    private lazy var shuffleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Shuffle", for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.actionShuffle(sender:)), for: .touchUpInside)
        return button
    }()

    private lazy var changeLayoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Layout", for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.actionChangeLayout(sender:)), for: .touchUpInside)
        return button
    }()

    private lazy var changePositionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Position", for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.actionChangePosition(sender:)), for: .touchUpInside)
        return button
    }()

    private lazy var addItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Item", for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.actionAddItem(sender:)), for: .touchUpInside)
        return button
    }()

    private lazy var selectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Selection:"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var checkboxGroup: CheckboxGroupUIView?

    private var checkboxGroupLayout: CheckboxGroupLayout = .vertical

    override func viewDidLoad() {
        super.viewDidLoad()

        let views = [self.selectionLabel, self.shuffleButton, self.changeLayoutButton, self.changePositionButton, self.addItemButton]
        var previousView: UIView?
        for aView in views {
            view.addSubview(aView)

            aView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            aView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
            if let previousView = previousView {
                aView.topAnchor.constraint(equalTo: previousView.bottomAnchor).isActive = true
            } else {
                aView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }
            previousView = aView
        }

        guard let lastView = views.last else { return }

        view.addSubview(self.scrollView)
        self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        self.setUpScrollContentView()
    }

    private func setUpScrollContentView() {
        self.checkboxGroup?.removeFromSuperview()
        self.contentView.removeFromSuperview()

        self.contentView = UIView()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.contentView)

        switch checkboxGroupLayout {
        case .vertical:
            self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        case .horizontal:
            self.contentView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor).isActive = true
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor).isActive = true
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        }

        self.setUpCheckboxGroupView()
        self.updateSelection()
    }

    private func setUpCheckboxGroupView() {
        let view = self.contentView
        let theming = SparkTheme.shared

        let groupView = CheckboxGroupUIView(
            title: "Hello world!",
            items: .init(
                get: { [weak self] in
                    self?.items ?? []
                },
                set: { [weak self] in
                    self?.items = $0
                }
            ),
            layout: self.checkboxGroupLayout,
            checkboxPosition: .left,
            theming: theming,
            accessibilityIdentifierPrefix: "abc"
        )
        self.checkboxGroup = groupView
        groupView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(groupView)

        let spacing: CGFloat = self.checkboxGroupLayout == .vertical ? 0 : 16
        groupView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing).isActive = true
        groupView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        groupView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        groupView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    var selectedItems: [any CheckboxGroupItemProtocol] {
        self.items.filter { $0.selectionState == .selected }
    }

    var selectedItemsText: String {
        self.selectedItems.map { $0.title }.joined(separator: ", ")
    }

    private var items: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItem(title: "Entry", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
        CheckboxGroupItem(title: "Entry 2", id: "2", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 3", id: "3", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 4", id: "4", selectionState: .unselected, state: .success(message: "Great!")),
        CheckboxGroupItem(title: "Entry 5", id: "5", selectionState: .unselected, state: .disabled),
        CheckboxGroupItem(title: "Entry 6", id: "6", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 7", id: "7", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 8", id: "8", selectionState: .unselected)
    ] {
        didSet {
            self.updateSelection()
        }
    }

    private func updateSelection() {
        self.selectionLabel.text = "Selection: " + self.selectedItemsText
    }

    @objc private func actionAddItem(sender: UIButton) {
        let identifier = "\(self.items.count + 1)"
        let newItem = CheckboxGroupItem(title: "Entry \(identifier)", id: identifier, selectionState: .unselected)
        self.items.append(newItem)
        self.checkboxGroup?.update()
    }

    @objc private func actionChangePosition(sender: UIButton) {
        self.checkboxGroup?.checkboxPosition = self.checkboxGroup?.checkboxPosition == .right ? .left : .right
    }

    @objc private func actionChangeLayout(sender: UIButton) {
        self.checkboxGroupLayout = checkboxGroupLayout == .vertical ? .horizontal : .vertical

        self.setUpScrollContentView()
    }

    @objc private func actionShuffle(sender: UIButton) {
        let selectionStates = [CheckboxSelectionState.indeterminate, .selected, .unselected]
        let states = [SelectButtonState.enabled, .disabled, .success(message: "Success message"), .warning(message: "Warning emssage"), .error(message: "Error message")]
        for index in 0..<items.count {
            var item = items[index]
            if let randomState = states.randomElement() {
                item.state = randomState
            }

            if let randomSelectionState = selectionStates.randomElement() {
                item.selectionState = randomSelectionState
            }
            self.items[index] = item
        }
        self.checkboxGroup?.update()
    }
}
