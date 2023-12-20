//
//  Configurable.swift
//  SparkDemo
//
//  Created by alican.aycil on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import UIKit

protocol ComponentConfiguration {
    var theme: Theme {  get set }
}

protocol Configurable: AnyObject {
    associatedtype CellConfigartion: ComponentConfiguration
    associatedtype Component: UIView

    static var reuseIdentifier: String { get }
    var component: Component { get set }

    func configureCell(configuration: CellConfigartion)
    func setupView()
}

extension Configurable where Self: UITableViewCell {

    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }

    func setupView() {
        let stackView = UIStackView(arrangedSubviews: [self.component])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(stackView)

        let bottomAnchor: NSLayoutConstraint = stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        bottomAnchor.priority = .init(999)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            bottomAnchor
        ])
    }
}
