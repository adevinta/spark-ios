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
        ZStack {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            ChipComponentUIViewRepresentation()
                .navigationBarTitle(Text("Chip (UIKit)"))

        }
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

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.backgroundColor = .clear

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .secondarySystemBackground

        self.view.addSubview(scrollView)
        self.scrollView.frame = self.view.bounds
        self.scrollView.addSubview(self.stackView)

        setupView()
        setupConstraints()
    }

    private func setupView() {
        for intent in ChipIntentColor.allCases {
            self.stackView.addArrangedSubview(spacer(height: 4))
            self.stackView.addArrangedSubview(bigLabel("\(intent)"))
            self.stackView.addArrangedSubview(chipDesign(intent: intent))
        }


        self.stackView.addArrangedSubview(spacer(height: 4))
        self.stackView.addArrangedSubview(bigLabel("Chip with action"))
        self.stackView.addArrangedSubview(chipWithComponent())
    }

    private func setupConstraints() {
        let constraints = [
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            self.stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            self.stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func chipDesign(intent: ChipIntentColor) -> UIView {
        let stackView = UIStackView()
        stackView.backgroundColor = .lightText
        stackView.layer.cornerRadius = 8
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.axis = .vertical

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        var spacer: UIView?
        for variant in ChipVariant.allCases {

            if let spacer = spacer {
                stackView.addArrangedSubview(spacer)
            }
            stackView.addArrangedSubview(label( "Variant: .\(variant)"))
            stackView.addArrangedSubview(chipStyles(intent: intent, variant: variant))

            spacer = lineSpacer()
        }

        return stackView
    }

    private func chipWithComponent() -> UIView {
        let icon = UIImage(imageLiteralResourceName: "alert")

        let chip = ChipUIView(theme: theme,
                          intentColor: .primary,
                          variant: .filled,
                          label: "Not selected",
                          iconImage: icon)
        let component = UIImageView(image: UIImage.strokedCheckmark)

        var selected = false
        chip.action = {
            selected.toggle()
            if selected {
                chip.text = "Selected"
                chip.component = component
                chip.variant = .tinted
            } else {
                chip.component = nil
                chip.text = "Not selected"
                chip.variant = .filled
            }
        }

        return chip
    }

    private func lineSpacer() -> UIView {
        let lineSpacer = UIView()
        lineSpacer.translatesAutoresizingMaskIntoConstraints = false
        lineSpacer.heightAnchor.constraint(equalToConstant: 2).isActive = true
        lineSpacer.backgroundColor = .secondarySystemBackground
        return lineSpacer
    }

    private func spacer(height: CGFloat) -> UIView {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true
        return spacer
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
        let chips: [ChipUIView] = [
            .init(
                theme: theme,
                intentColor: intent,
                variant: variant,
                label: "Only label"
            ),
            .init(
                theme: theme,
                intentColor: intent,
                variant: variant,
                label: "Leading icon",
                iconImage: icon),
            .init(
                theme: theme,
                intentColor: intent,
                variant: variant,
                iconImage: icon)
        ]
        chips.forEach{ $0.action = {} }

        let stackView = UIStackView(
            arrangedSubviews: chips
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .horizontal
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }
}

struct ChipComponentUI_Previews: PreviewProvider {
    static var previews: some View {
        ChipComponentUIView()
    }
}
