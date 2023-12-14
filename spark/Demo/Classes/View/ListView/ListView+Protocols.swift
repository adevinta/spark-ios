//
//  Configurable.swift
//  SparkDemo
//
//  Created by alican.aycil on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import UIKit

protocol Configuration {
    var theme: Theme {  get set }
}

protocol Configurable: AnyObject {
    associatedtype CellConfigartion: Configuration
    associatedtype Component: UIView
    var component: Component { get set }
    func configureCell(configuration: CellConfigartion)
}

extension Configurable where Self: UITableViewCell {

    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }

    private var stackView: UIStackView {
        let stackView = UIStackView(arrangedSubviews: [self.component])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    init() {
        self.setupView()
    }

    private func setupView() {
        self.contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
}
