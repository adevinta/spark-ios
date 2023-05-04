//
//  ChipComponentUIView.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 21.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct ChipComponentUIView: View {

    var body: some View {
        ChipComponentUIViewRepresentation()
            .navigationBarTitle(Text("Chip (UIKit)"))
    }
}

struct ChipComponentUIViewRepresentation: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ChipComponentUIViewController {
        return ChipComponentUIViewController()
    }

    func updateUIViewController(_ uiViewController: ChipComponentUIViewController, context: Context) {

    }
}

final class ChipComponentUIViewController: UIViewController {

    let theme = SparkTheme.shared

    private let scrollView = UIScrollView()


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        scrollView.contentSize = CGSize(width:5000, height: 5678)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground

        self.title = "Chip"

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.frame = view.bounds


        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.backgroundColor = .clear

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4


        for intent in ChipIntentColor.allCases {
            stackView.addArrangedSubview(bigLabel("\(intent)"))
            stackView.addArrangedSubview(chipDesign(intent: intent))
        }

        scrollView.addSubview(stackView)

        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func chipDesign(intent: ChipIntentColor) -> UIView {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 8
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.axis = .vertical

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

        for variant in ChipVariant.allCases {
            stackView.addArrangedSubview(label( "Variant: .\(variant)"))
            stackView.addArrangedSubview(chipStyles(intent: intent, variant: variant))
        }

        return stackView
    }

    private func label(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }

    private func bigLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text.uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .lightGray
        return label
    }

    private func chipStyles(intent: ChipIntentColor,
                            variant: ChipVariant) ->  UIView {
        let icon = UIImage(imageLiteralResourceName: "alert")
        let stackView = UIStackView(
            arrangedSubviews: [
                ChipUIView(
                    theme: theme,
                    intentColor: intent,
                    variant: variant,
                    label: "Only label"
                ),
                ChipUIView(
                    theme: theme,
                    intentColor: intent,
                    variant: variant,
                    label: "Leading icon",
                    iconImage: icon),
                ChipUIView(
                    theme: theme,
                    intentColor: intent,
                    variant: variant,
                    iconImage: icon)
            ]
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .horizontal
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }
}

struct RadioButtonUIGroup_Previews: PreviewProvider {
    static var previews: some View {
        ChipComponentUIView()
    }
}
