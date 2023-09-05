//
//  CheckboxGroupViewController.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 21.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI

// MARK: - Demo View Controller

final class CheckboxGroupViewController: UIViewController {

    // MARK: - Properties

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

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

    private var checkboxGroupLayout: CheckboxGroupLayout = .horizontal

    private var selectedItems: [any CheckboxGroupItemProtocol] {
        self.items.filter { $0.selectionState == .selected }
    }

    private var selectedItemsText: String {
        self.selectedItems.map { $0.title ?? "" }.joined(separator: ", ")
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

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Checkbox Group"

        self.subscribe()
        self.setupView()
    }

    private func subscribe() {
        self.themePublisher.$theme
            .sink { [weak self] theme in
                self?.checkboxGroup?.theme = theme
            }
            .store(in: &self.cancellables)
    }

    private func setupView() {
        let views = [
            self.selectionLabel,
            self.shuffleButton,
            self.changeLayoutButton,
            self.changePositionButton,
            self.addItemButton
        ]
        views.enumerated().forEach { i, item in
            view.addSubview(item)

            NSLayoutConstraint.activate([
                item.topAnchor.constraint(equalTo: i == 0 ? self.view.safeAreaLayoutGuide.topAnchor : views[i - 1].bottomAnchor),
                item.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                item.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)

            ])
        }
        self.setUpScrollContentView()

        self.view.addSubview(self.scrollView)
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.addItemButton.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setUpScrollContentView() {
        self.checkboxGroup?.removeFromSuperview()
        self.setUpCheckboxGroupView()
        self.updateSelection()
    }

    private func setUpCheckboxGroupView() {
        let checkedImage = DemoIconography.shared.checkmark

        let groupView = CheckboxGroupUIView(
            title: "Checkbox-group title (UIKit)",
            checkedImage: checkedImage,
            items: self.items,
            layout: self.checkboxGroupLayout,
            checkboxPosition: .left,
            theme: theme,
            accessibilityIdentifierPrefix: "abc"
        )
        groupView.translatesAutoresizingMaskIntoConstraints = false
        groupView.publisher.sink { [weak self] in
            self?.items = $0
        }
        .store(in: &self.cancellables)

        self.checkboxGroup = groupView
        self.scrollView.addSubview(groupView)

        let spacing: CGFloat = self.checkboxGroupLayout == .vertical ? 0 : 16
        NSLayoutConstraint.activate([
            groupView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 8),
            groupView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: spacing),

            self.checkboxGroupLayout == .vertical ?
            groupView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor) :
            groupView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor),

            self.checkboxGroupLayout == .vertical ?
            groupView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor) :
            groupView.trailingAnchor.constraint(lessThanOrEqualTo: self.scrollView.trailingAnchor),

            groupView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])
    }

    private func updateSelection() {
        self.selectionLabel.text = "Selection: " + self.selectedItemsText
    }

    private func attributedCheckboxLabel(for value: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            string: "Entry ",
            attributes: [
                .font: self.theme.typography.body1.uiFont,
                .foregroundColor: UIColor.black
            ]
        )
        let boldString = NSAttributedString(
            string: value,
            attributes: [
                .font: self.theme.typography.body1Highlight.uiFont,
                .foregroundColor: UIColor.red
            ]
        )
        attributedString.append(boldString)
        return attributedString
    }

    // MARK: - Actions

    @objc private func actionAddItem(sender: UIButton) {
        let identifier = "\(self.items.count + 1)"
        let newItem = CheckboxGroupItem(
            attributedTitle: self.attributedCheckboxLabel(for: identifier),
            id: identifier,
            selectionState: .unselected
        )
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
        let states = [SelectButtonState.enabled, .disabled, .accent, .basic, .success(message: "Success message"), .warning(message: "Warning message"), .error(message: "Error message")]
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
