//
//  RadioButtonUIKitGroup.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 21.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI

// MARK: SwiftUI Representable
struct RadioButtonUIGroup: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RadioButtonUIGroupViewController {
        return RadioButtonUIGroupViewController()
    }

    func updateUIViewController(_ uiViewController: RadioButtonUIGroupViewController, context: Context) { }
}

final class RadioButtonUIGroupViewController: UIViewController {

    // MARK: - Constant definitions

    private enum Constants {
        static let width: CGFloat = 40
        static let padding: CGFloat = 20
    }

    // MARK: - Properies

    private var backingSelectedID: String = "1"
    private var subscriptions = Set<AnyCancellable>()

    private var label: String {
        "Selected Value \(self.backingSelectedID)"
    }

    private lazy var stateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(self.radioButtonGroupView.state.description, for: .normal)
        button.addTarget(self, action: #selector(promptForState), for: .touchUpInside)
        return button
    }()

    private lazy var shuffleButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Shuffle", for: .normal)
        button.addTarget(self, action: #selector(reshuffleItems), for: .touchUpInside)
        return button
    }()

    private lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Remove Item", for: .normal)
        button.addTarget(self, action: #selector(removeRandomItem), for: .touchUpInside)
        return button
    }()

    private lazy var radioButtonGroupView: RadioButtonUIGroupView = {
        let groupView = RadioButtonUIGroupView(
            theme: self.theme,
            title: "Radio Button Group (UIKit)",
            selectedID: self.backingSelectedID,
            items: self.radioButtonItems,
            radioButtonLabelPosition: .right
        )
        groupView.delegate = self.radioButtonItemDelegate
        return groupView
    }()

    private var labelPosition: RadioButtonLabelPosition = .left {
        didSet {
            self.labelRadioButton.radioButtonLabelPosition = labelPosition
        }
    }

    private lazy var selectedValueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = self.label
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    private lazy var radioButtonItemDelegate = RadioButtonItemDelegate{
        self.backingSelectedID = $0
        self.selectedValueLabel.text = self.label
    }

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    private let scrollView = UIScrollView()

    private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var leftRightRadioButtonGroup: RadioButtonUIGroupView = {
        let leftLabel = NSAttributedStringBuilder()
            .text("Left")
            .symbol("arrowshape.left")
            .text("aligned", color: .orange)
            .build()

        let rightLabel = NSAttributedStringBuilder()
            .text("Right")
            .symbol("arrowshape.right")
            .text("aligned", color: .green)
            .build()

        let items: [RadioButtonUIItem<Bool>] = [
            RadioButtonUIItem(id: false,
                            label: leftLabel),
            RadioButtonUIItem(id: true,
                            label: rightLabel)
        ]

        let selectedPosition = Binding<Bool>(
            get: { return self.labelPosition == .right},
            set: { self.labelPosition = $0 ? .right : .left }
        )
        let groupView = RadioButtonUIGroupView(
            theme: self.theme,
            title: "Toggle Label Position",
            selectedID: self.labelPosition == .right,
            items: items,
            radioButtonLabelPosition: .right,
            groupLayout: .horizontal,
            state: .success,
            supplementaryText: "Supplementary Text"
        )

        groupView.publisher.sink { [weak self] item in
            self?.labelPosition = item ? .right : .left
        }.store(in: &self.subscriptions)

        return groupView
    }()

    private lazy var labelRadioButton: RadioButtonUIGroupView = {
        let items: [RadioButtonUIItem<Bool>] = [
            RadioButtonUIItem(id: true,
                            label: "Label")
        ]
        let selectedPosition = Binding<Bool>(
            get: { return true },
            set: { _ in }
        )
        let groupView = RadioButtonUIGroupView(
            theme: self.theme,
            selectedID: true,
            items: items,
            radioButtonLabelPosition: self.labelPosition,
            groupLayout: .horizontal
        )
        return groupView
    }()

    
    private lazy var radioButtonItems: [RadioButtonUIItem<String>] = [
        RadioButtonUIItem(id: "1",
                        label: "1 Lorem Ipsum is dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
        RadioButtonUIItem(id: "2",
                        label: .init("2 Radio button")),
        RadioButtonUIItem(id: "3",
                        label: .init("3 Radio button")),
        RadioButtonUIItem(id: "4",
                        label: .init("4 Radio button")),
        RadioButtonUIItem(id: "5",
                        label: .init("5 Radio button")),
        RadioButtonUIItem(id: "6",
                        label: .init("6 Radio button"))
    ]

    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupConstraints()
        self.setupSubscription()
    }

