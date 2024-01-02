//
//  StarCell.swift
//  SparkDemo
//
//  Created by alican.aycil on 19.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SparkCore

final class StarCell: UITableViewCell, Configurable {

    typealias CellConfigartion = StarCellConfiguration
    typealias Component = StarUIView

    lazy var component: StarUIView = {
        let configuration = StarConfiguration(
            numberOfVertices: 5,
            vertexSize: CGFloat(0.65),
            cornerRadiusSize: CGFloat(0.15)
        )
        let view = StarUIView(
            rating: CGFloat(0.5),
            fillMode: StarFillMode.half,
            lineWidth: 2,
            borderColor: UIColor.blue,
            fillColor: UIColor.lightGray,
            configuration: configuration
        )
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()

        NSLayoutConstraint.activate([
            self.component.widthAnchor.constraint(equalToConstant: 50),
            self.component.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(configuration: CellConfigartion) {
        self.component.fillColor = configuration.fillColor
        self.component.borderColor = configuration.borderColor
        self.component.numberOfVertices = configuration.numberOfVertices
        self.component.fillMode = configuration.fillMode
    }
}
