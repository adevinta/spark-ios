//
//  IconComponentUIView.swift
//  SparkDemo
//
//  Created by Jacklyn Situmorang on 19.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI

struct IconComponentUIView: View {

    var body: some View {
        IconUIViewControllerReperesentation()
            .navigationBarTitle(Text("UIKit Icon"))
    }
}

struct IconUIViewControllerReperesentation: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        IconComponentUIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

}

final class IconComponentUIViewController: UIViewController {

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

    private var selectedSize: IconSize = .small {
        didSet {
            for icon in icons {
                icon.size = selectedSize
            }
        }
    }

    private var icons = [IconUIView]()
    private var cancellables = Set<AnyCancellable>()

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(scrollView)
        self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        self.scrollView.addSubview(contentView)
        self.contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        self.contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        setupSegmentedControl()
        setupView()
        subscribe()
    }

    private func setupSegmentedControl() {
        let segmentedControl = UISegmentedControl(
            items: ["sm", "md", "lg", "xl"]
        )

        self.view.addSubview(segmentedControl)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true

        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(sender:)), for: .valueChanged)
    }

    @objc
    func segmentedControlValueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.selectedSize = .small
        case 1:
            self.selectedSize = .medium
        case 2:
            self.selectedSize = .large
        case 3:
            self.selectedSize = .extraLarge
        default:
            break
        }
    }

    private func setupView() {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.spacing = 10

        self.contentView.addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70).isActive = true
        vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        let iconImage = UIImage(systemName: "lock.circle")

        for intent in IconIntent.allCases {
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.spacing = 5

            let label = UILabel()
            label.text = "\(intent)"

            let icon = IconUIView(
                iconImage: iconImage,
                theme: theme,
                intent: intent,
                size: .small
            )
            icon.translatesAutoresizingMaskIntoConstraints = false
            self.icons.append(icon)

            hStack.addArrangedSubview(icon)
            hStack.addArrangedSubview(label)

            vStack.addArrangedSubview(hStack)
        }

    }

    private func subscribe() {
        themePublisher.$theme
            .sink { [weak self] newTheme in
                guard let self else { return }

                for icon in icons {
                    icon.theme = newTheme
                }
            }
            .store(in: &cancellables)
    }
}
