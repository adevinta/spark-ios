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

struct RadioButtonUIGroup: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RadioButtionUIGroupViewController {
        return RadioButtionUIGroupViewController()
    }

    func updateUIViewController(_ uiViewController: RadioButtionUIGroupViewController, context: Context) {

    }
}

final class RadioButtionUIGroupViewController: UIViewController {

    private var backingSelectedId: String = "1"
    private lazy var selectedValueLabel = UIView.label("Selected Value \(backingSelectedId)")
    lazy var selectedId: Binding<String> = Binding<String>(
        get: {
            return self.backingSelectedId
        },
        set: {
            self.backingSelectedId = $0
            self.selectedValueLabel.text = "Selected Value \(self.backingSelectedId)"
        }
    )
    let theme = SparkTheme.shared

    private let scrollView = UIScrollView()

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

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)




        let radioButtonView = RadioButtonUIGroupView(
            theme: theme,
            title: "Radio Button Group (UIKit)",
            selectedID: selectedId,
            items: radioButtonItems)


        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.alignment = .center
        contentView.spacing = 24

        contentView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addArrangedSubview(radioButtonView)

        contentView.addArrangedSubview(self.selectedValueLabel)

        contentView.addArrangedSubview(UIView())

        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 40),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

private extension UIView {
    static func label(_ title: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = title
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }
}

struct RadioButtonUIGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonUIGroup()
    }
}
