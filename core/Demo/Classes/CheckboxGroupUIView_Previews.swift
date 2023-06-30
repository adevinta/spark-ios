//
//  CheckboxGroupUIView_Previews.swift
//  SparkCoreDemo
//
//  Created by janniklas.freundt.ext on 24.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import SwiftUI

// MARK: - Previews

struct CheckboxGroupUIView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxGroupUIViewControllerBridge()
            .environment(\.sizeCategory, .extraSmall)
            .previewDisplayName("Extra small")

        CheckboxGroupUIViewControllerBridge()
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            .previewDisplayName("Extra large")
    }
}

// MARK: - SwiftUI-wrapper

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

// MARK: - Demo View Controller

final class CheckboxGroupViewController: UIViewController {

    // MARK: - Properties

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

    var selectedItems: [any CheckboxGroupItemProtocol] {
        self.items.filter { $0.selectionState == .selected }
    }

    var selectedItemsText: String {
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

    // MARK: - Methods

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

        let scrollView = self.scrollView
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        self.setUpScrollContentView()
    }

    private func setUpScrollContentView() {
        let scrollView = self.scrollView
        self.checkboxGroup?.removeFromSuperview()
        self.contentView.removeFromSuperview()

        let contentView = UIView()
        self.contentView = contentView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        switch checkboxGroupLayout {
        case .vertical:
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        case .horizontal:
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        }

        self.setUpCheckboxGroupView()
        self.updateSelection()
    }

    private func setUpCheckboxGroupView() {
        let view = self.contentView
        let theme = SparkTheme.shared

        let checkedImage = UIImage(systemName: "checkmark")!.withRenderingMode(.alwaysTemplate)

        let groupView = CheckboxGroupUIView(
            checkedImage: checkedImage,
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
            theme: theme,
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

    private func updateSelection() {
        self.selectionLabel.text = "Selection: " + self.selectedItemsText
    }

    // MARK: - Actions

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
        self.checkboxGroupLayout = self.checkboxGroupLayout == .vertical ? .horizontal : .vertical

        self.setUpScrollContentView()
    }

    @objc private func actionShuffle(sender: UIButton) {
        let selectionStates = [CheckboxSelectionState.indeterminate, .selected, .unselected]
        let states = [SelectButtonState.enabled, .disabled, .success(message: "Success message"), .warning(message: "Warning message"), .error(message: "Error message")]
        for index in 0..<self.items.count {
            var item = self.items[index]
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
