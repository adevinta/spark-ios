//
//  Spinner-UIViewControllerRepresentable.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 07.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import Spark
import SparkCore
import SwiftUI

// MARK: SwiftUI Representable
struct SpinnerUI: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SpinnerViewController {
        return SpinnerViewController()
    }

    func updateUIViewController(_ uiViewController: SpinnerViewController, context: Context) { }
}


final class SpinnerViewController: UIViewController {

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    private var isSpinning: Bool = false

    var theme: Theme {
        self.themePublisher.theme
    }

    private lazy var spinner: UIView = {
        let view = SpinnerUIView(theme: self.theme)
        view.start()
        return view
    }()

    private let scrollView = UIScrollView()
    
    private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Hello World"
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.scrollView)

        self.contentView.addArrangedSubview(self.spinner)
        self.contentView.addArrangedSubview(self.label)
        self.contentView.addArrangedSubview(UIView())


        self.scrollView.addSubview(self.contentView)

        let constraints = [
            self.scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 100),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

struct SpinnerUI_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerUI()
    }
}
