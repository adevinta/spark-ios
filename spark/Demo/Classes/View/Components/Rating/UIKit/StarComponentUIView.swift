//
//  StarComponentUIView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 08.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkCore
import Spark

final class StarComponentUIView: ComponentUIView {

    private var componentView: StarUIView!

    // MARK: - Properties
    private let viewModel: StarComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var sizeConstraints = [NSLayoutConstraint]()

    // MARK: - Initializer
    init(viewModel: StarComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeStarView(viewModel: viewModel)

        super.init(viewModel: viewModel, componentView: componentView)

        self.setupSubscriptions()
        self.sizeConstraints = [
            self.componentView.widthAnchor.constraint(equalToConstant: CGFloat(viewModel.frameSize)),
            self.componentView.heightAnchor.constraint(equalToConstant: CGFloat(viewModel.frameSize))
        ]

        NSLayoutConstraint.activate(self.sizeConstraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private static func makeStarView(viewModel: StarComponentUIViewModel) -> StarUIView {
        let configuration = StarConfiguration(
            numberOfVertices: viewModel.numberOfVertices,
            vertexSize: viewModel.vertexSize,
            cornerRadiusSize: viewModel.cornerRadiusSize)

        let view = StarUIView(
            rating: viewModel.rating,
            fillMode: viewModel.fillMode,
            lineWidth: CGFloat(viewModel.lineWidth),
            borderColor: viewModel.strokeColor.uiColor,
            fillColor: viewModel.fillColor.uiColor,
            configuration: configuration
        )

        return view
    }

    private func setupSubscriptions() {

        self.viewModel.$frameSize.subscribe(in: &self.cancellables) { [weak self] frameSize in
            self?.sizeConstraints.forEach{ constraint in
                constraint.constant = CGFloat(frameSize)
            }
        }

        self.viewModel.$cornerRadiusSize.subscribe(in: &self.cancellables) { [weak self] cornerRadiusSize in
            self?.componentView.cornerRadiusSize = cornerRadiusSize
        }

        self.viewModel.$vertexSize.subscribe(in: &self.cancellables) { [weak self] vertexSize in
            self?.componentView.vertexSize = vertexSize
        }

        self.viewModel.$rating.subscribe(in: &self.cancellables) { [weak self] rating in
            self?.componentView.rating = rating
        }

        self.viewModel.$fillColor.subscribe(in: &self.cancellables) { [weak self] fillColor in
            self?.componentView.fillColor = fillColor.uiColor
            self?.viewModel.starFillColorConfigurationItemViewModel.buttonTitle = fillColor.name
        }

        self.viewModel.$strokeColor.subscribe(in: &self.cancellables) { [weak self] strokeColor in
            self?.componentView.borderColor = strokeColor.uiColor
            self?.viewModel.starStrokeColorConfigurationItemViewModel.buttonTitle = strokeColor.name

        }

        self.viewModel.$fillMode.subscribe(in: &self.cancellables) { [weak self] starFillMode in
            self?.componentView.fillMode = starFillMode
            self?.viewModel.starFillModeConfigurationItemViewModel.buttonTitle = starFillMode.name
        }

        self.viewModel.$lineWidth.subscribe(in: &self.cancellables) { [weak self] lineWidth in
            self?.componentView.lineWidth = CGFloat(lineWidth)
        }

        self.viewModel.$numberOfVertices.subscribe(in: &self.cancellables) { [weak self] points in
            self?.componentView.numberOfVertices = points
        }

        self.viewModel.$cornerRadiusSize.subscribe(in: &self.cancellables) { [weak self] cornerRadius in
            self?.componentView.cornerRadiusSize = cornerRadius
        }
    }
}
