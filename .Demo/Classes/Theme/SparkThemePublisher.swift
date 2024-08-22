//
//  SparkThemePublisher.swift
//  SparkDemo
//
//  Created by louis.borlee on 05/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SparkCore

public class SparkThemePublisher: ObservableObject {
    public static let shared = SparkThemePublisher()

    private init() {}

    @Published public var theme: Theme = SparkTheme.shared
}
