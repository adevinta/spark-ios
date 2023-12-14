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

        NSLayoutConstraint.stickEdges(
            from: stackView,
            to: self.contentView,
            insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        )
    }
}
