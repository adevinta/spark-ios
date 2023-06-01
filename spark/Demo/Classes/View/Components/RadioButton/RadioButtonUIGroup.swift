//
//  RadioButtonUIKitGroup.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 21.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

// MARK: SwiftUI Representable
struct RadioButtonUIGroup: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RadioButtionUIGroupViewController {
        return RadioButtionUIGroupViewController()
    }

    func updateUIViewController(_ uiViewController: RadioButtionUIGroupViewController, context: Context) { }
}

final class RadioButtionUIGroupViewController: UIViewController {

    // MARK: - Constant definitions

    private enum Constants {
        static let width: CGFloat = 40
        static let padding: CGFloat = 20
    }

    // MARK: - Properies

    private var backingSelectedId: String = "1"

    private var label: String {
        "Selected Value \(self.backingSelectedId)"
    }

    private lazy var radioButtonView: RadioButtonUIGroupView = {
        let groupView = RadioButtonUIGroupView(
            theme: self.theme,
            title: "Radio Button Group (UIKit)",
            selectedID: self.selectedId,
            items: self.radioButtonItems,
            radioButtonLabelPosition: .right
        )
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

    lazy var selectedId: Binding<String> = Binding<String>(
        get: {
            return self.backingSelectedId
        },
        set: {
            self.backingSelectedId = $0
            self.selectedValueLabel.text = self.label
        }
    )
    let theme = SparkTheme.shared

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
        let items: [RadioButtonItem<Bool>] = [
            RadioButtonItem(id: false,
                            label: "Left"),
            RadioButtonItem(id: true,
                            label: "Right")
        ]
        let selectedPosition = Binding<Bool>(
            get: { return self.labelPosition == .right},
            set: { self.labelPosition = $0 ? .right : .left }
        )
        let groupView = RadioButtonUIGroupView(
            theme: self.theme,
            title: "Toggle Label Position",
            selectedID: selectedPosition,
            items: items,
            radioButtonLabelPosition: .right,
            groupLayout: .horizontal
        )
        return groupView
    }()

    private lazy var labelRadioButton: RadioButtonUIGroupView = {
        let items: [RadioButtonItem<Bool>] = [
            RadioButtonItem(id: true,
                            label: "Label")
        ]
        let selectedPosition = Binding<Bool>(
            get: { return true },
            set: { _ in }
        )
        let groupView = RadioButtonUIGroupView(
            theme: self.theme,
            selectedID: selectedPosition,
            items: items,
            radioButtonLabelPosition: self.labelPosition,
            groupLayout: .horizontal
        )
        return groupView
    }()

    
    private lazy var radioButtonItems: [RadioButtonItem<String>] = [
        RadioButtonItem(id: "1",
                        label: "1 Lorem Ipsum is dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
        RadioButtonItem(id: "2",
                        label: "2 Radio button / Enabled",
                        state: .enabled),
        RadioButtonItem(id: "3",
                        label: "3 Radio button / Disabled",
                        state: .disabled),
        RadioButtonItem(id: "4",
                        label: "4 Radio button / Error",
                        state: .error(message: "Error")),
        RadioButtonItem(id: "5",
                        label: "5 Radio button / Success",
                        state: .success(message: "Success")),
        RadioButtonItem(id: "6",
                        label: "6 Radio button / Warning",
                        state: .warning(message: "Warning")),
    ]

    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupConstraints()
    }

    // MARK: Private Methods
    private func setupView() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.scrollView)

        self.contentView.addArrangedSubview(self.radioButtonView)
        self.contentView.addArrangedSubview(self.selectedValueLabel)
        self.contentView.addArrangedSubview(UIView())

        self.contentView
            .addArrangedSubview(self.leftRightRadioButtonGroup)

        self.contentView.addArrangedSubview(self.labelRadioButton)

        self.scrollView.addSubview(self.contentView)
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
}

// MARK: - Preview

struct RadioButtonUIGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonUIGroup()
    }
}
