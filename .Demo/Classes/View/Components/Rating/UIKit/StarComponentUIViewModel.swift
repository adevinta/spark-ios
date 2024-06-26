//
//  StarComponentUIViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 08.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

import Combine
import Foundation
import UIKit
import SparkCore

final class StarComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties
    var showStarFillColorSheet: AnyPublisher<[StarColor], Never> {
        showStarFillColorSheetSubject
            .eraseToAnyPublisher()
    }

    var showStarStrokeColorSheet: AnyPublisher<[StarColor], Never> {
        showStarStrokeColorSheetSubject
            .eraseToAnyPublisher()
    }

    var showStarFillModeSheet: AnyPublisher<[StarFillMode], Never> {
        showStarFillModeSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Items Properties
    private var showStarStrokeColorSheetSubject: PassthroughSubject<[StarColor], Never> = .init()
    private var showStarFillColorSheetSubject: PassthroughSubject<[StarColor], Never> = .init()
    private var showStarFillModeSheetSubject: PassthroughSubject<[StarFillMode], Never> = .init()

    lazy var starStrokeColorConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        let viewModel = ComponentsConfigurationItemUIViewModel(
            name: "Stroke color",
            type: .button,
            target: (source: self, action: #selector(self.presentStarStrokeColorSheet))
        )
        viewModel.buttonTitle = self.strokeColor.name
        return viewModel
    }()

    lazy var starFillColorConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        let viewModel = ComponentsConfigurationItemUIViewModel(
            name: "Fill color",
            type: .button,
            target: (source: self, action: #selector(self.presentStarFillColorSheet))
        )
        viewModel.buttonTitle = self.fillColor.name
        return viewModel
    }()

    lazy var starFillModeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        let viewModel = ComponentsConfigurationItemUIViewModel(
            name: "Fill mode",
            type: .button,
            target: (source: self, action: #selector(self.presentStarFillModeSheet))
        )

        viewModel.buttonTitle = self.fillMode.name
        return viewModel
    }()

    lazy var numberOfVerticesConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Number of vertices",
            type: .rangeSelector(
                selected: self.numberOfVertices,
                range: 4...10
            ),
            target: (source: self, action: #selector(self.numberOfVerticesChanged)))
    }()

    lazy var frameSizeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Frame size",
            type: .rangeSelectorWithConfig(
                selected: self.frameSize,
                range: 10...100,
                stepper: 10,
                numberFormatter: NumberFormatter()
            ),
            target: (source: self, action: #selector(self.frameSizeChanged)))
    }()

    lazy var ratingConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Rating",
            type: .rangeSelectorWithConfig(
                selected: Int(self.rating * 20),
                range: 0...20,
                stepper: 1,
                numberFormatter: NumberFormatter()
                    .multipling(0.05)
                    .maximizingFractionDigits(2)
            ),
            target: (source: self, action: #selector(self.ratingChanged)))
    }()

    lazy var lineWidthConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Line Width",
            type: .rangeSelector(
                selected: self.lineWidth,
                range: 1...15
            ),
            target: (source: self, action: #selector(self.lineWidthChanged)))
    }()

    lazy var vertexSizeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Vertex size",
            type: .rangeSelectorWithConfig(
                selected: Int(self.vertexSize * 20),
                range: 0...20,
                stepper: 1,
                numberFormatter: NumberFormatter()
                    .multipling(0.05)
                    .maximizingFractionDigits(2)
            ),
            target: (source: self, action: #selector(self.vertexSizeChanged)))
    }()

    lazy var cornerRadiusSizeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Corner radius size",
            type: .rangeSelectorWithConfig(
                selected: Int(self.cornerRadiusSize * 20),
                range: 0...20,
                stepper: 1,
                numberFormatter: NumberFormatter()
                    .multipling(0.05)
                    .maximizingFractionDigits(2)
            ),
            target: (source: self, action: #selector(self.cornerRadiusSizeChanged)))
    }()

    // MARK: - Methods
    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            starStrokeColorConfigurationItemViewModel,
            starFillColorConfigurationItemViewModel,
            starFillModeConfigurationItemViewModel,
            numberOfVerticesConfigurationItemViewModel,
            ratingConfigurationItemViewModel,
            lineWidthConfigurationItemViewModel,
            vertexSizeConfigurationItemViewModel,
            cornerRadiusSizeConfigurationItemViewModel,
            frameSizeConfigurationItemViewModel
        ]
    }

    // MARK: - Published Properties
    @Published var numberOfVertices = 5
    @Published var fillMode = StarFillMode.half
    @Published var rating = CGFloat(0.5)
    @Published var lineWidth = 2
    @Published var vertexSize = CGFloat(0.65)
    @Published var cornerRadiusSize = CGFloat(0.15)
    @Published var fillColor = StarColor.blue
    @Published var strokeColor = StarColor.lightGray
    @Published var frameSize = 100

    // MARK: - Initialization
    init() {
        super.init(identifier: "Rating Star")
    }

}

// MARK: - Navigation
extension StarComponentUIViewModel {

    @objc func presentStarFillColorSheet() {
        self.showStarFillColorSheetSubject.send(StarColor.allCases)
    }

    @objc func presentStarStrokeColorSheet() {
        self.showStarStrokeColorSheetSubject.send(StarColor.allCases)
    }

    @objc func presentStarFillModeSheet() {
        self.showStarFillModeSheetSubject.send(StarFillMode.allCases)
    }

    @objc func numberOfVerticesChanged(_ control: NumberSelector) {
        self.numberOfVertices = control.selectedValue
    }

    @objc func frameSizeChanged(_ control: NumberSelector) {
        self.frameSize = control.selectedValue
    }

    @objc func lineWidthChanged(_ control: NumberSelector) {
        self.lineWidth = control.selectedValue
    }

    @objc func ratingChanged(_ control: NumberSelector) {
        self.rating = CGFloat(control.selectedValue) / 20.0
    }

    @objc func vertexSizeChanged(_ control: NumberSelector) {
        self.vertexSize = CGFloat(control.selectedValue) / 20.0
    }

    @objc func cornerRadiusSizeChanged(_ control: NumberSelector) {
        self.cornerRadiusSize = CGFloat(control.selectedValue) / 20.0
    }
}

// MARK: - Private helpers
enum StarColor: CaseIterable {
    case black
    case blue
    case clear
    case darkGray
    case gray
    case green
    case lightGray
    case orange
    case red
    case yellow

    var uiColor: UIColor {
        switch self {
        case .black: return .black
        case .blue: return .blue
        case .clear: return .clear
        case .darkGray: return .darkGray
        case .gray: return .gray
        case .green: return .green
        case .lightGray: return .lightGray
        case .orange: return .orange
        case .red: return .red
        case .yellow: return .yellow
        }
    }
}

extension StarFillMode: CaseIterable {
    public static var allCases: [SparkCore.StarFillMode] {
        [.full, .half, .fraction(10), .exact]
    }

    var name: String {
        switch self {
        case .full: return "Full"
        case .half: return "Half"
        case let .fraction(fraction): return "Fraction(\(fraction))"
        case .exact: return "Exact"
        }
    }
}
