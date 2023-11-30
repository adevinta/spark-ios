//
//  SliderComponentUIViewModel.swift
//  SparkDemo
//
//  Created by louis.borlee on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class SliderComponentUIViewModel: ObservableObject {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        self.showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[SliderIntent], Never> {
        self.showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showSizeSheet: AnyPublisher<[SliderShape], Never> {
        self.showShapeSheetSubject
            .eraseToAnyPublisher()
    }

    let themes = ThemeCellModel.themes

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[SliderIntent], Never> = .init()
    private var showShapeSheetSubject: PassthroughSubject<[SliderShape], Never> = .init()

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: SliderIntent
    @Published var shape: SliderShape

    init(
        theme: Theme,
        intent: SliderIntent = .main,
        shape: SliderShape = .rounded
    ) {
        self.theme = theme
        self.intent = intent
        self.shape = shape
    }
}

// MARK: - Navigation
extension SliderComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(self.themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(SliderIntent.allCases)
    }

    @objc func presentSizeSheet() {
        self.showShapeSheetSubject.send(SliderShape.allCases)
    }
}
