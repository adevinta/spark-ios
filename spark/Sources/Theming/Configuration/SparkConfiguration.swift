//
//  SparkConfiguration.swift
//  Spark
//
//  Created by robin.lemaire on 02/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import Foundation
import UIKit

public struct SparkConfiguration {

    // MARK: - Subclass

    private class Class {}

    private static var didLoad = false

    // MARK: - static func

    public static func load() {
        guard !self.didLoad else { return }
        self.didLoad = true

        Bundle(for: Class.self).registerAllFonts()
    }
}