    // MARK: Private Methods
    private func setupView() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.scrollView)

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.addArrangedSubview(self.stateButton)
        stackView.addArrangedSubview(self.shuffleButton)
        stackView.addArrangedSubview(self.removeButton)

        self.contentView.addArrangedSubview(stackView)
        self.contentView.addArrangedSubview(self.radioButtonGroupView)
        self.contentView.addArrangedSubview(self.selectedValueLabel)
        self.contentView.addArrangedSubview(UIView())

        self.contentView
            .addArrangedSubview(self.leftRightRadioButtonGroup)

        self.contentView.addArrangedSubview(self.labelRadioButton)

        self.scrollView.addSubview(self.contentView)
    }

    private func setupSubscription() {
        self.themePublisher.$theme
            .sink { [weak self] theme in
                self?.radioButtonGroupView.theme = theme
                self?.labelRadioButton.theme = theme
                self?.leftRightRadioButtonGroup.theme = theme
            }
            .store(in: &self.subscriptions)
    }

    private func setupConstraints() {
        let constraints = [
            self.scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: Constants.width),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.padding),
            self.contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.padding),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc private func promptForState() {
        let alertController = UIAlertController(title: "State", message: nil, preferredStyle: .actionSheet)

        for state in RadioButtonGroupState.allCases {
            alertController.addAction(UIAlertAction(title: state.description, style: .default, handler: self.alertAction(_:)))
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive))

        present(alertController, animated: true)
    }

    @objc private func reshuffleItems() {
        let selections = [
            ["Cat", "Dog", "Horse", "Rabbit", "Goldfish", "Hamster"],
            ["Apple", "Grape", "Grapefruit", "Orange", "Lemon", "Banana", "Pear", "Cherry", "Plum", "Apricot"],
            ["Male", "Female", "Diverse"],
        ]

        var selectionGroups: [[RadioButtonUIItem<String>]] = selections.map { groups in
            groups.map { name in
                RadioButtonUIItem(id: name, label: name)
            }
        }
        selectionGroups.append(self.radioButtonItems)

        let newItems = selectionGroups[Int.random(in: 0..<selectionGroups.count)]

        radioButtonGroupView.items = newItems
    }

    @objc private func removeRandomItem() {
        if self.radioButtonGroupView.items.count > 2 {
            self.radioButtonGroupView.items.remove(at: Int.random(in: 0..<self.radioButtonGroupView.items.count))
        }
    }

    private func alertAction(_ action: UIAlertAction) {
        let state = action.title.flatMap(RadioButtonGroupState.fromDescription) ?? RadioButtonGroupState.enabled
        self.radioButtonGroupView.state = state
        self.radioButtonGroupView.supplementaryText = state.supplementaryLabel
        self.stateButton.setTitle(state.description, for: .normal)
    }
}

private extension RadioButtonGroupState {
    static func fromDescription(_ value: String) -> RadioButtonGroupState? {
        return self.allCases.first { state in
            state.description == value
        }
    }
}

private class RadioButtonItemDelegate: RadioButtonUIGroupViewDelegate {
    var action: (String) -> ()

    init(action: @escaping (String) -> ()) {
        self.action = action
    }

    func radioButtonGroup<ID>(_ radioButtonGroup: some Any, didChangeSelection item: ID) where ID : CustomStringConvertible, ID : Hashable {
        action(item.description)
    }
}

// MARK: - Preview

struct RadioButtonUIGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonUIGroup()
    }
}

private extension NSAttributedString {
    convenience init(_ label: String, _ trailingLabel: String, _ color: UIColor) {
        let attrStr = NSAttributedStringBuilder()
            .text(label)
            .symbol("chevron.right.2")
            .text(trailingLabel, color: color)
            .build()
        self.init(attributedString: attrStr)
    }
}

private class NSAttributedStringBuilder {
    private var nsAttributedString = NSMutableAttributedString()

    func text(_ label: String) -> Self {
        self.nsAttributedString.append(NSAttributedString(string: label))
        return self
    }

    func text(_ label: String, color: UIColor) -> Self {
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : color];
        self.nsAttributedString.append(NSAttributedString(string: label, attributes: attributedStringColor))
        return self
    }

    func symbol(_ imageName: String) -> Self {
        guard let image = UIImage(systemName: imageName) else { return self }
        let imageAttachment = NSTextAttachment(image: image)
        let imageString = NSAttributedString(attachment: imageAttachment)
        self.nsAttributedString.append(imageString)
        return self
    }

    func build() -> NSAttributedString {
        return nsAttributedString
    }
}
