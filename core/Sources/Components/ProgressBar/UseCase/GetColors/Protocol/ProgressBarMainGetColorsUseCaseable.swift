//
//  ProgressBarMainGetColorsUseCaseable.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable, AutoMockTest
protocol ProgressBarMainGetColorsUseCaseable {
    associatedtype Intent: Equatable
    associatedtype Return: Equatable

    // sourcery: colors = "Identical", dims = "Identical"
    func execute(intent: Intent,
                 colors: Colors,
                 dims: Dims) -> Return
}
